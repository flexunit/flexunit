package org.flexunit.ant;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketTimeoutException;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class FileSender implements Runnable
{
   private ServerSocket _fileServerSocket;
   private Socket _fileClientSocket;
   private InputStream _fileIn;
   private OutputStream _fileOut;

   @SuppressWarnings("unused")
   private static final String ERROR_PARSING_REPORT = "Error parsing report.";

   // XML Attributes
   private static final String DIR_ATTRIBUTE = "@dir";
   private static final String FILE_ATTRIBUTE = "@file";

   private String _data;

   private Thread _senderThread;

   private boolean _connected = false;

   public FileSender(ServerSocket fileServerSocket, String data)
   {
      _fileServerSocket = fileServerSocket;
      _data = data;
      _senderThread = new Thread(this);
      _senderThread.start();
   }

   public void run()
   {
      try
      {
         openFileClientSocket();
         openFile();
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
         closeFileClientSocket();
         closeFileServerSocket();
      }
   }

   private void openFile()
   {
      Document request = parseReport(_data);
      Element root = request.getRootElement();
      String dir = root.valueOf(DIR_ATTRIBUTE);
      String file = root.valueOf(FILE_ATTRIBUTE);

      sendFile(dir, file);
   }

   private Document parseReport(final String report)
   {
      Document document = null;
      try
      {
         document = DocumentHelper.parseText(report);
      }
      catch (DocumentException e)
      {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

      return document;
   }

   private void openFileClientSocket() throws IOException
   {
      // This method blocks until a connection is made.
      _fileClientSocket = _fileServerSocket.accept();

      log("Ready to send data to Flex");

      _fileIn = _fileClientSocket.getInputStream();
      _fileOut = _fileClientSocket.getOutputStream();

      _connected = true;
   }

   private void sendFile(String dir, String file)
   {
      try
      {
         File myFile = new File(dir + "/" + file);

         byte[] buffer = new byte[(int) myFile.length()];
         FileInputStream inputStream = new FileInputStream(myFile);
         BufferedInputStream bufferedStream = new BufferedInputStream(inputStream);
         bufferedStream.read(buffer, 0, buffer.length);

         log("File Read");

         _fileOut.write(buffer, 0, buffer.length);

         log("File Sent");

         _fileOut.flush();
      }
      catch (Exception e)
      {

      }
   }

   private void closeFileServerSocket()
   {
      if (_fileServerSocket != null)
      {
         try
         {
            _fileServerSocket.close();
            _connected = false;
            log("File Server Socket Closed");
         }
         catch (IOException e)
         {
            // ignore
         }
      }
   }

   private void closeFileClientSocket()
   {
      // Close the output stream.
      if (_fileOut != null)
      {
         try
         {
            _fileOut.close();
         }
         catch (IOException e)
         {
            // ignore
         }
      }

      // Close the input stream.
      if (_fileIn != null)
      {
         try
         {
            _fileIn.close();
         }
         catch (IOException e)
         {
            // ignore
         }
      }

      // Close the client socket.
      if (_fileClientSocket != null)
      {
         try
         {
            _fileClientSocket.close();
            log("File Client Server Closed");
         }
         catch (IOException e)
         {
            // ignore
         }
      }
   }

   public boolean isConnected()
   {
      return _connected;
   }

   private void log(String msg)
   {
      System.out.println(msg);
   }
}
