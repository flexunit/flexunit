package org.flexunit.ant.launcher.commands.player;

public class NonWindowsAdlCommand extends AdlCommand
{
   @Override
   protected String getAdlFilename()
   {
      return "adl";
   }
}
