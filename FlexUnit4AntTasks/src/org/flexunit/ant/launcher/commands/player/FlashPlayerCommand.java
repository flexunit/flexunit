package org.flexunit.ant.launcher.commands.player;

import java.io.File;
import java.io.IOException;

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
   public void setSwf(File swf)
   {
      super.setSwf(swf);
      
      //setup the command line now that we have swf available
      getCommandLine().setExecutable(getDefaults().getOpenCommand());
      getCommandLine().addArguments(getDefaults().getOpenSystemArguments());
      getCommandLine().addArguments(new String[]{swf.getAbsolutePath()});
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
   public Process launch() throws IOException
   {
      TrustFile trustFile = new TrustFile(getProject(), getDefaults().getFlashPlayerUserTrustDirectory(), getDefaults().getFlashPlayerGlobalTrustDirectory());
      
      //handle local trust
      if (localTrusted)
      {
         trustFile.add(getSwf());
      }
      else
      {
         trustFile.remove(getSwf());
      }
      
      //Run command
      return super.launch();
   }
}
