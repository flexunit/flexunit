package org.flexunit.ant.launcher.commands.player;

import java.io.File;
import java.io.IOException;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;
import org.apache.tools.ant.types.Commandline;

/**
 * Class used to abstract an extension of {@link Execute} that has its own handle to a {@link Project}
 * and can setup context for using the project
 */
public abstract class PlayerCommand extends Execute
{
   private Project project;
   private File swf;
   private Commandline commandLine;
   
   public PlayerCommand()
   {
      super();
      
      this.commandLine = new Commandline();
   }

   public void setProject(Project project)
   {
      this.project = project;
   }
   
   public Project getProject()
   {
      return project;
   }
   
   
   public void setSwf(File swf)
   {
      this.swf = swf;
   }

   public File getSwf()
   {
      return swf;
   }

   public Commandline getCommandLine()
   {
      return commandLine;
   }

   @Override
   public int execute() throws IOException
   {
      //prepare the task
      super.setAntRun(project);
      super.setWorkingDirectory(project.getBaseDir());
      super.setCommandline(getCommandLine().getCommandline());
      
      return super.execute();
   }
   
   public String describe()
   {
      return getCommandLine().describeCommand();
   }
}
