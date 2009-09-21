package org.flexunit.ant;

import java.io.File;
import java.io.FileWriter;

/**
 * Base class through which SWFs are launched.
 */
public abstract class SWFLauncher
{
   public final static String TRUST_FILENAME = "flexUnit.cfg";

   public void launch(String swf, boolean localTrusted) throws Exception
   {
      if (localTrusted)
      {
         createLocalTrustedFile(swf);
      }
      else
      {
         deleteLocalTrustedFile();
      }
      
      runTests(swf);
   }
   
   protected void createLocalTrustedFile(String swf) throws Exception
   {
      try
      {
         //create the appropriate FP trust directory is it doesn't exist
         File trustDir = new File(getLocalTrustedDirectory());
         if(!trustDir.exists())
         {
            trustDir.mkdir();
         }
         
         //Write out trust file
         String trustFilename = getLocalTrustedDirectory() + TRUST_FILENAME;
         String swfDir = new File(swf).getParentFile().getAbsolutePath();
         
         FileWriter writer = new FileWriter(trustFilename);
         writer.write(swfDir);
         writer.close();
         
         System.out.println("Created local trusted file");
      }
      catch (Exception e)
      {
         e.printStackTrace();
         throw e;
      }
   }

   protected void deleteLocalTrustedFile() throws Exception
   {
      try
      {
         String trustFilename = getLocalTrustedDirectory() + TRUST_FILENAME;
         
         File file = new File(trustFilename);
         if(file.exists())
         {
            file.delete();
            System.out.println("Deleted local trusted file");
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
         throw e;
      }
   }
   
   protected abstract String getLocalTrustedDirectory();
   protected abstract void runTests(String swf) throws Exception;
}
