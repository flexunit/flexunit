package org.flexunit.ant.launcher;

import org.flexunit.ant.launcher.commands.player.FlashPlayerCommand;
import org.flexunit.ant.launcher.commands.player.MacOsXFlashPlayerCommand;
import org.flexunit.ant.launcher.commands.player.NonWindowsAdlCommand;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;
import org.flexunit.ant.launcher.commands.player.UnixFlashPlayerCommand;
import org.flexunit.ant.launcher.commands.player.WindowsAdlCommand;
import org.flexunit.ant.launcher.commands.player.WindowsFlashPlayerCommand;

public class CommandFactory
{
   public static PlayerCommand createPlayer(OperatingSystem os, String player, boolean localTrusted)
   {
      PlayerCommand command = null;

      if (player.equals("flash"))
      {
         if (os.equals(OperatingSystem.WINDOWS))
         {
            command = new WindowsFlashPlayerCommand();
         }
         else if(os.equals(OperatingSystem.MACOSX))
         {
            command = new MacOsXFlashPlayerCommand();
         }
         else
         {
            command = new UnixFlashPlayerCommand();
         }
         
         ((FlashPlayerCommand)command).setLocalTrusted(localTrusted);
      }
      else
      {
         if (os.equals(OperatingSystem.WINDOWS))
         {
            command = new WindowsAdlCommand();
         }
         else 
         {
            command = new NonWindowsAdlCommand();
         }
      }
      
      return command;
   }
   
   public static void createHeadlessStart(String xcommand)
   {
      //TODO: Implement factory method
   }
   
   public static void createHeadlessStop(String xcommand)
   {
      //TODO: Implement factory method
   }
   
   public static void createSnapshot(boolean headless, String xcommand)
   {
      //TODO: Implement factory method
   }
}
