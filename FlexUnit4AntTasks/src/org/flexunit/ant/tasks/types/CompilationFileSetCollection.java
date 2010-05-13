package org.flexunit.ant.tasks.types;

import java.util.ArrayList;
import java.util.List;

import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.types.FileSet;

public class CompilationFileSetCollection
{
   protected List<FileSet> filesets;
   
   public CompilationFileSetCollection()
   {
      filesets = new ArrayList<FileSet>();
   }
   
   public void add(FileSet fileset)
   {
      filesets.add(fileset);
   }
   
   public boolean provided()
   {
      return filesets.size() != 0;
   }
   
   public boolean isEmpty()
   {
      if(filesets.isEmpty())
      {
         return true;
      }
      
      int includeCount = 0;
      
      for(FileSet fileset : filesets)
      {
         if(fileset.getDir().exists())
         {
            DirectoryScanner scanner = fileset.getDirectoryScanner();
            includeCount += scanner.getIncludedFilesCount();
         }
      }
      
      return includeCount == 0;
   }
   
   public boolean exists()
   {
      for(FileSet fileset : filesets)
      {
         if(!fileset.getDir().exists())
         {
            return false;
         }
      }
      
      return true;
   }
}
