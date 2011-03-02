package org.flexunit.ant.launcher.commands.player;

import java.io.File;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.taskdefs.Java;
import org.apache.tools.ant.types.FilterSet;
import org.apache.tools.ant.types.FilterSetCollection;
import org.apache.tools.ant.types.Commandline.Argument;
import org.apache.tools.ant.types.resources.FileResource;
import org.apache.tools.ant.types.resources.URLResource;
import org.apache.tools.ant.util.ResourceUtils;
import org.flexunit.ant.LoggingUtil;

public class AdlCommand extends DefaultPlayerCommand
{
	private final String ADT_JAR_PATH = "lib" + File.separatorChar + "adt.jar";
	private final String DESCRIPTOR_TEMPLATE = "flexUnitDescriptor.template";
	private final String DESCRIPTOR_FILE = "flexUnitDescriptor.xml";
	
	@Override
	public File getFileToExecute()
	{
		return new File(getSwf().getParentFile().getAbsolutePath() + File.separatorChar + DESCRIPTOR_FILE);
	}
	
	/**
	 * Used to create the application descriptor used to invoke adl
	 */
	private void createApplicationDescriptor()
	{
		try
		{
			//Template location in JAR
			URLResource template = new URLResource(getClass().getResource("/" + DESCRIPTOR_TEMPLATE));
			
			//Descriptor location, same location as SWF due to relative path required in descriptor
			File descriptor = new File(getSwf().getParentFile().getAbsolutePath() + File.separatorChar + DESCRIPTOR_FILE);
			
			//Create tokens to filter
			FilterSet filters = new FilterSet();
			filters.addFilter("ADL_SWF", getSwf().getName());
			filters.addFilter("ADT_VERSION", Double.toString(getVersion()));
			
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
	
	private double getVersion()
	{
		String outputProperty = "AIR_VERSION";
		
		//Execute mxmlc to find SDK version number
		Java task = new Java();
		task.setFork(true);
		task.setFailonerror(true);
		task.setJar(new File(getProject().getProperty("FLEX_HOME") + File.separatorChar + ADT_JAR_PATH));
		task.setProject(getProject());
		task.setDir(getProject().getBaseDir());
		task.setOutputproperty(outputProperty);
		
		Argument versionArgument = task.createArg();
		versionArgument.setValue("-version");
		
		task.execute();
		
		
		double version = parseAdtVersionNumber( getProject().getProperty(outputProperty) );
		
		LoggingUtil.log("Found AIR version: " + version);
		
		return version;
	}
	
	private double parseAdtVersionNumber( String versionString )
	{
		double version;
		
		//AIR 2.6 and greater only returns the version number.
		if( versionString.startsWith("adt") )
		{
			//Parse version number and return as int
			int prefixIndex = versionString.indexOf("adt version \"");
			version = Double.parseDouble(versionString.substring(prefixIndex + 13, prefixIndex + 16));
			
		}else
		{
			version = Double.parseDouble(versionString.substring(0, 3) );
		}
		
		return version;
	}
	
	@Override
	public void prepare()
	{
		getCommandLine().setExecutable(generateExecutable());
		getCommandLine().addArguments(new String[]{getFileToExecute().getAbsolutePath()});   
		
		//Create Adl descriptor file
		createApplicationDescriptor();
	}
	
	private String generateExecutable()
   {
      return getProject().getProperty("FLEX_HOME") + "/bin/" + getDefaults().getAdlCommand();
   }

}