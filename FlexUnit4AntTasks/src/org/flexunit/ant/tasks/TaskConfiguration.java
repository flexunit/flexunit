package org.flexunit.ant.tasks;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.OperatingSystem;

public class TaskConfiguration
{
   private static final String DEFAULT_REPORT_PATH = ".";
   private static final int FLOOR_FOR_PORT = 1;
   private static final int SHORTEST_SOCKET_TIMEOUT = 5000; //ms
   private static final List<String> VALID_PLAYERS = Arrays.asList(new String[]{"flash", "air"});
   
   private File command = null;
   private int display = 99;
   private boolean failOnTestFailure = false;
   private String failureProperty = "flexunit.failed";
   private boolean headless = false;
   private boolean isLocalTrusted = true;
   private String player = "flash";
   private int port = 1024;
   private File reportDir = null;
   private int serverBufferSize = 262144; //bytes
   private int socketTimeout = 60000; //milliseconds
   private File swf = null;
   private boolean verbose = false;
   
   private Project project;
   
   public TaskConfiguration(Project project)
   {
      this.project = project;
   }

   public File getCommand()
   {
      return command;
   }

   public void setCommand(String commandPath)
   {
      this.command = project.resolveFile(commandPath);
   }
   
   public boolean isCustomCommand()
   {
      return command != null;
   }

   public int getDisplay()
   {
      return display;
   }

   public void setDisplay(int display)
   {
      this.display = display;
   }

   public boolean isFailOnTestFailure()
   {
      return failOnTestFailure;
   }

   public void setFailOnTestFailure(boolean failOnTestFailure)
   {
      this.failOnTestFailure = failOnTestFailure;
   }

   public String getFailureProperty()
   {
      return failureProperty;
   }

   public void setFailureProperty(String failureProperty)
   {
      this.failureProperty = failureProperty;
   }

   public boolean isHeadless()
   {
      return headless;
   }

   public void setHeadless(boolean headless)
   {
      this.headless = headless;
   }

   public boolean isLocalTrusted()
   {
      return isLocalTrusted;
   }
   
   public boolean usePolicyFile()
   {
      return !isLocalTrusted && player.equals("flash");
   }

   public void setLocalTrusted(boolean isLocalTrusted)
   {
      this.isLocalTrusted = isLocalTrusted;
   }

   public String getPlayer()
   {
      return player;
   }

   public void setPlayer(String player)
   {
      this.player = player;
   }

   public int getPort()
   {
      return port;
   }

   public void setPort(int port)
   {
      this.port = port;
   }

   public File getReportDir()
   {
      return reportDir;
   }

   public void setReportDir(String reportDirPath)
   {
      this.reportDir = project.resolveFile(reportDirPath);
   }

   public int getServerBufferSize()
   {
      return serverBufferSize;
   }

   public void setServerBufferSize(int serverBufferSize)
   {
      this.serverBufferSize = serverBufferSize;
   }

   public int getSocketTimeout()
   {
      return socketTimeout;
   }

   public void setSocketTimeout(int socketTimeout)
   {
      this.socketTimeout = socketTimeout;
   }

   public File getSwf()
   {
      return swf;
   }

   public void setSwf(String swf)
   {
      this.swf = project.resolveFile(swf);
   }

   public boolean isVerbose()
   {
      return verbose;
   }

   public void setVerbose(boolean verbose)
   {
      this.verbose = verbose;
      LoggingUtil.VERBOSE = verbose;
   }
   
   public void verify() throws BuildException
   {
      validateInputs();
      generateDefaultValues();
      logInputValues();
   }

   /**
    * Validates all attribute values of the task
    */
   protected void validateInputs()
   {
      LoggingUtil.log("Validating task attributes ...");
      
      // Check a SWF was specified.
      if (swf == null || !swf.exists())
      {
         throw new BuildException("The provided 'swf' property value [" + swf.getPath() + "] could not be found.");
      }
      
      if(port < FLOOR_FOR_PORT)
      {
         throw new BuildException("The provided 'port' property value [" + port + "] must be great than " + FLOOR_FOR_PORT + ".");
      }
      
      if(socketTimeout < SHORTEST_SOCKET_TIMEOUT)
      {
         throw new BuildException("The provided 'timeout' property value [" + socketTimeout + "] must be great than " + SHORTEST_SOCKET_TIMEOUT + ".");
      }
      
      if(reportDir != null && !reportDir.exists())
      {
         LoggingUtil.log("Provided report directory path [" + reportDir.getPath() + "] does not exist.");
      }
      
      if(!VALID_PLAYERS.contains(player))
      {
         throw new BuildException("The provided 'player' property value [" + player + "] must be either of the following values: " + VALID_PLAYERS.toString() + ".");
      }
      
      if(command != null && !command.exists())
      {
         throw new BuildException("The provided command path [" + command + "] does not exist.");
      }
      
      if(headless)
      {
         if(OperatingSystem.identify() != OperatingSystem.LINUX)
         {
            throw new BuildException("Headless mode can only be used on Linux with vncserver installed.");
         }
         
         if(display < 1)
         {
            throw new BuildException("The provided 'display' number must be set higher than 0.  99 or higher is recommended.");
         }
      }
   }
   
   /**
    * Generates default values for configuration which are not directly provided by the user.
    */
   protected void generateDefaultValues()
   {
      LoggingUtil.log("Generating default values ...");
      
      //create report directory if needed
      if (reportDir == null || !reportDir.exists())
      {
         reportDir = project.resolveFile(DEFAULT_REPORT_PATH);
         LoggingUtil.log("Using default reporting dir [" + reportDir.getAbsolutePath() + "]");
      }

      //create directory just to be sure it exists, already existing dirs will not be overwritten
      reportDir.mkdir();
   }
   
   /**
    * Logs the values of all attributes on the configuration
    */
   protected void logInputValues()
   {
      LoggingUtil.log("Using the following settings:");
      LoggingUtil.log("\thaltonfailure: [" + failOnTestFailure + "]");
      LoggingUtil.log("\theadless: [" + headless + "]");
      LoggingUtil.log("\tdisplay: [" + display + "]");
      LoggingUtil.log("\tlocalTrusted: [" + isLocalTrusted + "]");
      LoggingUtil.log("\tplayer: [" + player + "]");
      if(isCustomCommand())
      {
         LoggingUtil.log("\tcommand: [" + command + "]");
      }
      LoggingUtil.log("\tport: [" + port + "]");
      LoggingUtil.log("\tswf: [" + swf + "]");
      LoggingUtil.log("\ttimeout: [" + socketTimeout + "ms]");
      LoggingUtil.log("\ttoDir: [" + reportDir.getAbsolutePath() + "]");
      LoggingUtil.log("\tverbose: [" + verbose + "]");
   }
}
