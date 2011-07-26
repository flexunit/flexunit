package org.flexunit.ant.tasks.configuration;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.types.FileSet;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.tasks.types.LoadConfig;

public class TaskConfiguration
{
   private final String DEFAULT_WORKING_PATH = ".";
   private final String DEFAULT_REPORT_PATH = ".";
   private final List<String> VALID_PLAYERS = Arrays.asList(new String[]{"flash", "air"});
   
   private String player = "flash";
   private String jvmArgs = "-Xmx256M"; //MXMLC needs to eat
   private File reportDir = null;
   private File workingDir = null;
   private boolean verbose = false;
   private File flexHome = null;
   
   private Project project;
   private CompilationConfiguration compilationConfiguration;
   private TestRunConfiguration testRunConfiguration;
   
   public TaskConfiguration(Project project)
   {
      this.project = project;
      this.compilationConfiguration = new CompilationConfiguration();
      this.testRunConfiguration = new TestRunConfiguration();
      
      if(project.getProperty("FLEX_HOME") != null)
      {
         this.flexHome = new File(project.getProperty("FLEX_HOME"));
      }
   }
   
   public CompilationConfiguration getCompilationConfiguration()
   {
      return compilationConfiguration;
   }
   
   public TestRunConfiguration getTestRunConfiguration()
   {
      return testRunConfiguration;
   }

   public void setCommand(String commandPath)
   {
      testRunConfiguration.setCommand(project.resolveFile(commandPath));
   }
   
   public void setDisplay(int display)
   {
      testRunConfiguration.setDisplay(display);
   }

   public void setFailOnTestFailure(boolean failOnTestFailure)
   {
      testRunConfiguration.setFailOnTestFailure(failOnTestFailure);
   }

   public void setFailureProperty(String failureProperty)
   {
      testRunConfiguration.setFailureProperty(failureProperty);
   }
   
   public void addSource(FileSet fileset)
   {
      fileset.setProject(project);
      compilationConfiguration.addSource(fileset);
   }
   
   public void addTestSource(FileSet fileset)
   {
      fileset.setProject(project);
      compilationConfiguration.addTestSource(fileset);
   }
   
   public void addLibrary(FileSet fileset)
   {
      fileset.setProject(project);
      compilationConfiguration.addLibrary(fileset);
   }
   
   public void setHeadless(boolean headless)
   {
      testRunConfiguration.setHeadless(headless);
   }

   public void setLocalTrusted(boolean isLocalTrusted)
   {
      testRunConfiguration.setLocalTrusted(isLocalTrusted);
   }

   public void setPlayer(String player)
   {
      this.player = player;
   }

   public void setJvmArgs(String jvmArgs) 
   {
      this.jvmArgs = jvmArgs;	
   }

   public void setPort(int port)
   {
      testRunConfiguration.setPort(port);
   }

   public void setReportDir(String reportDirPath)
   {
      this.reportDir = project.resolveFile(reportDirPath);
   }

   public void setServerBufferSize(int serverBufferSize)
   {
      testRunConfiguration.setServerBufferSize(serverBufferSize);
   }

   public void setSocketTimeout(int socketTimeout)
   {
      testRunConfiguration.setSocketTimeout(socketTimeout);
   }

   public void setSwf(String swf)
   {
      testRunConfiguration.setSwf(project.resolveFile(swf));
   }
   
   public void setSwf(File swf)
   {
      testRunConfiguration.setSwf(swf);
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
   
   public void setWorkingDir(String workingDirPath)
   {
      this.workingDir = project.resolveFile(workingDirPath);
   }
   
   public boolean shouldCompile()
   {
      File swf = testRunConfiguration.getSwf();
      boolean noTestSources = !compilationConfiguration.getTestSources().provided();
      return !noTestSources && (swf == null || !swf.exists());
   }
   
   public void verify() throws BuildException
   {
      validateSharedProperties();
      
      if(shouldCompile())
      {
         compilationConfiguration.validate();
      }
      
      testRunConfiguration.validate();
      
      propagateSharedConfiguration();
   }

   protected void validateSharedProperties() throws BuildException
   {
      LoggingUtil.log("Validating task attributes ...");
      
      if(!VALID_PLAYERS.contains(player))
      {
         throw new BuildException("The provided 'player' property value [" + player + "] must be either of the following values: " + VALID_PLAYERS.toString() + ".");
      }
      
      File swf = testRunConfiguration.getSwf();
      boolean noTestSources = !compilationConfiguration.getTestSources().provided();
      
      if ((swf == null || !swf.exists()) && noTestSources)
      {
         throw new BuildException("The provided 'swf' property value [" + (swf == null ? "" : swf.getPath()) + "] could not be found.");
      }
      
      if(swf != null && !noTestSources)
      {
         throw new BuildException("Please specify the 'swf' property or use the 'testSource' element(s), but not both.");
      }
      
      //if we can't find the FLEX_HOME and we're using ADL or compilation
      if((flexHome == null || !flexHome.exists()) && (new String("air").equals(testRunConfiguration.getPlayer()) || shouldCompile()))
      {
         throw new BuildException("Please specify, or verify the location for, the FLEX_HOME property.  "
               + "It is required when testing with 'air' as the player or when using the 'testSource' element.  "
               + "It should point to the installation directory for a Flex SDK.");
      }
   }
   
   protected void propagateSharedConfiguration()
   {
      LoggingUtil.log("Generating default values ...");
      
      //setup player
      compilationConfiguration.setPlayer(player);
      testRunConfiguration.setPlayer(player);

      //setup jvm arguments
      compilationConfiguration.setJvmArgs(jvmArgs);
      
      //set FLEX_HOME property to respective configs
      compilationConfiguration.setFlexHome(flexHome);
      testRunConfiguration.setFlexHome(flexHome);
      
      //create working directory if needed
      if (workingDir == null || !workingDir.exists())
      {
         workingDir = project.resolveFile(DEFAULT_WORKING_PATH);
         LoggingUtil.log("Using default working dir [" + workingDir.getAbsolutePath() + "]");
      }

      //create directory just to be sure it exists, already existing dirs will not be overwritten
      workingDir.mkdirs();
      
      compilationConfiguration.setWorkingDir(workingDir);
      
      //create report directory if needed
      if (reportDir == null || !reportDir.exists())
      {
         reportDir = project.resolveFile(DEFAULT_REPORT_PATH);
         LoggingUtil.log("Using default reporting dir [" + reportDir.getAbsolutePath() + "]");
      }

      //create directory just to be sure it exists, already existing dirs will not be overwritten
      reportDir.mkdir();
      
      testRunConfiguration.setReportDir(reportDir);
   }
   
   public void setDebug(boolean value)
   {
       compilationConfiguration.setDebug(value);
   }

   public void setLoadConfig(LoadConfig loadconfig)
   {
       compilationConfiguration.setLoadConfig(loadconfig);
   }

}