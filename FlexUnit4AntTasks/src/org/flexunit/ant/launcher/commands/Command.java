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
      environment = new String[0];
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
      Execute execute = new Execute();
      execute.setCommandline(getCommandLine().getCommandline());
      execute.setAntRun(getProject());
      execute.setEnvironment(getEnvironment());
      
      LoggingUtil.log(getCommandLine().describeCommand());
      
      return execute.execute();
   }
   
   public Process launch() throws IOException
   {
      Execute execute = new Execute();
      execute.setCommandline(getCommandLine().getCommandline());
      execute.setAntRun(getProject());
      execute.setEnvironment(getEnvironment());
      
      LoggingUtil.log(getCommandLine().describeCommand());
      
      execute.execute();
      
      //By default we use the Ant Execute task which does not give us a handle to a process
      return null;
   }

   public void setEnvironment(String[] variables)
   {
      this.environment = variables;
   }

   public String[] getEnvironment()
   {
      return environment;
   }

}
