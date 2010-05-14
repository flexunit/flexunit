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

      File runnerFile = generateTestRunnerFromTemplate(configuration.getWorkingDir());
      File finalFile = new File(configuration.getWorkingDir().getAbsolutePath() + File.separatorChar + SWF_FILENAME);
      
      Java compilationTask = createJavaTask(runnerFile, finalFile);
      LoggingUtil.log("Compiling test classes: [" + configuration.getTestSources().getCanonicalClasses(", ") + "]", true);
      LoggingUtil.log(compilationTask.getCommandLine().describeCommand());
      
      if(compilationTask.executeJava() != 0)
      {
         throw new BuildException("Compilation failed:\n" + project.getProperty("MXMLC_ERROR"));
      }
      
      return finalFile;
   }
   
   private File generateTestRunnerFromTemplate(File workingDir) throws BuildException
   {
      try
      {
         File runner = new File(workingDir.getAbsolutePath() + File.separatorChar + TESTRUNNER_FILE);
         
         //Template location in JAR
         URLResource template = new URLResource(getClass().getResource("/" + TESTRUNNER_TEMPLATE));
         
         //Create tokens to filter
         FilterSet filters = new FilterSet();
         filters.addFilter("CLASS_REFS", configuration.getTestSources().getClasses());
         filters.addFilter("IMPORT_REFS", configuration.getTestSources().getImports());
         
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
         
         return runner;
      }
      catch (Exception e)
      {
         throw new BuildException("Could not create test runner from template.");
      }
   }
   
   private Java createJavaTask(File runnerFile, File finalFile)
   {
      String frameworksPath = configuration.getFlexHome().getAbsolutePath() + File.separatorChar + FRAMEWORKS_RELATIVE_PATH;
      String mxmlcPath = configuration.getFlexHome().getAbsolutePath() + File.separatorChar + MXMLC_RELATIVE_PATH;
      
      Java task = new Java();
      task.setFork(true);
      task.setFailonerror(true);
      task.setJar(new File(mxmlcPath));
      task.setProject(project);
      task.setDir(project.getBaseDir());
      task.setMaxmemory("256M"); //MXMLC needs to eat
      task.setErrorProperty("MXMLC_ERROR");
      
      Argument flexLibArgument = task.createArg();
      flexLibArgument.setLine("+flexlib " + frameworksPath);
      
      Argument outputFile = task.createArg();
      outputFile.setLine("-output " + finalFile.getAbsolutePath());
      
      Argument sourcePath = task.createArg();
      sourcePath.setLine("-source-path " + configuration.getSources().getPathElements(" ") + " " + configuration.getTestSources().getPathElements(" "));
      
      Argument libraryPath = task.createArg();
      libraryPath.setLine("-library-path+=" + configuration.getLibraries().getPathElements(" -library-path+="));
      
      Argument headlessServer = task.createArg();
      headlessServer.setLine("-headless-server=true");
      
      Argument mainFile = task.createArg();
      mainFile.setValue(runnerFile.getAbsolutePath());
      
      return task;
   }
}
