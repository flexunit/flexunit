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
import org.flexunit.ant.launcher.commands.player.AdlCommand;
import org.flexunit.ant.launcher.commands.player.PlayerCommand;
import org.flexunit.ant.launcher.commands.player.PlayerCommandFactory;
import org.flexunit.ant.launcher.contexts.ExecutionContext;
import org.flexunit.ant.launcher.contexts.ExecutionContextFactory;
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
         // setup daemon
         Future<Object> daemon = setupSocketThread();

         // run the execution context and player
         PlayerCommand player = obtainPlayer();
         ExecutionContext context = obtainContext(player);
         
         //start the execution context
         context.start();
         
         // launch the player.  Note, this is sometimes a blocking call
         // and sometimes not, depending on the player configuration.  If
         // blocking, process will be 'null'.
         Process process = player.launch(configuration.getSocketTimeout());

         // block until daemon is completely done with all test data
         daemon.get();

         //stop the execution context now that socket thread is done
         context.stop(process);

         // print summaries and check for failure
         analyzeReports();

      } 
      catch (Exception e)
      {
         throw new BuildException(e);
      }
   }
   
   /**
    * Fetch the player command to execute the SWF.
    * 
    * @return PlayerCommand based on user config
    */
   protected PlayerCommand obtainPlayer()
   {
      // get command from factory
      PlayerCommand command = PlayerCommandFactory.createPlayer(
            configuration.getOs(), 
            configuration.getPlayer(), 
            configuration.getCommand(), 
            configuration.isLocalTrusted());
      
      command.setProject(project);
      command.setSwf(configuration.getSwf());
      command.setUrl(configuration.getUrl());
      
      if(command instanceof AdlCommand) 
      {
          AdlCommand adlCommand = (AdlCommand)command;
          adlCommand.setPrecompiledAppDescriptor(configuration.getPrecompiledAppDescriptor());
          adlCommand.setAirArguments(configuration.getAirArguments());
      }
      
      return command;
   }
   
   /**
    * 
    * @param player PlayerCommand which should be executed
    * @return Context to wrap the execution of the PlayerCommand
    */
   protected ExecutionContext obtainContext(PlayerCommand player)
   {
      ExecutionContext context = ExecutionContextFactory.createContext(
            configuration.getOs(), 
            configuration.isHeadless(), 
            configuration.getDisplay());
      
      context.setProject(project);
      context.setCommand(player);
      
      return context;
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
