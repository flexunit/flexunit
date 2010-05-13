package org.flexunit.ant.tasks.configuration;

import java.io.File;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.types.FileSet;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.tasks.types.LibraryPaths;
import org.flexunit.ant.tasks.types.TestSourcePaths;

public class CompilationConfiguration implements StepConfiguration
{
   private TestSourcePaths testSources;
   private LibraryPaths libraries;
   private File flexHome = null;
   private File workingDir = null;

   public CompilationConfiguration()
   {
      testSources = new TestSourcePaths();
      libraries = new LibraryPaths();
   }
   
   public File getFlexHome()
   {
      return flexHome;
   }
   
   public void setFlexHome(File flexHome)
   {
      this.flexHome = flexHome;
   }

   public void addLibrary(FileSet fileset)
   {
      this.libraries.add(fileset);
   }
   
   public LibraryPaths getLibraries()
   {
      return libraries;
   }
   
   public void addTestSource(FileSet fileset)
   {
      this.testSources.add(fileset);
   }
   
   public TestSourcePaths getTestSources()
   {
      return testSources;
   }
   
   public void setWorkingDir(File workingDir)
   {
      this.workingDir = workingDir;
   }

   public File getWorkingDir()
   {
      return workingDir;
   }

   public void validate() throws BuildException
   {
      if(!testSources.exists())
      {
         throw new BuildException("One of the directories specified as a 'testSource' element does not exist.");
      }
      
      if(testSources.exists() && testSources.isEmpty())
      {
         throw new BuildException("No test files could be found for the provided 'testSource' elements.");
      }
      
      if(!libraries.exists())
      {
         throw new BuildException("One of the directories specified as a 'library' element does not exist.");
      }
      
      if(libraries.exists() && libraries.isEmpty())
      {
         throw new BuildException("No SWC files could be found for the provided 'library' elements.");
      }
   }
   
   public void log()
   {
      LoggingUtil.log("Using the following settings for compilation:");
      LoggingUtil.log("\tFLEX_HOME: [" + flexHome.getAbsolutePath() + "]");
      LoggingUtil.log("\ttestSourceDirectories: [" + testSources.getPathElements(",") + "]");
      LoggingUtil.log("\tlibraries: [" + libraries.getPathElements(",") + "]");
   }
}
