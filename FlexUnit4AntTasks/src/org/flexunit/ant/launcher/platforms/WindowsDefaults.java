package org.flexunit.ant.launcher.platforms;

import java.io.File;

public class WindowsDefaults implements PlatformDefaults
{

   public String getAdlCommand()
   {
      return "adl.exe";
   }

   public File getFlashPlayerGlobalTrustDirectory()
   {
      return new File(System.getenv("SYSTEMROOT") + "\\system32\\Macromed\\Flash\\FlashPlayerTrust\\");
   }

   public File getFlashPlayerUserTrustDirectory()
   {
      File file = null;
      
      String appData = System.getenv("APPDATA");
      if(appData != null && !appData.equals(""))
      {
         file = new File(appData + "\\Macromedia\\Flash Player\\#Security\\FlashPlayerTrust\\");
      }
      
      return file;
   }

   public String getOpenCommand()
   {
      return "rundll32 url.dll,FileProtocolHandler";
   }

   public String[] getOpenSystemArguments()
   {
      return new String[]{};
   }

}
