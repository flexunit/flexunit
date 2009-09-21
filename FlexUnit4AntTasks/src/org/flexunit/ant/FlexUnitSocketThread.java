package org.flexunit.ant;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.text.MessageFormat;
import java.util.Map;
import java.util.concurrent.Callable;

import org.apache.tools.ant.BuildException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

public class FlexUnitSocketThread implements Callable<Object>
{
   // Messages from CIListener
   private static final String END_OF_SUCCESS = "status='success'/>";
   private static final String END_OF_FAILURE = "</testcase>";
   private static final String END_OF_IGNORE = "<skipped /></testcase>";

   // Test Completion Messages
   private static final String START_OF_TEST_RUN_ACK = "<startOfTestRunAck/>";
   private static final String END_OF_TEST_RUN = "<endOfTestRun/>";
   private static final String END_OF_TEST_RUN_ACK = "<endOfTestRunAck/>";
   private static final char NULL_BYTE = '\u0000';

   // Domain and policy request formats
   private static final String POLICY_FILE_REQUEST = "<policy-file-request/>";
   private static final String DOMAIN_POLICY = "<cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"{0}\" /></cross-domain-policy>";

   // XML attribute labels
   private static final String SUITE_ATTRIBUTE = "@classname";

   private boolean useLogging;
   private int port;
   private int socketTimeout;
   private File reportDir;
   private boolean waitForPolicyFile;

   private ServerSocket serverSocket = null;
   private Socket clientSocket = null;
   private InputStream in = null;
   private OutputStream out = null;
   private Map<String, Report> reports;

   public FlexUnitSocketThread(int port, int socketTimeout, boolean useLogging, File reportDir, Map<String, Report> reports, boolean waitForPolicyFile)
   {
      this.port = port;
      this.socketTimeout = socketTimeout;
      this.useLogging = useLogging;
      this.reportDir = reportDir;
      this.reports = reports;
      this.waitForPolicyFile = waitForPolicyFile;
   }

   public Object call() throws Exception
   {
      try
      {
         openServerSocket();
         openClientSocket();
         prepareClientSocket();
         handleClientConnection();
      }
      catch (BuildException buildException)
      {
         try
         {
            sendTestRunEndAcknowledgement();
         }
         catch (IOException e)
         {
            // coudl not stop test run
            throw buildException;
         }
      }
      catch (SocketTimeoutException e)
      {
         throw new BuildException("socket timeout waiting for flexunit report", e);
      }
      catch (IOException e)
      {
         throw new BuildException("error receiving report from flexunit", e);
      }
      finally
      {
         try
         {
            closeClientSocket();
            closeServerSocket();
         }
         catch (IOException e)
         {
            throw new BuildException("could not close client/server socket");
         }
      }

      return null;
   }

   /**
    * Creates a connection on the specified socket. Waits {socketTimeout}
    * seconds for a client connection before throwing an error
    * 
    * @throws IOException
    */
   private void openServerSocket() throws IOException
   {
      serverSocket = new ServerSocket(port);
      serverSocket.setSoTimeout(socketTimeout);

      if (useLogging)
      {
         log("opened server socket");
      }
   }

   /**
    * Creates the client connection. This method will pause until the connection
    * is made or the timout limit is reached.
    * 
    * Once a connection is established opens the in and out buffer.
    * 
    * @throws IOException
    */
   private void openClientSocket() throws IOException
   {
      // This method blocks until a connection is made.
      clientSocket = serverSocket.accept();

      if (useLogging)
      {
         log("accepting data from client");
      }

      in = new BufferedInputStream(clientSocket.getInputStream());
      out = new BufferedOutputStream(clientSocket.getOutputStream());
   }

   private void sendTestRunStartAcknowledgement() throws IOException
   {
      out.write(START_OF_TEST_RUN_ACK.getBytes());
      out.write(NULL_BYTE);
      out.flush();

      if (useLogging)
      {
         log("start of test run");
      }
   }

   /**
    * Closes the client connection and all buffers, ignoring any errors
    */
   private void closeClientSocket() throws IOException
   {
      // Close the output stream.
      if (out != null)
      {
         out.close();
      }

      // Close the input stream.
      if (in != null)
      {
         in.close();
      }

      // Close the client socket.
      if (clientSocket != null)
      {
         clientSocket.close();
      }
   }

