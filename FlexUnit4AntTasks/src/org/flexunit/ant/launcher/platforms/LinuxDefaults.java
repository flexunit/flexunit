package org.flexunit.ant.launcher.platforms;

import java.io.File;

public class LinuxDefaults implements PlatformDefaults
{

   public String getAdlCommand()
   {
      return "adl";
   }

   public File getFlashPlayerGlobalTrustDirectory()
   {
      return new File("/etc/adobe/FlashPlayerTrust/");
   }

   public File getFlashPlayerUserTrustDirectory()
   {
      File file = null;
      
      String home = System.getenv("HOME");
      if(home != null && !home.equals(""))
      {
         file = new File(home + "/.macromedia/Flash_Player/#Security/FlashPlayerTrust/");
      }
      
      return file;
   }

   public String getOpenCommand()
   {
      return "gflashplayer";
   }

   public String[] getOpenSystemArguments()
   {
      return new String[]{};
   }

}
