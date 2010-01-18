package org.flexunit.ant.launcher.commands.headless;

import java.io.IOException;

import org.flexunit.ant.LoggingUtil;
import org.flexunit.ant.launcher.commands.Command;

public class XvncStopCommand extends Command
{
	private final String VNC_SERVER_COMMAND = "vncserver";
	private int display;

	public XvncStopCommand(int display)
	{
		super();
		this.display = display;
	}

	@Override
	public int execute() throws IOException
	{
		LoggingUtil.log("Terminating xvnc on :" + display);
		
		getCommandLine().setExecutable(VNC_SERVER_COMMAND);
		getCommandLine().addArguments(new String[]{ "-kill", ":" + String.valueOf(display) });

		return super.execute();
	}
}
