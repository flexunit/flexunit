package org.flexunit.ant.tasks;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.text.MessageFormat;
import java.util.ArrayList;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.flexunit.ant.FlexUnitLauncher;
import org.flexunit.ant.Suite;

public class FlexUnitTask extends Task
{
   // Messages from CIListener
   private static final String END_OF_SUCCESS = "status='success'/>";
   private static final String END_OF_FAILURE = "</testcase>";
   private static final String END_OF_IGNORE = "<skipped /></testcase>";
   private static final String FAILURE = "failure";
   private static final String ERROR = "error";
   private static final String IGNORE = "ignore";
   private static final String TEST_SUITE = "testsuite";
   private static final String NAME_ATTRIBUTE_LABEL = "name";
   private static final String FAILURE_ATTRIBUTE_LABEL = "failures";
   private static final String ERROR_ATTRIBUTE_LABEL = "errors";
   private static final String IGNORE_ATTRIBUTE_LABEL = "skipped";
   private static final String TIME_ATTRIBUTE_LABEL = "time";
   private static final String TESTS_ATTRIBUTE_LABEL = "tests";

   // Test Completion Messages
   private static final String END_OF_TEST_RUN = "<endOfTestRun/>";
   private static final String END_OF_TEST_ACK = "<endOfTestRunAck/>";
   private static final char NULL_BYTE = '\u0000';
   private static final String FILENAME_PREFIX = "TEST-";
   private static final String FILENAME_EXTENSION = ".xml";

   // XML attribute labels
   private static final String NAME_ATTRIBUTE = "@name";
   private static final String SUITE_ATTRIBUTE = "@classname";
   private static final String STATUS_ATTRIBUTE = "@status";

   // Domain and policy request formats
   private static final String POLICY_FILE_REQUEST = "<policy-file-request/>";
   private static final String DOMAIN_POLICY = "<cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"{0}\" /></cross-domain-policy>";

   private static final String TRUE = "true";

   // Verbose messages
   private static final String SENT_POLICY = "sent policy file";
   private static final String TEST_INFO = " Suite: {0} - Tests run: {1}, Failures: {2}, Errors: {3}";

   // Exception messages
   private static final String FAILED_TEST = "FlexUnit test {0} in suite {1} failed.";
   private static final String ERRORED_TEST = "FlexUnit test {0} in suite {1} had errors.";
   private static final String IGNORED_TEST = "FlexUnit test {0} in suite {1} was ignored.";
   private static final String ERROR_PARSING_REPORT = "Error parsing report.";
   private static final String ERROR_SAVING_REPORT = "Error saving report.";
   private static final String ERROR_CREATING_REPORT = "Error creating report.";

   // Suite building variables
   private ArrayList<Suite> suites;
   private boolean complete = false;
   private BuildException threadException;
   private boolean verbose = true;

   // attributes from ant task def
   private int port = 1024;
   private int socketTimeout = 60000; // milliseconds
   private boolean failOnTestFailure = true;
   private boolean isLocalTrusted = false;
   private String failureProperty = "flexunit.failed";
   private String swf;
   private File reportDir;
   
   @SuppressWarnings("unused")
   private boolean modules = false;

   /**
    * Sets local trusted, default is false
    * 
    * @param localTrusted
    */
   public void setLocalTrusted(final boolean localTrusted)
   {
      isLocalTrusted = localTrusted;
   }

   /**
    * Set the port to receive the test results on. Default is 1024
    * 
    * @param serverPort
    *           the port to set.
    */
   public void setPort(final int serverPort)
   {
      port = serverPort;
   }

   /**
    * Set the timeout for receiving the flexunit report.
    * 
    * @param timeout
    *           in milliseconds.
    */
   public void setTimeout(final int timeout)
   {
      socketTimeout = timeout;
   }

   /**
    * The SWF for the FlexUnit tests to run.
    * 
    * @param testSWF
    *           the SWF to set.
    */
   public void setSWF(final String testSWF)
   {
      swf = testSWF;
   }

   /**
    * Set the directory to output the test reports to.
    * 
    * @param toDir
    *           the directory to set.
    */
   public void setToDir(final String toDir)
   {
      reportDir = getProject().resolveFile(toDir);
   }

   /**
    * Should we fail the build if the flex tests fail?
    * 
    * @param fail
    */
   public void setHaltonfailure(final boolean fail)
   {
      failOnTestFailure = fail;
   }

