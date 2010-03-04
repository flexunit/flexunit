package org.flexunit.ant.report;

import java.io.File;
import java.io.FileOutputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.util.DateUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.flexunit.ant.LoggingUtil;

public class Report
{
   private static final String FAILURE = "failure";
   private static final String ERROR = "error";
   private static final String IGNORE = "ignore";

   private static final String TEST_SUITE = "testsuite";
   private static final String NAME_ATTRIBUTE_LABEL = "name";
   private static final String FAILURE_ATTRIBUTE_LABEL = "failures";
   private static final String ERROR_ATTRIBUTE_LABEL = "errors";
   private static final String IGNORE_ATTRIBUTE_LABEL = "skipped";
   private static final String TIME_ATTRIBUTE_LABEL = "time";
   private static final String TESTS_ATTRIBUTE_LABEL = "tests";
   private static final String HOSTNAME_ATTRIBUTE_LABEL = "hostname";
   private static final String TIMESTAMP_ATTRIBUTE_LABEL = "timestamp";

   private static final String FILENAME_PREFIX = "TEST-";
   private static final String FILENAME_EXTENSION = ".xml";

   // Exception messages
   private static final String FAILED_TEST = "FlexUnit test {0} in suite {1} failed.";
   private static final String ERRORED_TEST = "FlexUnit test {0} in suite {1} had errors.";
   private static final String IGNORED_TEST = "FlexUnit test {0} in suite {1} was ignored.";
   private static final String TEST_INFO = "Suite: {0}\nTests run: {1}, Failures: {2}, Errors: {3}, Skipped: {4}, Time elapsed: {5} sec";
   private static final String ERROR_SAVING_REPORT = "Error saving report.";

   // XML attribute labels
   private static final String CLASSNAME_ATTRIBUTE = "classname";
   private static final String NAME_ATTRIBUTE = "name";
   private static final String STATUS_ATTRIBUTE = "status";

   protected Suite suite;
   private Document document;
   private List<String> recordedRuns;

   public Report(Suite suite)
   {
      this.recordedRuns = new ArrayList<String>();
      this.suite = suite;

      // Create a new XML document
      document = DocumentHelper.createDocument();

      // Add the test suite attributes to the document
      document
            .addElement(TEST_SUITE)
            .addAttribute(NAME_ATTRIBUTE_LABEL, suite.getName())
            .addAttribute(TESTS_ATTRIBUTE_LABEL,
                  String.valueOf(suite.getTests()))
            .addAttribute(FAILURE_ATTRIBUTE_LABEL,
                  String.valueOf(suite.getFailures()))
            .addAttribute(ERROR_ATTRIBUTE_LABEL,
                  String.valueOf(suite.getErrors()))
            .addAttribute(IGNORE_ATTRIBUTE_LABEL,
                  String.valueOf(suite.getSkips()))
            .addAttribute(TIME_ATTRIBUTE_LABEL, String.valueOf(suite.getTime()));
   }

   /**
    * Adds the test to the suite report given an XML test document
    */
   public void addTest(Document test)
   {
      Element root = test.getRootElement();
      
      // Add to the number of tests in this suite if not seen and not null
      String testMethod = root.attributeValue(NAME_ATTRIBUTE);
      if(!recordedRuns.contains(testMethod) && !testMethod.equals("null"))
      {
         recordedRuns.add(testMethod);
         suite.addTest();
      }

      //If the test method name is null, then make it the classname
      if(root.attributeValue(NAME_ATTRIBUTE).equals("null"))
      {
         root.attribute(NAME_ATTRIBUTE).setText(root.attributeValue(CLASSNAME_ATTRIBUTE));
      }
      
      // Add the test to the report document
      document.getRootElement().add(root);

      // Check for special status adjustments to make to suite
      checkForStatus(test);
      
      //remove status attribute since it's only used by the report
      root.remove(root.attribute(STATUS_ATTRIBUTE));
   }

   /**
    * Updates counts for failed, error, and ignore on suite as well as logs what
    * failed if told to use logging.
    * 
    * @param test
    *           Test XML document
    */
   private void checkForStatus(Document test)
   {
      // Get the root element and pull the test name and status
      final Element root = test.getRootElement();
      final String name = root.attributeValue(NAME_ATTRIBUTE);
      final String status = root.attributeValue(STATUS_ATTRIBUTE);

      String format = null;
      if (status.equals(FAILURE))
      {
         format = FAILED_TEST;
         suite.addFailure();
      } 
      else if (status.equals(ERROR))
      {
         format = ERRORED_TEST;
         suite.addError();
      } 
      else if (status.equals(IGNORE))
      {
         format = IGNORED_TEST;
         suite.addSkip();
      }

      // Creates the fail message for use with verbose
      if (format != null)
      {
         final String message = MessageFormat.format(format, new Object[]
         { name, suite });
         LoggingUtil.log(message);
      }
   }

   /**
    * Determines if any failures (errors or failures) have occurred in this
    * report.
    */
   public boolean hasFailures()
   {
      return (suite.getErrors() > 0 || suite.getFailures() > 0);
   }

   /**
    * Write the report XML document out to file
    * 
    * @param reportDir
    *           Directory to hold report file.
    */
   public void save(File reportDir) throws BuildException
   {
      try
      {
         // Open the file matching the parameter suite
         final File file = new File(reportDir, FILENAME_PREFIX + suite + FILENAME_EXTENSION);

         // Retrieve the root element and adjust the failures and test attributes
         Element root = document.getRootElement();
         root.addAttribute(FAILURE_ATTRIBUTE_LABEL, String.valueOf(suite.getFailures()));
         root.addAttribute(ERROR_ATTRIBUTE_LABEL, String.valueOf(suite.getErrors()));
         root.addAttribute(TESTS_ATTRIBUTE_LABEL, String.valueOf(suite.getTests()));
         root.addAttribute(IGNORE_ATTRIBUTE_LABEL, String.valueOf(suite.getSkips()));
         root.addAttribute(HOSTNAME_ATTRIBUTE_LABEL, getHostname());
         
         final String timestamp = DateUtils.format(new Date(), DateUtils.ISO8601_DATETIME_PATTERN);
         root.addAttribute(TIMESTAMP_ATTRIBUTE_LABEL, timestamp);

         // Write the updated suite
         final OutputFormat format = OutputFormat.createPrettyPrint();
         final XMLWriter writer = new XMLWriter(new FileOutputStream(file), format);
         writer.write(document);
         writer.close();
      }
      catch (Exception e)
      {
         throw new BuildException(ERROR_SAVING_REPORT, e);
      }
   }

   private String getHostname()
   {
      try
      {
         return InetAddress.getLocalHost().getHostName();
      } catch (UnknownHostException e)
      {
         return "localhost";
      }
   }

   public String getSummary()
   {
      String summary = "";

      try
      {
         summary = MessageFormat.format(TEST_INFO, new Object[]
         { new String(suite.getName()), new Integer(suite.getTests()),
               new Integer(suite.getFailures()),
               new Integer(suite.getErrors()), new Integer(suite.getSkips()),
               new Double(suite.getTime()) });
      } catch (Exception e)
      {
         // ignore
      }

      return summary;
   }
}
