package org.flexunit.ant.launcher.commands;

import java.io.IOException;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;
import org.apache.tools.ant.types.Commandline;
import org.flexunit.ant.LoggingUtil;

public abstract class Command
{
   private Project project;
   private Commandline commandLine;
   private String[] environment;

   public Command()
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

   public Commandline getCommandLine()
   {
      return commandLine;
   }
   
   public int execute() throws IOException
   {
      int exitCode = -1;
      Process process = launch();
      
      try
      {
         exitCode = process.waitFor();
      }
      catch(InterruptedException ie)
      {
         LoggingUtil.log("Command interrupted, exiting with failure code.");
         process.destroy();
      }
      
      return exitCode;
   }
   
   public Process launch() throws IOException
   {
      return Execute.launch(project, getCommandLine().getCommandline(), new String[]{}, getProject().getBaseDir(), true);
   }

   public void setEnvironment(String[] variables)
   {
      this.environment = variables;
   }

   public String[] getEnvironment()
   {
      return environment;
   }
   
   public String describe()
   {
      return getCommandLine().describeCommand();
   }

}