   /**
    * Closes the server socket. Ignores any errors if unable to close
    */
   private void closeServerSocket() throws IOException
   {
      if (serverSocket != null)
      {
         serverSocket.close();
      }
   }

   /**
    * Decides whether to send a policy request or a start ack
    */
   private void prepareClientSocket() throws IOException
   {
      // if it's a policy request, make sure the first thing we send is a policy response
      if (waitForPolicyFile)
      {
         String request = readNextTokenFromSocket();
         if (request.equals(POLICY_FILE_REQUEST))
         {
            sendPolicyFile();
            resetClientConnection();
         }
      }

      //tell client to start the testing process
      sendTestRunStartAcknowledgement();
   }

   /**
    * Reads tokens from the socket input stream based on NULL_BYTE as a delimiter
    * @return
    * @throws IOException
    */
   private String readNextTokenFromSocket() throws IOException
   {
      StringBuffer buffer = new StringBuffer();
      int piece = -1;

      while ((piece = in.read()) != NULL_BYTE)
      {
         if (piece == -1)
         {
            return null;
         }

         final char chr = (char) piece;
         buffer.append(chr);
      }

      return buffer.toString();
   }

   /**
    * Used to iterate and interpret byte sent over the socket.
    */
   private void handleClientConnection() throws IOException
   {
      String request = null;

      while ((request = readNextTokenFromSocket()) != null)
      {
         // If the string is a failure, process the report
         if (request.endsWith(END_OF_FAILURE) || request.endsWith(END_OF_SUCCESS) || request.endsWith(END_OF_IGNORE))
         {
            processTestReport(request);
         }

         // If the string is the end of the test run, close connection and
         // verify build status
         else if (request.startsWith(END_OF_TEST_RUN))
         {
            sendTestRunEndAcknowledgement();
            return;
         }
         else
         {
            throw new BuildException("command [" + request + "] not understood");
         }
      }
   }

   /**
    * Send domain policy
    * 
    * @throws IOException
    */
   private void sendPolicyFile() throws IOException
   {
      out.write(MessageFormat.format(DOMAIN_POLICY, new Object[] { Integer.toString(port) }).getBytes());
      out.write(NULL_BYTE);

      if (useLogging)
      {
         log("sent policy file");
      }
   }

   /**
    * Resets the client connection.
    */
   private void resetClientConnection() throws IOException
   {
      closeClientSocket();
      openClientSocket();
   }

   /**
    * Process the test report.
    * 
    * @param report
    *           String that represents a complete test
    */
   private void processTestReport(String xml)
   {
      // Convert the string report into an XML document
      Document test = parseReport(xml);

      // Find the name of the suite
      String suiteName = test.getRootElement().valueOf(SUITE_ATTRIBUTE);

      // Convert all instances of :: for file support
      suiteName = suiteName.replaceAll("::", ".");

      if (!reports.containsKey(suiteName))
      {
         reports.put(suiteName, new Report(useLogging, new Suite(suiteName)));
      }

      // Fetch report, add test, and write to disk
      Report report = reports.get(suiteName);
      report.addTest(test);

      report.save(reportDir);
   }

   /**
    * Parse the parameter String and returns it as a document
    * 
    * @param report
    *           String
    * @return Document
    */
   private Document parseReport(String report)
   {
      try
      {
         final Document document = DocumentHelper.parseText(report);

         return document;
      }
      catch (DocumentException e)
      {
         log(report);
         throw new BuildException("Error parsing report.", e);
      }
   }

   /**
    * Sends the end of test run to the listener to close the connection
    * 
    * @throws IOException
    */
   private void sendTestRunEndAcknowledgement() throws IOException
   {
      out.write(END_OF_TEST_RUN_ACK.getBytes());
      out.write(NULL_BYTE);
      out.flush();

      if (useLogging)
      {
         log("end of test run");
      }
   }

   /**
    * Shorthand console message
    * 
    * @param message
    *           String to print
    */
   public void log(final String message)
   {
      System.out.println(message);
   }
}
