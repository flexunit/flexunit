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
      fixture.setLocalTrusted(false);
      fixture.setPort(1024);
      fixture.setTimeout(10000);
      fixture.setBuffer(555555);
      fixture.setSWF("test/TestRunner.swf");
      fixture.setToDir("test");
      fixture.setVerbose(true);
      fixture.setFailureproperty("failedtests");
      fixture.setPlayer("flash");
      fixture.setHeadless(false);
      fixture.setXcommand("xvfb");
      fixture.setSnapshot(true);
      fixture.setSnapshotFile("screen.jpg");
   }

   public void testExecute()
   {
      fixture.execute();
   }

}
