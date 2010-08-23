package org.flexunit.ant.launcher.commands.player;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Vector;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;
import org.flexunit.ant.LoggingUtil;

public class CustomPlayerCommand implements PlayerCommand
{
   private DefaultPlayerCommand proxiedCommand;
   private File executable;

   public PlayerCommand getProxiedCommand()
   {
      return proxiedCommand;
   }
   
   public void setProxiedCommand(DefaultPlayerCommand playerCommand)
   {
      this.proxiedCommand = playerCommand;
   }

   public File getExecutable()
   {
      return executable;
   }
   
   public void setExecutable(File executable)
   {
      this.executable = executable;
   }
   
   public void setProject(Project project)
   {
      proxiedCommand.setProject(project);
   }
   
   public void setSwf(File swf)
   {
      proxiedCommand.setSwf(swf);
   }
   
   public File getFileToExecute()
   {
      return proxiedCommand.getFileToExecute();
   }
   
   public void prepare()
   {
      proxiedCommand.prepare();
      
      proxiedCommand.getCommandLine().setExecutable(executable.getAbsolutePath());
      proxiedCommand.getCommandLine().clearArgs();
      proxiedCommand.getCommandLine().addArguments(new String[]{getFileToExecute().getAbsolutePath()});
   }
   
   public Process launch() throws IOException
   {
      prepare();
      
      LoggingUtil.log(proxiedCommand.getCommandLine().describeCommand());
      
      //execute the command directly using Runtime
      return Runtime.getRuntime().exec(
            proxiedCommand.getCommandLine().getCommandline(), 
            getProcessEnvironment(), 
            proxiedCommand.getProject().getBaseDir());
   }

   public void setEnvironment(String[] variables)
   {
      proxiedCommand.setEnvironment(variables);
   }

   /**
    * Combine process environment variables and command's environment to emulate the default
    * behavior of the Execute task.  Needed especially when using Xvnc with a custom command.
    */
   @SuppressWarnings("unchecked")
   private String[] getProcessEnvironment()
   {
      Vector procEnvironment = Execute.getProcEnvironment();
      String[] environment = new String[procEnvironment.size() + proxiedCommand.getEnvironment().length];
      System.arraycopy(procEnvironment.toArray(), 0, environment, 0, procEnvironment.size());
      System.arraycopy(proxiedCommand.getEnvironment(), 0, environment, procEnvironment.size(), proxiedCommand.getEnvironment().length);
      
      LoggingUtil.log("Environment variables: " + Arrays.toString(environment));
      
      return environment;
   }
}
