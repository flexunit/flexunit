package org.flexunit.ant.launcher.commands;

import java.io.IOException;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;
import org.apache.tools.ant.taskdefs.ExecuteWatchdog;
import org.apache.tools.ant.taskdefs.PumpStreamHandler;
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
       return execute(null);
   }
   
   public Process launch(long timeoutMsec) throws IOException
   {
      ExecuteWatchdog watchdog = new ExecuteWatchdog(timeoutMsec);
      execute(watchdog);
      
      return null;
   }

   private int execute(ExecuteWatchdog watchdog) throws IOException
   {
       Execute execute = new Execute(new PumpStreamHandler(), watchdog);
       execute.setCommandline(getCommandLine().getCommandline());
       execute.setAntRun(getProject());
       execute.setEnvironment(getEnvironment());
       
       LoggingUtil.log(getCommandLine().describeCommand());
       
       try 
       {
           return execute.execute();
       }
       catch (IOException e) 
       {
           LoggingUtil.log("IOException when executing command: " + e);
           throw e;
       }
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
