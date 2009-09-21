package org.flexunit.ant;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.Callable;

import org.apache.tools.ant.BuildException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

public class FlexUnitSocketThread implements Callable<Object>
{
   // Messages from CIListener
   private static final String END_OF_SUCCESS = "status='success'/>";
   private static final String END_OF_FAILURE = "</testcase>";
   private static final String END_OF_IGNORE = "<skipped /></testcase>";

   // XML attribute labels
   private static final String SUITE_ATTRIBUTE = "@classname";

   private boolean useLogging;
   private File reportDir;

   private FlexUnitSocketServer server;
   private Map<String, Report> reports;

   public FlexUnitSocketThread(FlexUnitSocketServer server, boolean useLogging, File reportDir, Map<String, Report> reports)
   {
      this.server = server;
      this.useLogging = useLogging;
      this.reportDir = reportDir;
      this.reports = reports;
   }

   public Object call() throws Exception
   {
      try
      {
         server.start();
         parseInboundMessages();
      }
      catch (BuildException buildException)
      {
         try
         {
            server.stop();
         }
         catch (IOException e)
         {
            // could not stop test run
            throw buildException;
         }
      }
      catch (IOException e)
      {
         throw new BuildException("error receiving report from flexunit", e);
      }
      finally
      {
         try
         {
            server.stop();
         }
         catch (IOException e)
         {
            throw new BuildException("could not close client/server socket");
         }
      }

      //All done, let the process that spawned me know I've returned.
      return null;
   }

   /**
    * Used to iterate and interpret byte sent over the socket.
    */
   private void parseInboundMessages() throws IOException
   {
      String request = null;

      while ((request = server.readNextTokenFromSocket()) != null)
      {
         // If the string is a failure, process the report
         if (request.endsWith(END_OF_FAILURE) || request.endsWith(END_OF_SUCCESS) || request.endsWith(END_OF_IGNORE))
         {
            processTestReport(request);
         }
         else
         {
            throw new BuildException("command [" + request + "] not understood");
         }
      }
   }

   /**
    * Process the test report.
    * 
    * @param report
    *           String that represents a complete test
    */
   private void processTestReport(String xml)
   {
      // Convert the string report into an XML document
      Document test = parseReport(xml);

      // Find the name of the suite
      String suiteName = test.getRootElement().valueOf(SUITE_ATTRIBUTE);

      // Convert all instances of :: for file support
      suiteName = suiteName.replaceAll("::", ".");

      if (!reports.containsKey(suiteName))
      {
         reports.put(suiteName, new Report(useLogging, new Suite(suiteName)));
      }

      // Fetch report, add test, and write to disk
      Report report = reports.get(suiteName);
      report.addTest(test);

      report.save(reportDir);
   }

   /**
    * Parse the parameter String and returns it as a document
    * 
    * @param report
    *           String
    * @return Document
    */
   private Document parseReport(String report)
   {
      try
      {
         final Document document = DocumentHelper.parseText(report);

         return document;
      }
      catch (DocumentException e)
      {
         log(report);
         throw new BuildException("Error parsing report.", e);
      }
   }

   /**
    * Shorthand console message
    * 
    * @param message
    *           String to print
    */
   private void log(final String message)
   {
      System.out.println(message);
   }
}
