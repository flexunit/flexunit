package org.flexunit.ant.launcher.commands.headless;

import java.io.IOException;

import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.commands.Command;

public class XvncStartCommand extends Command
{
	private final String VNC_SERVER_COMMAND = "vncserver";
	private final int MAX_DISPLAY_CYCLES = 2;
	
	private int baseDisplay;
	private int currentDisplay;
	
	public XvncStartCommand(int display)
	{
		super();
		this.baseDisplay = display;
		this.currentDisplay = display;
	}
	
	public void cycle() throws XvncException
	{
		if((currentDisplay - baseDisplay) == MAX_DISPLAY_CYCLES)
		{
			throw new XvncException(baseDisplay, currentDisplay);
		}
		
		currentDisplay++;
	}
	
	public int getCurrentDisplay()
	{
		return currentDisplay;
	}
	
	@Override
	public int execute() throws IOException
	{
		getCommandLine().setExecutable(VNC_SERVER_COMMAND);
		getCommandLine().addArguments(new String[]{":" + String.valueOf(currentDisplay)});
		
		LoggingUtil.log("Attempting start on :" + currentDisplay + " ...");
		
		return super.execute();
	}
}
