package org.flexunit.ant.launcher.platforms;

import java.io.File;

public class MacOSXDefaults implements PlatformDefaults
{

   public String getAdlCommand()
   {
      return "adl";
   }

   public File getFlashPlayerGlobalTrustDirectory()
   {
      return new File("/Library/Application Support/Macromedia/FlashPlayerTrust/");
   }

   public File getFlashPlayerUserTrustDirectory()
   {
      File file = null;
      
      String home = System.getenv("HOME");
      if(home != null && !home.equals(""))
      {
         file = new File(home + "/Library/Preferences/Macromedia/Flash Player/#Security/FlashPlayerTrust/");
      }
      
      return file;
   }

   public String getOpenCommand()
   {
      return "open";
   }

   public String[] getOpenSystemArguments()
   {
      return new String[]{};
   }

}
