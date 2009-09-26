package org.flexunit.ant;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.text.MessageFormat;

import org.apache.tools.ant.BuildException;

/**
 * Class responsible for managing the connections to the test runner and any boiler plate in the network interactivity. 
 */
public class FlexUnitSocketServer
{
   
   private static final char NULL_BYTE = '\u0000';
   private static final String POLICY_FILE_REQUEST = "<policy-file-request/>";
   
   //Uncomment to use DTD for validation rather than schema
   //private static final String DOMAIN_POLICY = "<?xml version=\"1.0\"?><!DOCTYPE cross-domain-policy SYSTEM \"http://www.adobe.com/xml/dtds/cross-domain-policy.dtd\"><cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"{0}\" /></cross-domain-policy>";

   private static final String DOMAIN_POLICY = 
      "<?xml version=\"1.0\"?>"
      + "<cross-domain-policy xmlns=\"http://localhost\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.adobe.com/xml/schemas PolicyFileSocket.xsd\">"
      + "<allow-access-from domain=\"*\" to-ports=\"{0}\" />"
      + "</cross-domain-policy>";
   
   private static final String START_OF_TEST_RUN_ACK = "<startOfTestRunAck/>";
   private static final String END_OF_TEST_RUN = "<endOfTestRun/>";
   private static final String END_OF_TEST_RUN_ACK = "<endOfTestRunAck/>";
   
   private int port;
   private int timeout;
   private int inboundBufferSize;  //if this is not set high enough, incoming data may clobber unread data in the buffer
   private boolean waitForPolicyFile;

   private ServerSocket serverSocket = null;
   private Socket clientSocket = null;
   private BufferedInputStream inboundStream = null;
   private OutputStream outboundStream = null;

   public FlexUnitSocketServer(int port, int timeout, int inboundBufferSize, boolean waitForPolicyFile)
   {
      this.port = port;
      this.timeout = timeout;
      this.inboundBufferSize = inboundBufferSize;
      this.waitForPolicyFile = waitForPolicyFile;
   }

   /**
    * Starts the socket server, managing policy file requests, and starting the test process.
    */
   public void start() throws IOException
   {
      LoggingUtil.log("Starting server ...");
      
      try
      {
         openServerSocket();
         openClientSocket();
         prepareClientSocket();
      }
      catch (SocketTimeoutException e)
      {
         throw new BuildException("Socket timeout waiting for flexunit report", e);
      }
   }
   
   /**
    * Resets the client connection.
    */
   private void resetInboundStream() throws IOException
   {
      LoggingUtil.log("Resetting client connection ...");
      
      closeClientSocket();
      openClientSocket();
   }
   
   /**
    * Creates a connection on the specified socket. Waits {socketTimeout}
    * seconds for a client connection before throwing an error
    */
   private void openServerSocket() throws IOException
   {
      serverSocket = new ServerSocket(port);
      serverSocket.setSoTimeout(timeout);

      LoggingUtil.log("Opening server socket on port [" + port + "].");
   }

   /**
    * Creates the client connection. This method will pause until the connection
    * is made or the timout limit is reached.
    * 
    * Once a connection is established opens the in and out buffer.
    */
   private void openClientSocket() throws IOException
   {
      LoggingUtil.log("Waiting for client connection ...");
      
      // This method blocks until a connection is made.
      clientSocket = serverSocket.accept();

      LoggingUtil.log("Client connected.");
      LoggingUtil.log("Setting inbound buffer size to " + inboundBufferSize + " bytes.");
      
      inboundStream = new BufferedInputStream(clientSocket.getInputStream(), inboundBufferSize);
      outboundStream = new BufferedOutputStream(clientSocket.getOutputStream());
      
      LoggingUtil.log("Receiving data ...");
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
            LoggingUtil.log("Policy file requested.");
            
            sendPolicyFile();
            resetInboundStream();
         }
      }

      //tell client to start the testing process
      sendTestRunStartAcknowledgement();
   }
   
   /**
    * Generate domain policy message and send 
    */
   private void sendPolicyFile() throws IOException
   {
      sendOutboundMessage(MessageFormat.format(DOMAIN_POLICY, new Object[] { Integer.toString(port) }));

      LoggingUtil.log("Policy file sent.");
   }

   /**
    * Generate and send message to inform test runner to begin sending test data
    */
   private void sendTestRunStartAcknowledgement() throws IOException
   {
      LoggingUtil.log("Sending acknowledgement to player to start sending test data ...\n");
      
      sendOutboundMessage(START_OF_TEST_RUN_ACK);
   }
   
   /**
    * Reads tokens from the socket input stream based on NULL_BYTE as a delimiter
    */
   public String readNextTokenFromSocket() throws IOException
   {
      StringBuffer buffer = new StringBuffer();
      int piece = -1;

      while ((piece = inboundStream.read()) != NULL_BYTE)
      {
         //Did we reach the end of the buffer?  Tell the user there is nothing more.
         if (piece == -1)
         {
            return null;
         }

         final char chr = (char) piece;
         buffer.append(chr);
      }

      //Did we recieve a message that the test run is over? Tell the user we have nothing more.
      String token = buffer.toString();
      
      if(token.equals(END_OF_TEST_RUN))
      {
         return null;
      }
      
      return token;
   }
   
   private void sendOutboundMessage(String message) throws IOException
   {
      if(outboundStream != null)
      {
         outboundStream.write(message.getBytes());
         outboundStream.write(NULL_BYTE);
         outboundStream.flush();
      }
   }

   /**
    * Stops the socket server, notifying the test runner, and closing the appropriate connections.
    */
   public void stop() throws IOException
   {
      LoggingUtil.log("\nStopping server ...");
      
      sendTestRunEndAcknowledgement();
      closeClientSocket();
      closeServerSocket();
   }
   
   /**
    * Sends the end of test run to the listener to close the connection
    */
   private void sendTestRunEndAcknowledgement() throws IOException
   {
      LoggingUtil.log("End of test data reached, sending acknowledgement to player ...");
      
      sendOutboundMessage(END_OF_TEST_RUN_ACK);
   }
   
   /**
    * Closes the client connection and all buffers, ignoring any errors
    */
   private void closeClientSocket() throws IOException
   {
      LoggingUtil.log("Closing client connection ...");
      
      // Close the output stream.
      if (outboundStream != null)
      {
         outboundStream.close();
      }

      // Close the input stream.
      if (inboundStream != null)
      {
         inboundStream.close();
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
      LoggingUtil.log("Closing server on port [" + port + "] ...");
      
      if (serverSocket != null)
      {
         serverSocket.close();
      }
   }
}
