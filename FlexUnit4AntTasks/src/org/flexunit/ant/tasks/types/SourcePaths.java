package org.flexunit.ant.tasks.types;

import java.io.File;

import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.types.FileSet;

public class SourcePaths extends CompilationFileSetCollection
{
   public SourcePaths()
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
         elements.append("\"" + fileset.getDir().getAbsolutePath() + "\"");
         elements.append(delimiter);
      }
      
      return elements.length() <= delimiter.length() ? "" : elements.substring(0, elements.length() - delimiter.length());
   }
   
   public String getImports()
   {
      StringBuilder elements = new StringBuilder();
      
      for(FileSet fileset : filesets)
      {
         DirectoryScanner ds = fileset.getDirectoryScanner();
         for(String file : ds.getIncludedFiles())
         {
            if(file.endsWith(".as") || file.endsWith(".mxml"))
            {
               String pathWithOutSuffix = file.substring(0, file.lastIndexOf('.'));
               String canonicalClassName = pathWithOutSuffix.replace(File.separatorChar, '.');
               elements.append("import ");
               elements.append(canonicalClassName);
               elements.append(";\n");
            }
         }
      }
      
      return elements.toString();
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
            String className = canonicalClassName.substring(canonicalClassName.lastIndexOf('.') + 1, canonicalClassName.length());
            elements.append(className);
            elements.append(',');
         }
      }
      
      return elements.length() == 0 ? "" : elements.substring(0, elements.length() - 1);
   }
   
   public String getCanonicalClasses(String delimiter)
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
            elements.append(delimiter);
         }
      }
      
      return elements.length() <= delimiter.length() ? "" : elements.substring(0, elements.length() - delimiter.length());
   }
}
