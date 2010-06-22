package org.flexunit.ant.launcher.commands.headless;

public class XvncException extends Exception
{
	private static final long serialVersionUID = -879079265370069307L;
	
	public XvncException()
	{
		super("Could not find the vncserver command.");
	}

	public XvncException(int baseDisplayNumber, int finalDisplayNumber)
	{
		super("Could not start xvnc using displays " 
				+ String.valueOf(baseDisplayNumber) 
				+ "-" 
				+ String.valueOf(finalDisplayNumber) 
				+ "; Consider adding to your launch script: killall Xvnc Xrealvnc; rm -fv /tmp/.X*-lock /tmp/.X11-unix/X*");
	}
}
