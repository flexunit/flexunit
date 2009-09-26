package org.flexunit.ant.tasks;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import org.flexunit.ant.FlexUnitSocketServer;
import org.flexunit.ant.FlexUnitSocketThread;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.FlexUnitLauncher;
import org.flexunit.ant.report.Reports;

public class FlexUnitTask extends Task
{
   private static final String TRUE = "true";
   private static final String DEFAULT_REPORT_PATH = ".";
   private static final String DEFAULT_SNAPSHOT_FILENAME = "snapshot.jpg";
   private static final int FLOOR_FOR_PORT = 1;
   private static final int SHORTEST_SOCKET_TIMEOUT = 5000; //ms
   private static final List<String> VALID_PLAYERS = Arrays.asList(new String[]{"flash", "air"});
   private static final List<String> VALID_XCOMMANDS = Arrays.asList(new String[]{"xvfb", "xvnc"});

   // Suite building variables
   private Reports reports;

   // attributes from ant task def along with defaults
   private boolean verbose = false;
   private int port = 1024;
   private int socketTimeout = 60000; //milliseconds
   private int serverBufferSize = 262144; //bytes
   private boolean failOnTestFailure = false;
   private boolean isLocalTrusted = false;
   private String failureProperty = "flexunit.failed";
   private String player = "flash";
   private boolean headless = false;
   private String xcommand = "xvfb";
   private boolean snapshot = false;
   private File snapshotFile = null;
   private File swf = null;
   private File reportDir = null;

   public FlexUnitTask()
   {
      this.reports = new Reports();
   }
   
   /**
    * Sets local trusted, default is false
    * 
    * @param localTrusted
    */
   public void setLocalTrusted(final boolean localTrusted)
   {
      isLocalTrusted = localTrusted;
   }

   /**
    * Set the port to receive the test results on. Default is 1024
    * 
    * @param serverPort
    *           the port to set.
    */
   public void setPort(final int serverPort)
   {
      port = serverPort;
   }

   /**
    * Set the timeout for receiving the flexunit report.
    * 
    * @param timeout
    *           in milliseconds.
    */
   public void setTimeout(final int timeout)
   {
      socketTimeout = timeout;
   }
   
   /**
    * The buffer size the {@FlexUnitSocketServer} uses for its inbound data stream.
    */
   public void setBuffer(int size)
   {
      serverBufferSize = size;
   }

   /**
    * The SWF for the FlexUnit tests to run.
    * 
    * @param testSWF
    *           the SWF to set.
    */
   public void setSWF(final String testSWF)
   {
      swf = getProject().resolveFile(testSWF);
   }

   /**
    * Set the directory to output the test reports to.
    * 
    * @param toDir
    *           the directory to set.
    */
   public void setToDir(final String toDir)
   {
      reportDir = getProject().resolveFile(toDir);
   }

   /**
    * Should we fail the build if the flex tests fail?
    * 
    * @param fail
    */
   public void setHaltonfailure(final boolean fail)
   {
      failOnTestFailure = fail;
   }

   /**
    * Custom ant property noting test failure
    * 
    * @param failprop
    */
   public void setFailureproperty(final String failprop)
   {
      failureProperty = failprop;
   }

   /**
    * Toggle display of descriptive messages
    * 
    * @param failprop
    */
   public void setVerbose(final boolean verbose)
   {
      this.verbose = verbose;
      LoggingUtil.VERBOSE = verbose;
   }

   public void setPlayer(String player)
   {
      this.player = player;
   }

   public void setHeadless(boolean headless)
   {
      this.headless = headless;
   }

   public void setXcommand(String xcommand)
   {
      this.xcommand = xcommand;
   }

   public void setSnapshot(boolean snapshot)
   {
      this.snapshot = snapshot;
   }

   public void setSnapshotFile(String filename)
   {
      this.snapshotFile = getProject().resolveFile(filename);
   }

   /**
    * Called by Ant to execute the task.
    */
   public void execute() throws BuildException
   {
      validateInputs();
      generateDefaultValues();
      
      try
      {
         //setup callable thread
         Future<Object> future = setupSocketThread();
         
         //launch FlashPlayer and test SWF
         launchTestSuite();
         
         //block until thread is completely done with all tests
         future.get();
         
         //print summaries and check for failure
         analyzeReports();
      }
      catch (Exception e) {
         throw new BuildException(e);
      }
   }
   
   /**
    * Validates all attribute values of the task
    */
   private void validateInputs()
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
      
