package org.flexunit.ant.tasks;

import java.io.File;

import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.selectors.FilenameSelector;

public class LibraryPaths extends CompilationFileSetCollection
{
   public LibraryPaths()
   {
      super();
   }
   
   @Override
   public void add(FileSet fileset)
   {
      //restrict a library to a SWC file
      FilenameSelector selector = new FilenameSelector();
      selector.setName("**/*.swc");
      fileset.add(selector);
      
      super.add(fileset);
   }
   
   public String getPathElements()
   {
      StringBuilder elements = new StringBuilder();
      
      for(FileSet fileset : filesets)
      {
         DirectoryScanner ds = fileset.getDirectoryScanner();
         String[] files = ds.getIncludedFiles();
         for(int i=0; i<files.length; i++)
         {
            elements.append(fileset.getDir().getAbsolutePath() + File.separator + files[i]);
            elements.append(',');
         }
      }
      
      return elements.length() == 0 ? "" : elements.substring(0, elements.length() - 1);
   }
}
