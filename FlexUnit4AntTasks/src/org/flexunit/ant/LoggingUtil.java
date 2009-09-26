package org.flexunit.ant;

public class LoggingUtil
{
   public static boolean VERBOSE = false;
   
   public static void log(String message)
   {
      log(message, false);
   }
   
   public static void log(String message, boolean force)
   {
      if(VERBOSE || force)
      {
         System.out.println(message);
      }
   }
}
