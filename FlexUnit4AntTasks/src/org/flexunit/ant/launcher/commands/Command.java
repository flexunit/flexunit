package org.flexunit.ant.launcher.commands;

import java.io.IOException;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;
import org.apache.tools.ant.types.Commandline;

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
      Execute exec = new Execute();
      exec.setAntRun(getProject());
      exec.setWorkingDirectory(getProject().getBaseDir());
      exec.setCommandline(getCommandLine().getCommandline());
      exec.setEnvironment(getEnvironment());
      return exec.execute();
   }
   
   public Process launch() throws IOException
   {
      return Runtime.getRuntime().exec(getCommandLine().getCommandline(), getEnvironment(), getProject().getBaseDir());
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
