package org.flexunit.ant.launcher;

import java.io.File;
import java.io.IOException;

import org.apache.tools.ant.Project;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.commands.headless.XvncStartCommand;
import org.flexunit.ant.launcher.commands.headless.XvncException;
import org.flexunit.ant.launcher.commands.headless.XvncStopCommand;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;

/**
 * This class is used to launch the FlexUnit tests.
 */
public class FlexUnitLauncher
{
   private boolean localTrusted;
   private boolean headless;
   private int display;
   private String player;
   private File customCommand;

   private Project project;
   private OperatingSystem os;

   public FlexUnitLauncher(Project project, boolean localTrusted, boolean headless, int display, String player, File customCommand)
   {
      this.project = project;
      this.localTrusted = localTrusted;
      this.headless = headless;
      this.display = display;
      this.player = player;
      this.customCommand = customCommand;

      this.os = OperatingSystem.identify();
   }

   private boolean runHeadless()
   {
      return headless && (os == OperatingSystem.LINUX);
   }

   public Process runTests(File swf) throws IOException, XvncException
   {
      // seutp locally scope handles to commands
      XvncStartCommand xvncStart = null;
      PlayerCommand command = null;
      XvncStopCommand xvncStop = null;
      
      Process process = null;

      //run xvnc start if headless build
      if (runHeadless())
      {
         LoggingUtil.log("Starting xvnc", true);

         // setup vncserver on the provided display
         xvncStart = new XvncStartCommand(display);
         xvncStart.setProject(project);

         // execute the maximum number of cycle times before throwing an exception
         try
         {
            while (xvncStart.execute() != 0)
            {
               LoggingUtil.log("Cannot start xnvc on :" + xvncStart.getCurrentDisplay() + ", cycling ...");
               xvncStart.cycle();
            }
         } catch (IOException ioe)
         {
            throw new XvncException();
         }
      }

      // setup command to run
      command = CommandFactory.createPlayer(os, player, customCommand, localTrusted);
      command.setProject(project);
      command.setSwf(swf);
      if (runHeadless())
      {
         command.setEnvironment(new String[]{ "DISPLAY=:" + xvncStart.getCurrentDisplay() });
         LoggingUtil.log("Setting DISPLAY=:" + xvncStart.getCurrentDisplay());
      }

      LoggingUtil.log("Launching player:\n" + command.describe());
      
      // run player command
      process = command.launch();

      //run xvnc stop if headless build
      if (runHeadless())
      {
         xvncStop = new XvncStopCommand(display);
         xvncStop.setProject(project);
         xvncStop.execute();
      }
      
      return process;
   }
}