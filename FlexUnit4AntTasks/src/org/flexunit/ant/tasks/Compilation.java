package org.flexunit.ant.tasks;

import java.io.File;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Java;
import org.apache.tools.ant.types.FilterSet;
import org.apache.tools.ant.types.FilterSetCollection;
import org.apache.tools.ant.types.Commandline.Argument;
import org.apache.tools.ant.types.resources.FileResource;
import org.apache.tools.ant.types.resources.URLResource;
import org.apache.tools.ant.util.ResourceUtils;
import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.tasks.configuration.CompilationConfiguration;

public class Compilation
{
   private final String TESTRUNNER_TEMPLATE = "TestRunner.template";
   private final String TESTRUNNER_FILE = "TestRunner.mxml";
   private final String MXMLC_RELATIVE_PATH = "lib/mxmlc.jar";
   private final String FRAMEWORKS_RELATIVE_PATH = "frameworks";
   private final String SWF_FILENAME = "TestRunner.swf";
   private final String TESTRUNNER_SRC_RELATIVE_PATH = "test-src";
   
   private CompilationConfiguration configuration;
   private Project project;
   
   public Compilation(Project project, CompilationConfiguration configuration)
   {
      this.project = project;
      this.configuration = configuration;
   }
   
   public File compile() throws BuildException
   {
      configuration.log();

      File srcDirectory = new File(configuration.getWorkingDir().getAbsolutePath() + File.pathSeparatorChar + TESTRUNNER_SRC_RELATIVE_PATH);
      File runnerFile = generateTestRunnerFromTemplate(srcDirectory);
      File finalFile = new File(configuration.getWorkingDir().getAbsolutePath() + File.pathSeparatorChar + SWF_FILENAME);
      
      Java compilationTask = createJavaTask(runnerFile, finalFile);
      LoggingUtil.log(compilationTask.getDescription());
      compilationTask.execute();
      
      return finalFile;
   }
   
   private File generateTestRunnerFromTemplate(File srcDirectory) throws BuildException
   {
      File runner = new File(srcDirectory.getAbsolutePath() + File.pathSeparatorChar + TESTRUNNER_FILE);
      
      try
      {
         //Template location in JAR
         URLResource template = new URLResource(getClass().getResource("/" + TESTRUNNER_TEMPLATE));
         
         //Create tokens to filter
         FilterSet filters = new FilterSet();
         filters.addFilter("CANONCIAL_CLASS_REFS", configuration.getTestSources().getClasses());
         
         //Copy descriptor template to SWF folder performing token replacement
         ResourceUtils.copyResource(
            template,
            new FileResource(runner),
            new FilterSetCollection(filters),
            null,
            true,
            false,
            null,
            null,
            project
         );
         
         LoggingUtil.log("Created test runner at [" + runner.getAbsolutePath() + "]");
      }
      catch (Exception e)
      {
         throw new BuildException("Could not create test runner from template.");
      }
      
      return runner;
   }
   
   private Java createJavaTask(File runnerFile, File finalFile)
   {
      String frameworksPath = configuration.getFlexHome().getAbsolutePath() + File.pathSeparatorChar + FRAMEWORKS_RELATIVE_PATH;
      String mxmlcPath = configuration.getFlexHome().getAbsolutePath() + File.pathSeparatorChar + MXMLC_RELATIVE_PATH;
      
      Java task = new Java();
      task.setFork(true);
      task.setFailonerror(true);
      task.setJar(new File(mxmlcPath));
      task.setDir(configuration.getWorkingDir());
      
      Argument jvmHeapSize = task.createJvmarg();
      jvmHeapSize.setValue("-Xmx256M");
      
      Argument flexLibArgument = task.createArg();
      flexLibArgument.setLine("+flexlib " + frameworksPath);
      
      Argument outputFile = task.createArg();
      outputFile.setLine("-output " + finalFile.getAbsolutePath());
      
      Argument sourcePath = task.createArg();
      sourcePath.setLine("-source-path+=" + configuration.getTestSources().getPathElements());
      
      Argument libraryPath = task.createArg();
      libraryPath.setLine("-library-path+=" + configuration.getLibraries().getPathElements());
      
      Argument headlessServer = task.createArg();
      headlessServer.setLine("-headless-server=true");
      
      Argument mainFile = task.createArg();
      mainFile.setValue(runnerFile.getAbsolutePath());
      
      return task;
   }
}
