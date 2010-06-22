package org.flexunit.ant.launcher.commands.player;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

import org.apache.tools.ant.Project;
import org.flexunit.ant.LoggingUtil;

public class TrustFile
{
   public static final String TRUST_FILENAME = "flexUnit.cfg";
   
   private File trustDirectory;
   private File trustFile;
   private List<String> paths;
   
   public TrustFile(Project project, File userTrustDirectory, File globaTrustDirectory)
   {
      this.trustDirectory = userTrustDirectory != null ? userTrustDirectory : globaTrustDirectory;
      this.trustFile = project.resolveFile(trustDirectory.getAbsolutePath() + "/" + TRUST_FILENAME);
      this.paths = read();
   }
   
   private List<String> read()
   {
      List<String> paths = new ArrayList<String>();
      
      if(trustFile.exists())
      {
         try
         {
            BufferedReader reader = new BufferedReader(new FileReader(trustFile));
            String path = null;
            
            while((path = reader.readLine()) != null)
            {
               paths.add(path);
            }
            
            reader.close();
         }
         catch(Exception e)
         {
            e.printStackTrace();
         }
      }
      
      return paths;
   }
   
   public void add(File swf)
   {
      //create the appropriate FP trust directory is it doesn't exist
      if(!trustDirectory.exists())
      {
         trustDirectory.mkdir();
      }
       
      //Add path if it doesn't exist
      String path = swf.getParentFile().getAbsolutePath();
      if(!paths.contains(path))
      {
         paths.add(path);
         
         //Write file
         write();
            
         LoggingUtil.log("Updated local trust file at [" + trustFile.getAbsolutePath() + "], added [" + path + "].");
      }
   }
   
   private void write()
   {
      try
      {
         FileWriter writer = new FileWriter(trustFile, false);
         
         for(String path : paths)
         {
            writer.write(path + System.getProperty("line.separator"));
         }
         
         writer.close();
      }
      catch (Exception e)
      {
         e.printStackTrace();
      }
   }
   
   public void remove(File swf)
   {
      //remove path if exists
      String path = swf.getParentFile().getAbsolutePath();
      if(paths.contains(path))
      {
         paths.remove(path);
         
         //write out new copy of file
         write();
         
         LoggingUtil.log("Updated local trust file at [" + trustFile.getAbsolutePath() + "], removed [" + path + "].");
      }
   }
}
