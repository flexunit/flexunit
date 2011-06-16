package org.flexunit.ant.launcher.commands.player;

import java.io.File;
import java.io.IOException;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;

/**
 * Class used to abstract an extension of {@link Execute} that has its own handle to a {@link Project}
 * and can setup context for using the project
 */
public interface PlayerCommand
{
   public void setProject(Project project);
   public void setEnvironment(String[] variables);
   public File getFileToExecute();
   public void setSwf(File swf);
   public void setUrl(String url);
   public void prepare();
   /**
    * Launches the player.  Depending on the implementation, this call will
    * either block until the player exits, in which cases the return value
    * is null, or return an asynchronous Process object.  Only when blocking
    * is the timeout parameter respected.
    * @param timeoutMsec The maximum amount of time to wait for the call to
    * return.
    * @throws IOException Thrown on launch failure, including timeout
    */
   public Process launch(long timeoutMsec) throws IOException;
}
