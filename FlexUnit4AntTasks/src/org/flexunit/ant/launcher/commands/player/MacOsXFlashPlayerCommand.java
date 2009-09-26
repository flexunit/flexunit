package org.flexunit.ant.launcher.commands.player;

import java.io.File;

public class MacOsXFlashPlayerCommand extends FlashPlayerCommand
{
   private final String MAC_CMD = "open";
   private final String localTrustedDirectory = System.getProperty("user.home") + "/Library/Preferences/Macromedia/Flash Player/#Security/FlashPlayerTrust/";

   @Override
   protected File getLocalTrustDirectory()
   {
      return new File(this.localTrustedDirectory);
   }

   @Override
   protected String[] generateArguments(File swf)
   {
      return new String[]{swf.getAbsolutePath()};
   }

   @Override
   protected String generateExecutable()
   {
      return MAC_CMD;
   }

}