      if(headless)
      {
         if(!VALID_XCOMMANDS.contains(xcommand))
         {
            throw new BuildException("The provided 'xcommand' property value [" + xcommand + "] must be either of the following values: " + VALID_XCOMMANDS.toString() + ".");
         }
         
         if(snapshotFile != null && !snapshotFile.getParentFile().exists())
         {
            LoggingUtil.log("Provided path specified in 'snapshotFile' [" + snapshotFile.getPath() + "] cannot be created; the parent directory does not exist.");
         }
      }
   }

   /**
    * Generates default values for members' values which are not directly provided by the user.
    */
   private void generateDefaultValues()
   {
      LoggingUtil.log("Generating default values ...");
      
      //create report directory if needed
      if (reportDir == null || !reportDir.exists())
      {
         reportDir = getProject().resolveFile(DEFAULT_REPORT_PATH);
         LoggingUtil.log("Using default reporting dir [" + reportDir.getAbsolutePath() + "]");
      }

      //create directory just to be sure it exists, already existing dirs will not be overwritten
      reportDir.mkdir();
      
      //generate snapshot file handle
      if(snapshotFile == null || !snapshotFile.getParentFile().exists())
      {
         snapshotFile = getProject().resolveFile(reportDir.getAbsoluteFile() + "/" + DEFAULT_SNAPSHOT_FILENAME);
         LoggingUtil.log("Using default snapshot file path [" + snapshotFile.getAbsolutePath() + "]");
      }
      
      //show the resulting defaults and provided values
      logInputValues();
   }
   
   /**
    * Logs the values of all attributes on the task
    */
   private void logInputValues()
   {
      LoggingUtil.log("Using the following settings:");
      LoggingUtil.log("\thaltonfailure: [" + failOnTestFailure + "]");
      LoggingUtil.log("\theadless: [" + headless + "]");
      LoggingUtil.log("\tlocalTrusted: [" + isLocalTrusted + "]");
      LoggingUtil.log("\tplayer: [" + player + "]");
      LoggingUtil.log("\tport: [" + port + "]");
      LoggingUtil.log("\tsnapshot: [" + snapshot + "]");
      LoggingUtil.log("\tsnapshotFile: [" + (snapshotFile != null ? snapshotFile.getAbsolutePath() : null) + "]");
      LoggingUtil.log("\tswf: [" + swf + "]");
      LoggingUtil.log("\ttimeout: [" + socketTimeout + "ms]");
      LoggingUtil.log("\ttoDir: [" + reportDir.getAbsolutePath() + "]");
      LoggingUtil.log("\tverbose: [" + verbose + "]");
      LoggingUtil.log("\txcommand: [" + xcommand + "]");
   }
   
   /**
    * Create and launch the swf player in the appropriate domain
    */
   private void launchTestSuite()
   {
      final FlexUnitLauncher browser = new FlexUnitLauncher(getProject(), isLocalTrusted, headless, player, xcommand, snapshot, snapshotFile);

      try
      {
         browser.runTests(swf);
      }
      catch (Exception e)
      {
         throw new BuildException("Error launching the test runner.", e);
      }
   }

   /**
    * Create a server socket for receiving the test reports from FlexUnit. We
    * read and write the test reports inside of a Thread.
    */
   private Future<Object> setupSocketThread()
   {
      LoggingUtil.log("Setting up server process ...");
      
      //Create server for use by thread
      FlexUnitSocketServer server = new FlexUnitSocketServer(port, socketTimeout, serverBufferSize, !isLocalTrusted);
      
      //Get handle to specialized object to run in separate thread.
      Callable<Object> operation = new FlexUnitSocketThread(server, reportDir, reports);
      
      //Get handle to service to run object in thread.
      ExecutorService executor = Executors.newSingleThreadExecutor();
      
      //Run object in thread and return Future.
      return executor.submit(operation);
   }

   /**
    * End of test report run. Called at the end of a test run.  If verbose is set 
    * to true reads all suites in the suite list and prints out a descriptive message 
    * including the name of the suite, number of tests run and number of tests failed,
    * ignores any errors.  If any tests failed during the test run, the build is halted.
    */
   private void analyzeReports()
   {
      LoggingUtil.log("Analyzing reports ...");
      
      //print out all report summaries
      LoggingUtil.log("\n" + reports.getSummary(), true);

      if (reports.hasFailures())
      {
         getProject().setNewProperty(failureProperty, TRUE);
         
         if(failOnTestFailure)
         {
            throw new BuildException("FlexUnit tests failed during the test run.");
         }
      }
   }
}
