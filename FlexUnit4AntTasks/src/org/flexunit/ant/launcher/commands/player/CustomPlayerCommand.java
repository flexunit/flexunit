package org.flexunit.ant.launcher.commands.player;

import java.io.File;
import java.io.IOException;

import org.apache.tools.ant.Project;

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
   
   public Process launch() throws IOException
   {
      proxiedCommand.getCommandLine().setExecutable(executable.getAbsolutePath());
      return proxiedCommand.launch();
   }

   public String describe()
   {
      return proxiedCommand.describe();
   }

   public void setEnvironment(String[] variables)
   {
      proxiedCommand.setEnvironment(variables);
   }

   public void setSwf(File swf)
   {
      proxiedCommand.setSwf(swf);
   }
}
