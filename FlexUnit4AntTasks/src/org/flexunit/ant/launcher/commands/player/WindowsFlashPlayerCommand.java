package org.flexunit.ant.launcher.commands.player;

import java.io.File;

public class WindowsFlashPlayerCommand extends FlashPlayerCommand
{
   private static final String WINDOWS_CMD = "rundll32";
   private final String localTrustedDirectory = System.getenv("windir") + "\\system32\\Macromed\\Flash\\FlashPlayerTrust\\";

   @Override
   protected File getLocalTrustDirectory()
   {
      return new File(this.localTrustedDirectory);
   }

   @Override
   protected String[] generateArguments(File swf)
   {
      return new String[]{"url.dll,FileProtocolHandler", swf.getAbsolutePath()};
   }

   @Override
   protected String generateExecutable()
   {
      return WINDOWS_CMD;
   }

   
}
