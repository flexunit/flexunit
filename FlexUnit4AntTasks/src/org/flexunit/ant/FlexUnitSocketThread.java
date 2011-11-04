package org.flexunit.ant;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.Callable;

import org.apache.tools.ant.BuildException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.flexunit.ant.report.Report;
import org.flexunit.ant.report.Suite;

/**
 * Managing class for the FlexUnitSocketServer and report aggregation.
 */
public class FlexUnitSocketThread implements Callable<Object>
{
   // XML attribute labels
   private static final String SUITE_ATTRIBUTE = "classname";

   private File reportDir;

   private FlexUnitSocketServer server;
   private Map<String, Report> reports;

   public FlexUnitSocketThread(FlexUnitSocketServer server, File reportDir, Map<String, Report> reports)
   {
      this.server = server;
      this.reportDir = reportDir;
      this.reports = reports;
   }

   /**
    * When excuted, the thread will start the socket server and wait for inbound data and delegate reporting
    */
   //TODO: Clean up exception handling
   public Object call() throws Exception
   {
      try
      {
         server.start();
         parseInboundMessages();
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
         // TODO: handling of malformed XML         processTestReport(request);
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
      String suiteName = test.getRootElement().attributeValue(SUITE_ATTRIBUTE);

      // Convert all instances of :: for file support
      suiteName = suiteName.replaceAll("::", ".");

      if (!reports.containsKey(suiteName))
      {
         reports.put(suiteName, new Report(new Suite(suiteName)));
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
         LoggingUtil.log(report);
         throw new BuildException("Error parsing report.", e);
      }
   }
}