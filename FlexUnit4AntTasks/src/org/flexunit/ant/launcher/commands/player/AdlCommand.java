package org.flexunit.ant.launcher.commands.player;

import java.io.File;
import java.io.IOException;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.types.FilterSet;
import org.apache.tools.ant.types.FilterSetCollection;
import org.apache.tools.ant.types.resources.FileResource;
import org.apache.tools.ant.types.resources.URLResource;
import org.apache.tools.ant.util.ResourceUtils;
import org.flexunit.ant.LoggingUtil;

public class AdlCommand extends DefaultPlayerCommand
{
   private final String DESCRIPTOR_TEMPLATE = "flexUnitDescriptor.template";
   private final String DESCRIPTOR_FILE = "flexUnitDescriptor.xml";
   
   @Override
   public void setSwf(File swf)
   {
      super.setSwf(swf);
      
      getCommandLine().setExecutable(generateExecutable());
      getCommandLine().addArguments(new String[]{swf.getParentFile().getAbsolutePath() + "/" + DESCRIPTOR_FILE});      
   }

   /**
    * Used to create the application descriptor used to invoke adl
    */
   private void createApplicationDescriptor(File swf)
   {
      try
      {
         //Template location in JAR
         URLResource template = new URLResource(getClass().getResource("/" + DESCRIPTOR_TEMPLATE));
         
         //Descriptor location, same location as SWF due to relative path required in descriptor
         File descriptor = new File(swf.getParentFile().getAbsolutePath() + "/" + DESCRIPTOR_FILE);
         
         //Create tokens to filter
         FilterSet filters = new FilterSet();
         filters.addFilter("ADL_SWF", swf.getName());
         
         //Copy descriptor template to SWF folder performing token replacement
         ResourceUtils.copyResource(
            template,
            new FileResource(descriptor),
            new FilterSetCollection(filters),
            null,
            true,
            false,
            null,
            null,
            getProject()
         );
         
         LoggingUtil.log("Created application descriptor at [" + descriptor.getAbsolutePath() + "]");
      }
      catch (Exception e)
      {
         throw new BuildException("Could not create application descriptor");
      }
   }
   
   @Override
   public Process launch() throws IOException
   {
      //Create Adl descriptor file
      createApplicationDescriptor(getSwf());
      
      //Run command
      return super.launch();
   }
   
   private String generateExecutable()
   {
      return getProject().getProperty("FLEX_HOME") + "/bin/" + getDefaults().getAdlCommand();
   }
}