package org.flexunit.ant;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;

/**
 * Launches a SWF on Mac OS X.
 */
public class MacSWFLauncher extends SWFLauncher
{
   private final String localTrustedDirectory = System.getProperty("user.home") + "/Library/Preferences/Macromedia/Flash Player/#Security/FlashPlayerTrust/";

   public String getLocalTrustedDirectory()
   {
      return this.localTrustedDirectory;
   }

   protected void runTests(String swf) throws Exception
   {
      Process process = null;
      
      try
      {
         System.out.println("Launching SWF: " + swf);
         process = Runtime.getRuntime().exec("open " + swf);
      }
      catch (Exception e)
      {
         throw e;
      }

      String error = readStream(process.getErrorStream());

      if (error.length() > 0)
      {
         throw new Exception(error);
      }
   }

   /**
    * Reads all the data available from an input stream and converts it into a
    * String.
    * 
    * @param input
    *           input stream to read
    * @return converted string
    * @throws Exception
    *            if an error occurs while reading from the stream
    */
   private String readStream(final InputStream input) throws Exception
   {
      final ByteArrayOutputStream output = new ByteArrayOutputStream();

      int i;

      while ((i = input.read()) != -1)
      {
         output.write(i);
      }
      return new String(output.toByteArray());
   }
}