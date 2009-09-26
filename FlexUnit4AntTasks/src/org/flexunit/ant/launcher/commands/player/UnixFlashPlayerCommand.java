package org.flexunit.ant.launcher.commands.player;

import java.io.File;

public class UnixFlashPlayerCommand extends FlashPlayerCommand
{
   private static final String UNIX_CMD = "gflashplayer";
   private final String localTrustedDirectory = System.getProperty("user.home") + "/.macromedia/Flash_Player/#Security/FlashPlayerTrust/";
   
   @Override
   protected File getLocalTrustDirectory()
   {
      return new File(localTrustedDirectory);
   }

   @Override
   protected String[] generateArguments(File swf)
   {
      return new String[]{swf.getAbsolutePath()};
   }

   @Override
   protected String generateExecutable()
   {
      return UNIX_CMD;
   }
   
}
