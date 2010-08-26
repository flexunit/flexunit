package org.flexunit.ant.launcher.contexts;

import java.io.IOException;

import org.apache.tools.ant.Project;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;

public class DefaultContext implements ExecutionContext
{
   private PlayerCommand command;
   
   @SuppressWarnings("unused")
   private Project project;
   
   public void setProject(Project project)
   {
      this.project = project;
   }
   public void setCommand(PlayerCommand command)
   {
      this.command = command;
   }

   public void start() throws IOException
   {
      //prep anything the command needs to run
      command.prepare();
   }

   public void stop(Process playerProcess) throws IOException
   {
      //destroy the process related to the player if it exists
      if(playerProcess != null)
      {
         playerProcess.destroy();
      }
   }
}
