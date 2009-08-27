package org.flexunit.ant.tasks.integration;

import junit.framework.TestCase;

import org.apache.tools.ant.Project;
import org.flexunit.ant.tasks.FlexUnitTask;

public class FlexUnitTaskHarness extends TestCase
{
   private FlexUnitTask fixture;
   
   protected void setUp()
   {
      fixture = new FlexUnitTask();
      fixture.setProject(new Project());
      fixture.setHaltonfailure(true);
      fixture.setLocalTrusted(true);
      fixture.setTimeout(5000);
      fixture.setSWF("test/TestRunner.swf");
      fixture.setToDir(".");
   }

   public void testExecute()
   {
      fixture.execute();
   }

}