   /**
    * Custom ant property noting test failure
    * 
    * @param failprop
    */
   public void setFailureproperty(final String failprop)
   {
      failureProperty = failprop;
   }

   /**
    * Toggle display of descriptive messages
    * 
    * @param failprop
    */
   public void setVerbose(final boolean v)
   {
      verbose = v;
   }

   public void setModules(final boolean mod)
   {
      modules = mod;
   }

   /**
    * Called by Ant to execute the task.
    */
   public void execute() throws BuildException
   {
      // Check a SWF was specified.
      if (swf == null || swf.length() == 0 || !getProject().resolveFile(swf).exists())
      {
         throw new BuildException("The 'swf' property value [" + swf + "] could not be found.");
      }

      // if ( modules )
      // {
      // FileListener listener = new FileListener();
      // listener = null;
      // }

      createReportDirectory();

      setupClientConnection();

      launchTestSuite();

      waitForTestSuiteToExcecute();
   }

   /**
    * Main thread sleeps until all tests are run
    */
   private void waitForTestSuiteToExcecute()
   {
      while (!complete)
      {
         try
         {
            Thread.sleep(1000);
         }
         catch (InterruptedException e)
         {
            throw new BuildException(e);
         }
      }

      if (threadException != null)
      {
         if (verbose)
         {
            log("error running test suite: " + threadException.getMessage());
         }

         throw threadException;
      }
   }

   /**
    * Create and launch the swf player in the appropriate domain
    */
   private void launchTestSuite()
   {
      final FlexUnitLauncher browser = new FlexUnitLauncher();

      try
      {
         browser.runTests(swf, isLocalTrusted);
      }
      catch (Exception e)
      {
         throw new BuildException("Error launching the test runner.", e);
      }
   }

   /**
    * Creates the report directory. If none specified, creates in the root
    * directory.
    */
   private void createReportDirectory()
   {
      if (reportDir == null)
      {
         reportDir = getProject().resolveFile(".");
      }

      reportDir.mkdir();
   }

