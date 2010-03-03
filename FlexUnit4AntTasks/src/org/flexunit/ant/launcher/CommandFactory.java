package org.flexunit.ant.launcher;

import org.flexunit.ant.launcher.commands.player.AdlCommand;
import org.flexunit.ant.launcher.commands.player.FlashPlayerCommand;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;
import org.flexunit.ant.launcher.platforms.LinuxDefaults;
import org.flexunit.ant.launcher.platforms.MacOSXDefaults;
import org.flexunit.ant.launcher.platforms.WindowsDefaults;

public class CommandFactory
{
   /**
    * Factory method to create the appropriate player and provide it with a set of defaults for
    * the executing platform.
    * 
    * @param os
    * @param player  "flash" or "air"
    * @param localTrusted
    * @return Desired player command with platform defaults
    */
   public static PlayerCommand createPlayer(OperatingSystem os, String player, boolean localTrusted)
   {
      PlayerCommand command = null;

      //choose player
      if (player.equals("flash"))
      {
         FlashPlayerCommand fpCommand = new FlashPlayerCommand();
         fpCommand.setLocalTrusted(localTrusted);
         command = fpCommand;
      }
      else
      {
         command = new AdlCommand();
      }
      
      //set defaults
      if (os.equals(OperatingSystem.WINDOWS))
      {
         command.setDefaults(new WindowsDefaults());
      }
      else if(os.equals(OperatingSystem.MACOSX))
      {
         command.setDefaults(new MacOSXDefaults());
      }
      else
      {
         command.setDefaults(new LinuxDefaults());
      }
      
      return command;
   }
}
