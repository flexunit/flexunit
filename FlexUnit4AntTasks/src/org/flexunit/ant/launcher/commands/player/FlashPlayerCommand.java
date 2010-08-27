package org.flexunit.ant.launcher.commands.player;

import java.io.File;

/**
 * Abstracts the assembly of a command-line call to the Flash player for all platforms.  
 */
public class FlashPlayerCommand extends DefaultPlayerCommand
{
   public static final String TRUST_FILENAME = "flexUnit.cfg";
   
   private boolean localTrusted;
   
   public FlashPlayerCommand()
   {
      super();
   }

   @Override
   public File getFileToExecute()
   {
      return getSwf();
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
   public void prepare()
   {
      //setup the command line now
      getCommandLine().setExecutable(getDefaults().getOpenCommand());
      getCommandLine().addArguments(getDefaults().getOpenSystemArguments());
      getCommandLine().addArguments(new String[]{getFileToExecute().getAbsolutePath()});

      //handle local trust
      TrustFile trustFile = new TrustFile(getProject(), getDefaults().getFlashPlayerUserTrustDirectory(), getDefaults().getFlashPlayerGlobalTrustDirectory());
      if (localTrusted)
      {
         trustFile.add(getSwf());
      }
      else
      {
         trustFile.remove(getSwf());
      }
   }
}