   /**
    * Create a server socket for receiving the test reports from FlexUnit. We
    * read the test reports inside of a Thread.
    */
   private void setupClientConnection()
   {
      // Start a thread to accept a client connection.
      final Thread thread = new Thread()
      {
         private ServerSocket serverSocket = null;
         private Socket clientSocket = null;
         private InputStream in = null;
         private OutputStream out = null;

         public void run()
         {
            try
            {
               openServerSocket();
               openClientSocket();
               handleClientConnection();
            }
            catch (BuildException buildException)
            {
               threadException = buildException;

               try
               {
                  sendAcknowledgement();
               }
               catch (IOException e)
               {
                  // ignore
               }
            }
            catch (SocketTimeoutException e)
            {
               threadException = new BuildException("socket timeout waiting for flexunit report", e);
            }
            catch (IOException e)
            {
               threadException = new BuildException("error receiving report from flexunit", e);
            }
            finally
            {
               // always stop the server loop
               complete = true;

               closeClientSocket();
               closeServerSocket();
            }
         }

         private void handleClientConnection() throws IOException
         {
            StringBuffer buffer = new StringBuffer();
            int bite = -1;
            suites = new ArrayList<Suite>();

            while ((bite = in.read()) != -1)
            {
               final char chr = (char) bite;

               // read buffer until a null byte
               if (chr == NULL_BYTE)
               {
                  // Convert to string
                  final String data = buffer.toString();
                  buffer = new StringBuffer();

                  // If the string is a policy request, send the request and
                  // retry
                  // connection
                  if (data.equals(POLICY_FILE_REQUEST))
                  {
                     sendPolicyFile();
                     closeClientSocket();
                     openClientSocket();
                  }

                  // If the string is a failure, process the report
                  else if (data.endsWith(END_OF_FAILURE))
                  {
                     processTestReport(data);
                  }

                  // If the string is a success, process the failure
                  else if (data.endsWith(END_OF_SUCCESS))
                  {
                     processTestReport(data);
                  }
                  
                  else if(data.endsWith(END_OF_IGNORE))
                  {
                     processTestReport(data);
                  }

                  // If the string is the end of the test run, close connection and verify build status
                  else if (data.startsWith(END_OF_TEST_RUN))
                  {
                     endTestRunReport();
                     sendAcknowledgement();
                  }
               }
               // Otherwise append the character and continue
               else
               {
                  buffer.append(chr);
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

            if (verbose)
            {
               log(SENT_POLICY);
            }
         }

         /**
          * Process the test report.
          * 
          * @param report
          *           String that represents a complete test
          */
         private void processTestReport(final String report)
         {
            // Convert the string report into an XML document
            Document document = parseReport(report);
            // Retrieve the root element
            Element root = document.getRootElement();

            // Find the name of the suite
            String suiteName = root.valueOf(SUITE_ATTRIBUTE);
            // Convert all instances of :: for file support
            suiteName = suiteName.replaceAll("::", ".");

            Suite suite = null;

            // Cycle through suites array and find our suite, if none
            // save null
            for (Suite currentSuite : suites)
            {
               if (currentSuite.getName().equals(suiteName))
               {
                  suite = currentSuite;
                  break;
               }

            }

            // If the suite does not exist, create it
            if (suite == null)
            {
               suite = new Suite(suiteName);
               suites.add(suite);
               createTestReport(suite);
            }

            // Finally, write the test to file.
            writeTestReport(document, suite);
         }

         /**
          * Sends the end of test run to the listener to close the connection
          * 
          * @throws IOException
          */
         private void sendAcknowledgement() throws IOException
         {
            out.write(END_OF_TEST_ACK.getBytes());
            out.write(NULL_BYTE);

            if (verbose)
            {
               log("end of test run");
            }
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

            if (verbose)
            {
               log("opened server socket");
            }
         }

         /**
          * Closes the server socket. Ignores any errors if unable to close
          */
         private void closeServerSocket()
         {
            if (serverSocket != null)
            {
               try
               {
                  serverSocket.close();
               }
               catch (IOException e)
               {
                  // ignore
               }
            }
         }

         /**
          * Creates the client connection. This method will pause until the
          * connection is made or the timout limit is reached.
          * 
          * Once a connection is established opens the in and out buffer.
          * 
          * @throws IOException
          */
         private void openClientSocket() throws IOException
         {
            // This method blocks until a connection is made.
            clientSocket = serverSocket.accept();

            if (verbose)
            {
               log("accepting data from client");
            }

            in = clientSocket.getInputStream();
            out = clientSocket.getOutputStream();
         }

         /**
          * Closes the client connection and all buffers, ignoring any errors
          */
         private void closeClientSocket()
         {
            // Close the output stream.
            if (out != null)
            {
               try
               {
                  out.close();
               }
               catch (IOException e)
               {
                  // ignore
               }
            }

            // Close the input stream.
            if (in != null)
            {
               try
               {
                  in.close();
               }
               catch (IOException e)
               {
                  // ignore
               }
            }

            // Close the client socket.
            if (clientSocket != null)
            {
               try
               {
                  clientSocket.close();
               }
               catch (IOException e)
               {
                  // ignore
               }
            }
         }
      };

      thread.start();
   }

   /**
    * Create a new test suite XML report. The name of the report is the suite
    * name including tree structure. Adds the labels appropriate for a test
    * suite. Once the document is created, writes the document to file and
    * closes Creates an error if this process fails.
    * 
    * @param suite
    *           Suite to create
    */
   protected void createTestReport(final Suite suite)
   {
      try
      {
         // Create a new XML document
         Document document = DocumentHelper.createDocument();

         // Add the test suite attributes to the document
         document.addElement(TEST_SUITE).addAttribute(NAME_ATTRIBUTE_LABEL, suite.getName())
            .addAttribute(TESTS_ATTRIBUTE_LABEL, String.valueOf(suite.getTests()))
            .addAttribute(FAILURE_ATTRIBUTE_LABEL, String.valueOf(suite.getFailures()))
            .addAttribute(ERROR_ATTRIBUTE_LABEL, String.valueOf(suite.getErrors()))
            .addAttribute(IGNORE_ATTRIBUTE_LABEL, String.valueOf(suite.getSkips()))
            .addAttribute(TIME_ATTRIBUTE_LABEL, String.valueOf(suite.getTime()));

         // Open a new file using the suite as a name
         final File file = new File(reportDir, FILENAME_PREFIX + suite + FILENAME_EXTENSION);

         // Write the document to the file.
         final OutputFormat format = OutputFormat.createPrettyPrint();
         final XMLWriter writer = new XMLWriter(new FileOutputStream(file), format);
         writer.write(document);
         writer.close();
      }
      catch (Exception e)
      {
         throw new BuildException(ERROR_CREATING_REPORT, e);
      }
   }

   /**
    * Handles writing of the test result and passes the result to check for test
    * failures.
    * 
    * @param document
    *           XML document the test should be added to
    * @param suite
    *           Suite the test is located in
    */
   protected void writeTestReport(final Document document, Suite suite)
   {

      // Add to the number of tests in this suite
      suite.addTest();

      // Check if this test is a failure
      checkForStatus(document, suite);

      // Save the report to file
      saveTestReportToFile(document, suite);
   }

   /**
    * Check if the passed in test is a failure
    * 
    * @param name
    *           String name of the test
    * @param status
    *           String status of the test
    * @param suite
    *           Suite the test is part of
    */

   private void checkForStatus(Document document, Suite suite)
   {
      // Get the root element and pull the test name and status
      final Element root = document.getRootElement();
      final String name = root.valueOf(NAME_ATTRIBUTE);
      final String status = root.valueOf(STATUS_ATTRIBUTE);

      // If the test is a failure
      if (status.equals(FAILURE) || status.equals(ERROR))
      {
         // This run is now a failed run
         getProject().setNewProperty(failureProperty, TRUE);
      }

      String format = null;
      if(status.equals(FAILURE))
      {
         format = FAILED_TEST;
         suite.addFailure();
      }
      else if(status.equals(ERROR))
      {
         format = ERRORED_TEST;
         suite.addError();
      }
      else if(status.equals(IGNORE))
      {
         format = IGNORED_TEST;
         suite.addSkip();
      }
         
      // Creates the fail message for use with verbose
      if (verbose && format != null)
      {
         final String message = MessageFormat.format(format, new Object[] { name, suite });
         log(message);
      }
   }

   /**
    * Parse the parameter String and returns it as a document
    * 
    * @param report
    *           String
    * @return Document
    */
   private Document parseReport(final String report)
   {
      try
      {
         final Document document = DocumentHelper.parseText(report);

         return document;
      }
      catch (DocumentException e)
      {
         System.out.println(report);
         throw new BuildException(ERROR_PARSING_REPORT, e);
      }
   }

   /**
    * Saves the test report to file in the given suite using the parameter
    * document as the test
    * 
    * @param testReport
    *           Document
    * @param suite
    *           Suite
    */
   private void saveTestReportToFile(final Document testReport, Suite suite)
   {
      try
      {
         // Open the file matching the parameter suite
         final File file = new File(reportDir, FILENAME_PREFIX + suite + FILENAME_EXTENSION);

         // Read the file representing the suite into an XML document
         SAXReader saxReader = new SAXReader();
         Document suiteReport = saxReader.read(file);

         // Retrieve the root element and adjust the failures and test
         // attributes
         Element root = suiteReport.getRootElement();
         root.addAttribute(FAILURE_ATTRIBUTE_LABEL, String.valueOf(suite.getFailures()));
         root.addAttribute(ERROR_ATTRIBUTE_LABEL, String.valueOf(suite.getErrors()));
         root.addAttribute(TESTS_ATTRIBUTE_LABEL, String.valueOf(suite.getTests()));
         root.addAttribute(IGNORE_ATTRIBUTE_LABEL, String.valueOf(suite.getSkips()));

         // Retrieve the test from the testReport and add it to the suite
         Element test = testReport.getRootElement();
         root.add(test);

         // Write the updated suite
         final OutputFormat format = OutputFormat.createPrettyPrint();
         final XMLWriter writer = new XMLWriter(new FileOutputStream(file), format);
         writer.write(suiteReport);
         writer.close();
      }
      catch (Exception e)
      {
         throw new BuildException(ERROR_SAVING_REPORT, e);
      }
   }

   /**
    * End of test report run. Called at the end of a test run.  If verbose is set 
    * to true reads all suites in the suite list and prints out a descriptive message 
    * including the name of the suite, number of tests run and number of tests failed,
    * ignores any errors.  If any tests failed during the test run, the build is halted.
    */
   private void endTestRunReport()
   {
      if(verbose)
      {
         for (Suite suite : suites)
         {
            try
            {
               System.out.println(MessageFormat.format(TEST_INFO, new Object[] { new String(suite.getName()), new Integer(suite.getTests()), new Integer(suite.getFailures()), new Integer(suite.getErrors()) }));
            }
            catch (Exception e)
            {
               // ignore
            }
         }
      }
      
      if(failOnTestFailure && getProject().getProperty(failureProperty).equals(TRUE))
      {
         throw new BuildException("FlexUnit tests failed during the test run.");
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