package org.flexunit.ant.tasks.configuration;

import java.io.File;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.types.FileSet;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.tasks.types.LibraryPaths;
import org.flexunit.ant.tasks.types.LoadConfig;
import org.flexunit.ant.tasks.types.SourcePaths;

public class CompilationConfiguration implements StepConfiguration
{
   private SourcePaths sources;
   private SourcePaths testSources;
   private LibraryPaths libraries;
   private File flexHome;
   private String player;
   private File workingDir;

   public CompilationConfiguration()
   {
      sources = new SourcePaths();
      testSources = new SourcePaths();
      libraries = new LibraryPaths();
      debug = false;
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
   
   public String getPlayer()
   {
      return player;
   }
   
   public void setPlayer(String player)
   {
      this.player = player;
   }
   
   public void addSource(FileSet fileset)
   {
      this.sources.add(fileset);
   }
   
   public SourcePaths getSources()
   {
      return sources;
   }
   
   public void addTestSource(FileSet fileset)
   {
      this.testSources.add(fileset);
   }
   
   public SourcePaths getTestSources()
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
      
      if(libraries.exists() && libraries.isEmpty() && loadConfig == null)
      {
         throw new BuildException("'library' elements not specified or 'load-config' element not specified. Also possible no SWC files could be found for the provided 'library' elements.");
      }
   }
   
   public void log()
   {
      LoggingUtil.log("Using the following settings for compilation:");
      LoggingUtil.log("\tFLEX_HOME: [" + flexHome.getAbsolutePath() + "]");
      LoggingUtil.log("\tplayer: [" + player + "]");
      LoggingUtil.log("\tsourceDirectories: [" + sources.getPathElements(",") + "]");
      LoggingUtil.log("\ttestSourceDirectories: [" + testSources.getPathElements(",") + "]");
      LoggingUtil.log("\tlibraries: [" + libraries.getPathElements(",") + "]");
   }
   
   private boolean debug;
   public boolean getDebug()
   {
       return debug;
   }

   public void setDebug(boolean value)
   {
       debug = value;
   }
   
   private LoadConfig loadConfig;
   public void setLoadConfig(LoadConfig loadconfig)
   {
       loadConfig = loadconfig;
   }

   public LoadConfig getLoadConfig()
   {
       return loadConfig;
   }
   
}
