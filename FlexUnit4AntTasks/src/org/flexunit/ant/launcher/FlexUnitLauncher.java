package org.flexunit.ant.launcher;

import java.io.File;
import java.io.IOException;

import org.apache.tools.ant.Project;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;

/**
 * This class is used to launch the FlexUnit tests.
 */
public class FlexUnitLauncher
{
   private static final String WINDOWS_OS = "Windows";
   private static final String MAC_OS_X = "Mac OS X";

   private boolean localTrusted;
   private boolean headless;
   private boolean snapshot;
   private String player;
   private String xcommand;
   private File snapshotFile;
   
   private Project project;
   private OperatingSystem os;

   public FlexUnitLauncher(Project project, boolean localTrusted, boolean headless, String player, String xcommand, boolean snapshot, File snapshotFile)
   {
      this.project = project;
      this.localTrusted = localTrusted;
      this.headless = headless;
      this.snapshot = snapshot;
      this.player = player;
      this.xcommand = xcommand;
      this.snapshotFile = snapshotFile;
      
      this.os = identifyOperatingSystem();
   }
   
   private OperatingSystem identifyOperatingSystem()
   {
      OperatingSystem os = null;
      String env = System.getProperty("os.name");

      if (env.startsWith(WINDOWS_OS))
      {
         LoggingUtil.log("OS: [Windows]");
         os = OperatingSystem.WINDOWS;
      }
      else if (env.startsWith(MAC_OS_X))
      {
         LoggingUtil.log("OS: [Mac OSX]");
         os = OperatingSystem.MACOSX;
      }
      else
      {
         LoggingUtil.log("OS: [Unix]");
         os = OperatingSystem.UNIX;
      }
      
      return os;
   }
   
   public void runTests(File swf) throws IOException
   {
      if(headless)
      {
         //creat headless process and run
         CommandFactory.createHeadlessStart(xcommand);
      }
      
      //setup command to run
      PlayerCommand command = CommandFactory.createPlayer(os, player, localTrusted);
      command.setProject(project);
      command.setSwf(swf);
      
      //run player command
      LoggingUtil.log("Launching player:\n" + command.describe());
      command.execute();
      
      if(snapshot)
      {
         //create snapshot command and run
         CommandFactory.createSnapshot(headless, xcommand);
      }
      
      if(headless)
      {
         //create stop headless process and run
         CommandFactory.createHeadlessStop(xcommand);
      }
   }
}