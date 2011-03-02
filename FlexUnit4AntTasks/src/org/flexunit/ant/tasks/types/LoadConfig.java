package org.flexunit.ant.tasks.types;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DynamicAttribute;

public class LoadConfig implements DynamicAttribute
{
 	public void setDynamicAttribute(String arg0, String arg1)
			throws BuildException {
		if("filename".equals(arg0))
		{
          filename = arg1;
		}
        else
        {	
          throw new BuildException("filename is only allowed attribute for <load-config>");
        }
	}

    public String getFilename()
    {
        return filename;
    }

    public String getCommandLineArgument()
    {
        String argument = "";
        if(filename == null || "".equals(filename))
        {
        	argument = "";
        }
        else
        {
        	
        	argument = "-load-config+=\"" + filename + "\"";

        }
        
        return argument;
    }

    private String filename;

}
