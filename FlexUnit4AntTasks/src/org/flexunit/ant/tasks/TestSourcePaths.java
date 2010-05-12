package org.flexunit.ant.tasks;

import java.io.File;

import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.selectors.FilenameSelector;

public class TestSourcePaths extends CompilationFileSetCollection
{
   public TestSourcePaths()
   {
      super();
   }
   
   @Override
   public void add(FileSet fileset)
   {
      //restrict to as and mxml suffixed files
      FilenameSelector asSelector = new FilenameSelector();
      asSelector.setName("**/*.as");
      fileset.add(asSelector);
      
      FilenameSelector mxmlSelector = new FilenameSelector();
      mxmlSelector.setName("**/*.mxml");
      fileset.add(mxmlSelector);
      
      super.add(fileset);
   }
   
   public String getPathElements()
   {
      StringBuilder elements = new StringBuilder();
      
      for(FileSet fileset : filesets)
      {
         elements.append(fileset.getDir().getAbsolutePath());
         elements.append(',');
      }
      
      return elements.length() == 0 ? "" : elements.substring(0, elements.length() - 1);
   }
   
   public String getClasses()
   {
      StringBuilder elements = new StringBuilder();
      
      for(FileSet fileset : filesets)
      {
         DirectoryScanner ds = fileset.getDirectoryScanner();
         for(String file : ds.getIncludedFiles())
         {
            String pathWithOutSuffix = file.substring(0, file.lastIndexOf('.'));
            String canonicalClassName = pathWithOutSuffix.replace(File.separatorChar, '.');
            elements.append(canonicalClassName);
            elements.append(',');
         }
      }
      
      return elements.length() == 0 ? "" : elements.substring(0, elements.length() - 1);
   }
}
