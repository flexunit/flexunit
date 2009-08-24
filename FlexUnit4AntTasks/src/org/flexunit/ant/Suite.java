package org.flexunit.ant;

public class Suite
{
   private String _name;
   private int _tests = 0;
   private int _failures = 0;
   private int _errors = 0;
   private int _skips = 0;
   private double _time = 0.0000;

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

   public void setTime(double time)
   {
      _time = time;
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

   public double getTime()
   {
      return _time;
   }

   @Override
   public String toString()
   {
      return _name;
   }
}
