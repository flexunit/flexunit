package org.flexunit.ant.tasks.configuration;

import java.io.File;

import org.apache.tools.ant.BuildException;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.OperatingSystem;

public class TestRunConfiguration implements StepConfiguration
{
   private final int FLOOR_FOR_PORT = 1;
   private final int SHORTEST_SOCKET_TIMEOUT = 5000; //ms

   private String player;
   private File command = null;
   private int display = 99;
   private boolean failOnTestFailure = false;
   private String failureProperty = "flexunit.failed";
   private File flexHome = null;
   private boolean headless = false;
   private boolean isLocalTrusted = true;
   private int port = 1024;
   private File reportDir = null;
   private int serverBufferSize = 262144; //bytes
   private int socketTimeout = 60000; //milliseconds
   private File swf = null;
   private String url = null;
   private File precompiledAppDescriptor = null;
   private OperatingSystem os = OperatingSystem.identify();
   
   public File getCommand()
   {
      return command;
   }

   public void setCommand(File command)
   {
      this.command = command;
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
   
   public File getFlexHome()
   {
      return flexHome;
   }
   
   public void setFlexHome(File flexHome)
   {
      this.flexHome = flexHome;
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

   public void setReportDir(File reportDir)
   {
      this.reportDir = reportDir;
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
   
   public void setSwf(File swf)
   {
      this.swf = swf;
   }
   
   public String getUrl() 
   {
	   return url;
   }

   public void setUrl(String url) 
   {
	   this.url = url;
   }

   public File getPrecompiledAppDescriptor() 
   {
	   return precompiledAppDescriptor;
   }

   public void setPrecompiledAppDescriptor(File precompiledAppDescriptor) 
   {
	   this.precompiledAppDescriptor = precompiledAppDescriptor;
   }

   public OperatingSystem getOs()
   {
      return os;
   }

   public void validate() throws BuildException
   {
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
   
   public void log()
   {
      LoggingUtil.log("Using the following settings for the test run:");
      
      //FLEX_HOME not required to run if not using ADL
      if(flexHome != null)
      {
         LoggingUtil.log("\tFLEX_HOME: [" + flexHome.getAbsolutePath() + "]");         
      }
      
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
   }
}
