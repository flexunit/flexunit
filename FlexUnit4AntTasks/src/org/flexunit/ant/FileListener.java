package org.flexunit.ant;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.text.MessageFormat;

public class FileListener
{
   private static final char NULL_BYTE = '\u0000';
   private static final String FILE_REQUEST = "<fileRequest";
   private static final String REQUEST_ACCEPTED = "<requestAccepted/>";

   // Domain and policy request formats
   private static final String POLICY_FILE_REQUEST = "<policy-file-request/>";
   private static final String DOMAIN_POLICY = "<cross-domain-policy>" + "	<allow-access-from domain=\"*\" to-ports=\"{0}\" />" + "	<allow-access-from domain=\"*\" to-ports=\"{1}\" />"
         + "</cross-domain-policy>";

   FileSender fileThread;

   private int _port = 2083;
   private int _socketTimeout = 0; // milliseconds

   private int _filePort = 2088;
   private int _fileSocketTimeout = 60000;

   private ServerSocket serverSocket = null;
   private Socket clientSocket = null;
   private InputStream in = null;
   private OutputStream out = null;

   /**
    * Constructor. Creates the client connection
    */
   public FileListener()
   {
      setupClientConnection();
   }

   /**
    * Create a connection in a new thread which waits for a connection and sends
    * the files independent of the main thread. The thread is final since we
    * should only be connecting once per application run.
    */
   private void setupClientConnection()
   {
      // Start a thread to accept a client connection.
      final Thread thread = new Thread()
      {
         public void run()
         {
            try
            {
               openServerSocket();
               openClientSocket();
               handleClientConnection();
            }
            catch (SocketTimeoutException e)
            {
               log("Socket timeout waiting for flash" + e);
            }
            catch (IOException e)
            {
               log("Error receiving recieving info from flash" + e);
            }
            finally
            {
               closeClientSocket();
               closeServerSocket();
            }
         }

         /**
          * Reads in messages from the client. If a policy file is required,
          * sends the policy file and reopens the connection. If a file request
          * is received, sends the requested file.
          * 
          * @throws IOException
          */
         private void handleClientConnection() throws IOException
         {
            StringBuffer buffer = new StringBuffer();
            int bite = -1;

            while ((bite = in.read()) != -1)
            {
               final char chr = (char) bite;

               // read buffer until a null byte
               if (chr == NULL_BYTE)
               {
                  // Convert to string
                  final String data = buffer.toString();
                  buffer = new StringBuffer();

                  // If string is a policy request, send policy file
                  // then reestablish the client connection
                  if (data.equals(POLICY_FILE_REQUEST))
                  {
                     sendPolicyFile();
                  }

                  // If the string is a file request, open file and send
                  if (data.startsWith(FILE_REQUEST))
                  {
                     log("Request Recieved");
                     createFileConnection(data);
                  }
               }
               // Otherwise append the character and continue
               else
               {
                  buffer.append(chr);
               }
            }
         }

         private void sendPolicyFile() throws IOException
         {
            out.write(MessageFormat.format(DOMAIN_POLICY, new Object[] { Integer.toString(_port), Integer.toString(_filePort) }).getBytes());

            out.write(NULL_BYTE);

            log("Sent policy file");
         }

         /**
          * Creates the file server connection and the actual file sender
          * object. Causes the message listener to sleep until the requested
          * file has been sent nad the connection closed.
          */
         private void createFileConnection(String data) throws IOException
         {
            ServerSocket fileServerSocket = new ServerSocket(_filePort);
            fileServerSocket.setSoTimeout(_fileSocketTimeout);

            log("File Server Socket Opened");

            // final Thread fileThread = new Thread()
            fileThread = new FileSender(fileServerSocket, data);
            sendAcknowledgement();

            while (fileThread.isConnected())
            {
               try
               {
                  Thread.sleep(100);
               }
               catch (InterruptedException e)
               {
                  e.printStackTrace();
               }
            }
         }

         /**
          * Sends the acknowledgment that a file was received and tells the
          * client to open the file socket.
          * 
          * @throws IOException
          */
         private void sendAcknowledgement() throws IOException
         {
            out.write(REQUEST_ACCEPTED.getBytes());
            out.write(NULL_BYTE);

            log("Sending Acknowledgement...");
         }

         /**
          * Creates a connection on the specified socket. Waits {socketTimeout}
          * seconds for a client connection before throwing an error
          * 
          * @throws IOException
          */
         private void openServerSocket() throws IOException
         {
            serverSocket = new ServerSocket(_port);
            serverSocket.setSoTimeout(_socketTimeout);

            log("Server Socket Opened");
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
                  log("Server Socket Closed");
               }
               catch (IOException e)
               {
                  // ignore
               }
            }
         }

         /**
          * Creates the client connection. This method will pause until the
          * connection is made or the timeout limit is reached.
          * 
          * Once a connection is established opens the in and out buffer.
          * 
          * @throws IOException
          */
         private void openClientSocket() throws IOException
         {
            // This method blocks until a connection is made.
            log("Waiting for client...");
            clientSocket = serverSocket.accept();

            log("Accepting data from client");

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
                  log("Client socket closed.");
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

   private void log(String msg)
   {
      System.out.println(msg);
   }
}
