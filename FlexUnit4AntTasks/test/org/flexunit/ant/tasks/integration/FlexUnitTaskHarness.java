package org.flexunit.ant.tasks.integration;

import java.io.File;

import junit.framework.TestCase;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.types.FileSet;
import org.flexunit.ant.tasks.FlexUnitTask;

public class FlexUnitTaskHarness extends TestCase
{
   private FlexUnitTask fixture;
   
   protected void setUp()
   {
      fixture = new FlexUnitTask();
      Project project = new Project();
      project.setProperty("FLEX_HOME", System.getenv("FLEX_HOME"));
      fixture.setProject(project);
      
      //call all setters for task attributes
      fixture.setHaltonfailure(true);
      fixture.setLocalTrusted(false);
      fixture.setPort(1024);
      fixture.setTimeout(10000);
      fixture.setBuffer(555555);
      //fixture.setSWF("test/TestRunner.swf");
      fixture.setToDir("test/sandbox");
      fixture.setVerbose(true);
      fixture.setFailureproperty("failedtests");
      fixture.setPlayer("air");
      fixture.setCommand("/Users/dblegros/api/flexsdk/3.5.0/bin/adl");
      fixture.setHeadless(false);
      fixture.setWorkingDir("test/sandbox");
      
      //Call elements next
      FileSet testSourceFileSet = new FileSet();
      testSourceFileSet.setDir(new File("test/sandbox/src"));
      testSourceFileSet.setIncludes("**/*class.as");
      fixture.addTestSource(testSourceFileSet);
      
      FileSet libraryFileSet = new FileSet();
      libraryFileSet.setDir(new File("test/sandbox/libs"));
      fixture.addLibrary(libraryFileSet);
   }

   public void testExecute()
   {
      fixture.execute();
   }

}
