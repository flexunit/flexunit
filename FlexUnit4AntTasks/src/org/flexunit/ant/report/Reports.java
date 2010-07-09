package org.flexunit.ant.report;

import java.text.MessageFormat;
import java.util.HashMap;

/**
 * Aggregate class representing a collection of Reports stored in a Map<String, Report>
 */
public class Reports extends HashMap<String, Report>
{
   private static final long serialVersionUID = 2078272511659655555L;
   private static final String TEST_INFO = "Tests run: {0}, Failures: {1}, Errors: {2}, Skipped: {3}, Time elapsed: {4} sec";

   public Reports()
   {
      super();
   }
   
   /**
    * String version of all reports.
    */
   public String getSummary()
   {
      String summary = "";
      int runs = 0;
      int errors = 0;
      int failures = 0;
      int skips = 0;
      long time = 0;
      
      for(Report report : this.values())
      {
         runs += report.suite.getTests();
         errors += report.suite.getErrors();
         failures += report.suite.getFailures();
         skips += report.suite.getSkips();
         time += report.suite.getTime();
         
         summary += report.getSummary() + "\n";
      }
      
      summary += "\nResults :\n\n";
      
      try
      {
         summary += MessageFormat.format(TEST_INFO, new Object[] { 
               new Integer(runs), 
               new Integer(failures), 
               new Integer(errors),
               new Integer(skips),
               formatTime(time)
            });
      }
      catch(Exception e)
      {
         summary += "Error occurred while generating summary ...";
      }
      
      summary += "\n";
      
      return summary;
   }
   
   private String formatTime(long time)
   {
      return String.format("%.3f", new Double(time / 1000.0000));
   }
   
   /**
    * Determines if any reports have failures
    */
   public boolean hasFailures()
   {
      for(Report report : this.values())
      {
         if(report.hasFailures())
         {
            return true;
         }
      }
      
      return false;
   }
}
