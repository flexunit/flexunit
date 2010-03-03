package org.flexunit.ant.launcher.platforms;

import java.io.File;

public interface PlatformDefaults
{
   public File getFlashPlayerUserTrustDirectory();
   public File getFlashPlayerGlobalTrustDirectory();
   public String getOpenCommand();
   public String[] getOpenSystemArguments();
   public String getAdlCommand();
   //public String getFlashPlayerCommand();
}
