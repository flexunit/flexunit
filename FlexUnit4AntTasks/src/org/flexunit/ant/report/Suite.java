package org.flexunit.ant.report;

public class Suite
{
   private String _name;
   private int _tests = 0;
   private int _failures = 0;
   private int _errors = 0;
   private int _skips = 0;
   private long _time = 0;

   public Suite(String name)
   {
      super();
      _name = name;
   }

   public void addTest()
   {
      _tests++;
   }

   public void addFailure()
   {
      _failures++;
   }

   public void addError()
   {
      _errors++;
   }
   
   public void addSkip()
   {
      _skips++;
   }

   public String getName()
   {
      return _name;
   }

   public int getTests()
   {
      return _tests;
   }

   public int getFailures()
   {
      return _failures;
   }

   public int getErrors()
   {
      return _errors;
   }
   
   public int getSkips()
   {
      return _skips;
   }

   public long getTime()
   {
      return _time;
   }
   
   public void addTime(long time)
   {
      _time += time;
   }

   @Override
   public String toString()
   {
      return _name;
   }
}
