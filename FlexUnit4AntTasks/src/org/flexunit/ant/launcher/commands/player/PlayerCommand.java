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
   public Process launch() throws IOException;
}
