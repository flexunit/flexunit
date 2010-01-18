package org.flexunit.ant.launcher.commands.player;

import java.io.File;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Execute;
import org.flexunit.ant.launcher.commands.Command;

/**
 * Class used to abstract an extension of {@link Execute} that has its own handle to a {@link Project}
 * and can setup context for using the project
 */
public abstract class PlayerCommand extends Command
{
   private File swf;
   
   public PlayerCommand()
   {
      super();
   }

   public void setSwf(File swf)
   {
      this.swf = swf;
   }

   public File getSwf()
   {
      return swf;
   }
}
