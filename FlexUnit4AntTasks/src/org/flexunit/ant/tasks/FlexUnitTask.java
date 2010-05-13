package org.flexunit.ant.tasks;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.types.FileSet;
import org.flexunit.ant.tasks.configuration.TaskConfiguration;

public class FlexUnitTask extends Task
{
   private TaskConfiguration configuration;

   public FlexUnitTask()
   {
   }
   
   @Override
   public void setProject(Project project)
   {
      //create a subproject so we can use the notion of working directory w/o changing the project containing this task
      Project subproject = project.createSubProject();
      
      //copy over FLEX_HOME property since subprojects don't get their parent project's properties
      subproject.setProperty("FLEX_HOME", project.getProperty("FLEX_HOME"));
      
      super.setProject(subproject);
      configuration = new TaskConfiguration(subproject);
   }
   
   /**
    * Sets local trusted, default is false
    * 
    * @param localTrusted
    */
   public void setLocalTrusted(final boolean localTrusted)
   {
      configuration.setLocalTrusted(localTrusted);
   }

   /**
    * Set the port to receive the test results on. Default is 1024
    * 
    * @param serverPort
    *           the port to set.
    */
   public void setPort(final int serverPort)
   {
      configuration.setPort(serverPort);
   }

   /**
    * Set the timeout for receiving the flexunit report.
    * 
    * @param timeout
    *           in milliseconds.
    */
   public void setTimeout(final int timeout)
   {
      configuration.setSocketTimeout(timeout);
   }

   /**
    * The buffer size the {@FlexUnitSocketServer} uses
    * for its inbound data stream.
    */
   public void setBuffer(final int size)
   {
      configuration.setServerBufferSize(size);
   }

   /**
    * The SWF for the FlexUnit tests to run.
    * 
    * @param testSWF
    *           the SWF to set.
    */
   public void setSWF(final String testSWF)
   {
      configuration.setSwf(testSWF);
   }

   /**
    * Set the directory to output the test reports to.
    * 
    * @param toDir
    *           the directory to set.
    */
   public void setToDir(final String toDir)
   {
      configuration.setReportDir(toDir);
   }

   /**
    * Should we fail the build if the flex tests fail?
    * 
    * @param fail
    */
   public void setHaltonfailure(final boolean fail)
   {
      configuration.setFailOnTestFailure(fail);
   }

   /**
    * Custom ant property noting test failure
    * 
    * @param failprop
    */
   public void setFailureproperty(final String failprop)
   {
      configuration.setFailureProperty(failprop);
   }

   /**
    * Toggle display of descriptive messages
    * 
    * @param verbose
    */
   public void setVerbose(final boolean verbose)
   {
      configuration.setVerbose(verbose);
   }

   public void setPlayer(String player)
   {
      configuration.setPlayer(player);
   }

   public void setCommand(String executableFilePath)
   {
      configuration.setCommand(executableFilePath);
   }

   public void setHeadless(boolean headless)
   {
      configuration.setHeadless(headless);
   }

   public void setDisplay(int number)
   {
      configuration.setDisplay(number);
   }
   
   public void addTestSource(FileSet fileset)
   {
      configuration.addTestSource(fileset);
   }
   
   public void addLibrary(FileSet fileset)
   {
      configuration.addLibrary(fileset);
   }
   
   public void setWorkingDir(String workingDirPath)
   {
      getProject().setBaseDir(getProject().resolveFile(workingDirPath));
   }

   /**
    * Called by Ant to execute the task.
    */
   public void execute() throws BuildException
   {
      //verify entire configuration
      configuration.verify();
      
      //compile tests if necessary
      if(configuration.shouldCompile())
      {
         Compilation compilation = new Compilation(getProject(), configuration.getCompilationConfiguration());
         configuration.setSwf(compilation.compile());
      }
      
      //executes tests
      TestRun testRun = new TestRun(getProject(), configuration.getTestRunConfiguration());
      testRun.run();
   }
}
