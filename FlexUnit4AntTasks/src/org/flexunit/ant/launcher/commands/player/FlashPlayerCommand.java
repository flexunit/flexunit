package org.flexunit.ant.launcher.commands.player;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.flexunit.ant.LoggingUtil;

/**
 * Abstracts the assembly of a command-line call to the Flash player for all platforms.  
 */
public abstract class FlashPlayerCommand extends PlayerCommand
{
   public static final String TRUST_FILENAME = "flexUnit.cfg";
   
   private boolean localTrusted;
   
   public FlashPlayerCommand()
   {
      super();
   }

   @Override
   public void setSwf(File swf)
   {
      super.setSwf(swf);
      
      //setup the command line now that we have swf available
      getCommandLine().setExecutable(generateExecutable());
      getCommandLine().addArguments(generateArguments(swf));      
   }
   
   public void setLocalTrusted(boolean localTrusted)
   {
      this.localTrusted = localTrusted;
   }

   public boolean isLocalTrusted()
   {
      return localTrusted;
   }

   @Override
   public int execute() throws IOException
   {
      //handle local trust
      if (localTrusted)
      {
         createLocalTrust(getSwf());
      }
      else
      {
         clearLocalTrust();
      }
      
      //Run command
      return super.execute();
   }
   
   /**
    * Used to create and populate the local trust file for the Flash player 
    */
   private void createLocalTrust(File swf)
   {
      try
      {
         //create the appropriate FP trust directory is it doesn't exist
         File trustDir = getLocalTrustDirectory();
         if(!trustDir.exists())
         {
            trustDir.mkdir();
         }
         
         //Write out trust file
         File trustFilename = getProject().resolveFile(getLocalTrustDirectory() + "/" + TRUST_FILENAME);
         String swfDir = swf.getParentFile().getAbsolutePath();
         
         FileWriter writer = new FileWriter(trustFilename.getAbsolutePath());
         writer.write(swfDir);
         writer.close();
         
         LoggingUtil.log("Created local trust file at [" + trustFilename.getAbsolutePath() + "]");
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }
   
   /**
    * Used to delete the local trust file for the Flash player
    */
   private void clearLocalTrust()
   {
      try
      {
         File trustFilename = getProject().resolveFile(getLocalTrustDirectory() + "/" + TRUST_FILENAME);
         
         if(trustFilename.exists())
         {
            trustFilename.delete();
            LoggingUtil.log("Deleted existing local trust file at [" + trustFilename + "].");
         }
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }

   protected abstract File getLocalTrustDirectory();
   protected abstract String generateExecutable();
   protected abstract String[] generateArguments(File swf);
}
