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
      String trustFileName = getLocalTrustedDirectory() + TRUST_FILENAME;
      
      if (localTrusted)
      {
         File swfFile = new File(swf);
         createLocalTrustedFile(trustFileName, swfFile.getAbsolutePath());
      }
      else
      {
         deleteLocalTrustedFile(trustFileName);
      }
      
      runTests(swf);
   }
   
   protected void createLocalTrustedFile(String trustFilename, String swf) throws Exception
   {
      try
      {
         System.out.println("Creating local trusted file");
         FileWriter writer = new FileWriter(trustFilename);
         writer.write(swf);
         writer.close();
      }
      catch (Exception e)
      {
         e.printStackTrace();
         throw e;
      }
   }

   protected void deleteLocalTrustedFile(String trustFilename) throws Exception
   {
      try
      {
         System.out.println("Deleting local trusted file");
         File file = new File(trustFilename);
         file.delete();
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