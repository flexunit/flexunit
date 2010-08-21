package org.flexunit.ant.tasks;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.flexunit.ant.FlexUnitSocketServer;
import org.flexunit.ant.FlexUnitSocketThread;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.FlexUnitLauncher;
import org.flexunit.ant.report.Reports;
import org.flexunit.ant.tasks.configuration.TestRunConfiguration;

public class TestRun
{
   private final String TRUE = "true";
   
   private TestRunConfiguration configuration;
   private Project project;
   
   private Reports reports;

   public TestRun(Project project, TestRunConfiguration configuration)
   {
      this.project = project;
      this.configuration = configuration;
      this.reports = new Reports();
   }
   
   public void run() throws BuildException
   {
      configuration.log();
      
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

      } 
      catch (Exception e)
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
      final FlexUnitLauncher launcher = new FlexUnitLauncher(project,
            configuration.isLocalTrusted(), configuration.isHeadless(),
            configuration.getDisplay(), configuration.getPlayer(),
            configuration.getCommand());

      try
      {
         process = launcher.runTests(configuration.getSwf());
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
         project.setNewProperty(configuration.getFailureProperty(), TRUE);

         if (configuration.isFailOnTestFailure())
         {
            throw new BuildException("FlexUnit tests failed during the test run.");
         }
      }
   }
}
