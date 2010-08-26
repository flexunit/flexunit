package org.flexunit.ant.launcher.commands.player;

import java.io.File;

import org.flexunit.ant.launcher.OperatingSystem;
import org.flexunit.ant.launcher.platforms.LinuxDefaults;
import org.flexunit.ant.launcher.platforms.MacOSXDefaults;
import org.flexunit.ant.launcher.platforms.WindowsDefaults;

public class PlayerCommandFactory
{
   /**
    * Factory method to create the appropriate player and provide it with a set of defaults for
    * the executing platform.
    * 
    * @param os
    * @param player  "flash" or "air"
    * @param customCommand
    * @param localTrusted
    * @return Desired player command with platform defaults possibly wrapped in a custom command
    */
   public static PlayerCommand createPlayer(OperatingSystem os, String player, File customCommand, boolean localTrusted)
   {
      PlayerCommand newInstance = null;

      DefaultPlayerCommand defaultInstance = null;
      
      //choose player
      if (player.equals("flash"))
      {
         FlashPlayerCommand fpCommand = new FlashPlayerCommand();
         fpCommand.setLocalTrusted(localTrusted);
         defaultInstance = fpCommand;
      }
      else
      {
         defaultInstance = new AdlCommand();
      }
      
      //set defaults
      if (os.equals(OperatingSystem.WINDOWS))
      {
         defaultInstance.setDefaults(new WindowsDefaults());
      }
      else if(os.equals(OperatingSystem.MACOSX))
      {
         defaultInstance.setDefaults(new MacOSXDefaults());
      }
      else
      {
         defaultInstance.setDefaults(new LinuxDefaults());
      }
      
      //if a custom command has been provide, use it to wrap the default command
      if(customCommand != null)
      {
         CustomPlayerCommand customInstance = new CustomPlayerCommand();
         customInstance.setProxiedCommand(defaultInstance);
         customInstance.setExecutable(customCommand);
         newInstance = customInstance;
      }
      else
      {
         newInstance = defaultInstance;
      }
      
      return newInstance;
   }
}
