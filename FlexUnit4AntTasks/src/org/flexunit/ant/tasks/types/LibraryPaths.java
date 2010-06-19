package org.flexunit.ant.tasks.types;

import java.io.File;

import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.types.FileSet;

public class LibraryPaths extends CompilationFileSetCollection
{
   public LibraryPaths()
   {
      super();
   }
   
   @Override
   public void add(FileSet fileset)
   {
      super.add(fileset);
   }
   
   public String getPathElements(String delimiter)
   {
      StringBuilder elements = new StringBuilder();
      
      for(FileSet fileset : filesets)
      {
         DirectoryScanner ds = fileset.getDirectoryScanner();
         String[] files = ds.getIncludedFiles();
         for(int i=0; i<files.length; i++)
         {
            if(files[i].endsWith(".swc"))
            {
               elements.append("\"" + fileset.getDir().getAbsolutePath() + File.separator + files[i] + "\"");
               elements.append(delimiter);
            }
         }
      }
      
      return elements.length() <= delimiter.length() ? "" : elements.substring(0, elements.length() - delimiter.length());
   }
}
