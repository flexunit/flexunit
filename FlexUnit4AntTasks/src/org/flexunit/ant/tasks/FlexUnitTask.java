package org.flexunit.ant.tasks;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;
import org.flexunit.ant.FlexUnitSocketServer;
import org.flexunit.ant.FlexUnitSocketThread;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.FlexUnitLauncher;
import org.flexunit.ant.report.Reports;

public class FlexUnitTask extends Task
{
   private static final String TRUE = "true";

   // Suite building variables
   private Reports reports;

   // configuration for task
   private TaskConfiguration configuration;

   public FlexUnitTask()
   {
      this.reports = new Reports();
   }
   
   @Override
   public void setProject(Project project) 
   {
      super.setProject(project);
      this.configuration = new TaskConfiguration(project);
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

   /**
    * Called by Ant to execute the task.
    */
   public void execute() throws BuildException
   {
      configuration.verify();

      try
      {
         // setup callable thread
         Future<Object> future = setupSocketThread();

         // launch FlashPlayer and test SWF
         Process player = launchTestSuite();

         // block until thread is completely done with all tests
         future.get();

         // kill the player if using a custom command
         if (configuration.isCustomCommand())
         {
            player.destroy();
         }

         // print summaries and check for failure
         analyzeReports();

      } catch (Exception e)
      {
         throw new BuildException(e);
      }
   }

   /**
    * Create and launch the swf player in the appropriate domain
    */
   protected Process launchTestSuite()
   {
      Process process = null;
      final FlexUnitLauncher browser = new FlexUnitLauncher(getProject(),
            configuration.isLocalTrusted(), configuration.isHeadless(),
            configuration.getDisplay(), configuration.getPlayer(),
            configuration.getCommand());

      try
      {
         process = browser.runTests(configuration.getSwf());
      } catch (Exception e)
      {
         throw new BuildException("Error launching the test runner.", e);
      }

      return process;
   }

   /**
    * Create a server socket for receiving the test reports from FlexUnit. We
    * read and write the test reports inside of a Thread.
    */
   protected Future<Object> setupSocketThread()
   {
      LoggingUtil.log("Setting up server process ...");

      // Create server for use by thread
      FlexUnitSocketServer server = new FlexUnitSocketServer(configuration.getPort(), 
            configuration.getSocketTimeout(), configuration.getServerBufferSize(), 
            configuration.usePolicyFile());

      // Get handle to specialized object to run in separate thread.
      Callable<Object> operation = new FlexUnitSocketThread(server,
            configuration.getReportDir(), reports);

      // Get handle to service to run object in thread.
      ExecutorService executor = Executors.newSingleThreadExecutor();

      // Run object in thread and return Future.
      return executor.submit(operation);
   }

   /**
    * End of test report run. Called at the end of a test run. If verbose is set
    * to true reads all suites in the suite list and prints out a descriptive
    * message including the name of the suite, number of tests run and number of
    * tests failed, ignores any errors. If any tests failed during the test run,
    * the build is halted.
    */
   protected void analyzeReports()
   {
      LoggingUtil.log("Analyzing reports ...");

      // print out all report summaries
      LoggingUtil.log("\n" + reports.getSummary(), true);

      if (reports.hasFailures())
      {
         getProject().setNewProperty(configuration.getFailureProperty(), TRUE);

         if (configuration.isFailOnTestFailure())
         {
            throw new BuildException("FlexUnit tests failed during the test run.");
         }
      }
   }
}
