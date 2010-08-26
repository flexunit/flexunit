package org.flexunit.ant.launcher.contexts;

import java.io.IOException;

import org.apache.tools.ant.Project;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.commands.headless.XvncException;
import org.flexunit.ant.launcher.commands.headless.XvncStartCommand;
import org.flexunit.ant.launcher.commands.headless.XvncStopCommand;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;

/**
 * Context used to wrap a call to the player command in a start and stop of a vncserver.
 * All vncserver commands are blocking.
 */
public class HeadlessContext implements ExecutionContext
{
   private PlayerCommand playerCommand;
   private int startDisplay;
   private int finalDisplay;
   private Project project;
   
   public HeadlessContext(int display)
   {
      this.startDisplay = display;
   }
   
   public void setProject(Project project)
   {
      this.project = project;
   }
   
   public void setCommand(PlayerCommand command)
   {
      this.playerCommand = command;
   }
   
   public void start() throws IOException
   {
      // setup vncserver on the provided display
      XvncStartCommand xvncStart = new XvncStartCommand(startDisplay);
      xvncStart.setProject(project);
      
      LoggingUtil.log("Starting xvnc", true);
      
      // execute the maximum number of cycle times before throwing an exception
      while (xvncStart.execute() != 0)
      {
         LoggingUtil.log("Cannot start xnvc on :" + xvncStart.getCurrentDisplay() + ", cycling ...");
         
         try
         {
            xvncStart.cycle();
         }
         catch (XvncException xe) {
            throw new IOException(xe);
         }
      }
         
      finalDisplay = xvncStart.getCurrentDisplay();
      
      //setup player command to use the right display in its env when launching
      playerCommand.setEnvironment(new String[]{ "DISPLAY=:" + finalDisplay });
      LoggingUtil.log("Setting DISPLAY=:" + finalDisplay);
      
      //prep anything the command needs to run
      playerCommand.prepare();
   }
   
   public void stop(Process playerProcess) throws IOException
   {
      // destroy the process related to the player if it exists
      if(playerProcess != null)
      {
         playerProcess.destroy();
      }
      
      // Now stop the vncserver that the player has been destroyed
      XvncStopCommand xvncStop = new XvncStopCommand(finalDisplay);
      xvncStop.setProject(project);
      xvncStop.execute();
   }
}
