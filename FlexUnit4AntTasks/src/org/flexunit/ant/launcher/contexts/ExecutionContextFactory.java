package org.flexunit.ant.launcher.contexts;

import org.flexunit.ant.launcher.OperatingSystem;

public class ExecutionContextFactory
{
   /**
    * Used to generate new instances of an execution context based on the OS and whether the build should run
    * headlessly.
    * 
    * @param os Current OS.
    * @param headless Should the build run headlessly.
    * @param display The vnc display number to use if headless
    * 
    * @return
    */
   public static ExecutionContext createContext(OperatingSystem os, boolean headless, int display)
   {
      boolean trulyHeadless = headless && (os == OperatingSystem.LINUX);
      ExecutionContext context = null;
      
      if(trulyHeadless)
      {
         context = new HeadlessContext(display); 
      }
      else
      {
         context = new DefaultContext();
      }
      
      return context;
   }
}
