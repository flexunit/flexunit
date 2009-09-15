package org.flexunit.ant.tasks;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import org.flexunit.ant.FlexUnitLauncher;
import org.flexunit.ant.FlexUnitSocketThread;
import org.flexunit.ant.Report;

public class FlexUnitTask extends Task
{
   private static final String TRUE = "true";

   // Suite building variables
   private Map<String, Report> reports;

   // attributes from ant task def
   private boolean verbose;
   private int port;
   private int socketTimeout; 
   private boolean failOnTestFailure;
   private boolean isLocalTrusted;
   private String failureProperty;
   private String swf;
   private File reportDir;
   
   @SuppressWarnings("unused")
   private boolean modules = false;

   public FlexUnitTask()
   {
      this.reports = new HashMap<String, Report>();
      
      this.verbose = true;
      this.port = 1024;
      this.socketTimeout = 60000;  // milliseconds
      this.failOnTestFailure = true;
      this.isLocalTrusted = false;
      this.failureProperty = "flexunit.failed";
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
    * The SWF for the FlexUnit tests to run.
    * 
    * @param testSWF
    *           the SWF to set.
    */
   public void setSWF(final String testSWF)
   {
      swf = testSWF;
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
   }

   public void setModules(final boolean mod)
   {
      modules = mod;
   }

   /**
    * Called by Ant to execute the task.
    */
   public void execute() throws BuildException
   {
      // Check a SWF was specified.
      if (swf == null || swf.length() == 0 || !getProject().resolveFile(swf).exists())
      {
         throw new BuildException("The 'swf' property value [" + swf + "] could not be found.");
      }
      
      createReportDirectory();

      try
      {
         //setup callable thread
         Future<Object> future = setupClientConnection();
         
         //launch FlashPlayer and test SWF
         launchTestSuite();
         
         //block until thread is completely done with all tests
         future.get();
         
         //print summaries and check for failure
         finalizeReports();
      }
      catch (Exception e) {
         throw new BuildException(e);
      }
   }

   /**
    * Creates the report directory. If none specified, creates in the root
    * directory.
    */
   private void createReportDirectory()
   {
      if (reportDir == null)
      {
         reportDir = getProject().resolveFile(".");
      }

      reportDir.mkdir();
   }
   
   /**
    * Create and launch the swf player in the appropriate domain
    */
   private void launchTestSuite()
   {
      final FlexUnitLauncher browser = new FlexUnitLauncher();

      try
      {
         browser.runTests(swf, isLocalTrusted);
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
   private Future<Object> setupClientConnection()
   {
      // Start a thread to accept a client connection.
      Callable<Object> operation = new FlexUnitSocketThread(port, socketTimeout, verbose, reportDir, reports, !isLocalTrusted);
      ExecutorService executor = Executors.newSingleThreadExecutor();
      return executor.submit(operation);
   }

   /**
    * End of test report run. Called at the end of a test run.  If verbose is set 
    * to true reads all suites in the suite list and prints out a descriptive message 
    * including the name of the suite, number of tests run and number of tests failed,
    * ignores any errors.  If any tests failed during the test run, the build is halted.
    */
   private void finalizeReports()
   {
      for (Report report : reports.values())
      {
         if(verbose)
         {
            log(report.getSummary());
         }
         
         // If the report shows failures
         if (report.hasFailures())
         {
            // This run is now a failed run
            getProject().setNewProperty(failureProperty, TRUE);
         }
      }
      
      String property = getProject().getProperty(failureProperty);
      if(failOnTestFailure && property != null && property.equals(TRUE))
      {
         throw new BuildException("FlexUnit tests failed during the test run.");
      }
   }

   /**
    * Shorthand console message
    * 
    * @param message
    *           String to print
    */
   public void log(final String message)
   {
      System.out.println(message);
   }
}
