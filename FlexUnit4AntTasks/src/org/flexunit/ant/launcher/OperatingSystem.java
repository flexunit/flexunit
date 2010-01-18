package org.flexunit.ant.launcher;

import org.flexunit.ant.LoggingUtil;

public enum OperatingSystem
{
	WINDOWS, MACOSX, UNIX;

	private static final String WINDOWS_OS = "Windows";
	private static final String MAC_OS_X = "Mac OS X";

	public static OperatingSystem identify()
	{
		OperatingSystem os = null;
		String env = System.getProperty("os.name");

		if (env.startsWith(WINDOWS_OS))
		{
			LoggingUtil.log("OS: [Windows]");
			os = OperatingSystem.WINDOWS;
		} else if (env.startsWith(MAC_OS_X))
		{
			LoggingUtil.log("OS: [Mac OSX]");
			os = OperatingSystem.MACOSX;
		} else
		{
			LoggingUtil.log("OS: [Unix]");
			os = OperatingSystem.UNIX;
		}

		return os;
	}
}
