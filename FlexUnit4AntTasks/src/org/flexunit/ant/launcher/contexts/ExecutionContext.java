package org.flexunit.ant.launcher.contexts;

import java.io.IOException;

import org.apache.tools.ant.Project;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;

/**
 * Basis for executing a player command.
 */
public interface ExecutionContext
{
   public void setProject(Project project);
   public void setCommand(PlayerCommand command);
   
   /**
    * Starts the execution context and any work associated with the individual implementations.
    * 
    * @throws IOException
    */
   public void start() throws IOException;
   
   /**
    * Stops the execution context and manages the player Process as well as any work associated
    * with the individual implementations.
    * 
    * @param playerProcess
    * @throws IOException
    */
   public void stop(Process playerProcess) throws IOException;
}
