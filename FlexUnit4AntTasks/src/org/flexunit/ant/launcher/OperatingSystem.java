package org.flexunit.ant.launcher;

import org.flexunit.ant.LoggingUtil;

public enum OperatingSystem
{
	WINDOWS, MACOSX, LINUX;

	private static final String SUN_WINDOWS = "windows";
	private static final String SUN_MACOSX = "mac os x";
	private static final String OPENJDK_MACOSX = "darwin";
	
	/**
	 * Searches for Windows and Mac specificially and if not found defaults to Linux.
	 */
	public static OperatingSystem identify()
	{
		OperatingSystem os = null;
		String env = System.getProperty("os.name").toLowerCase();

		if (env.startsWith(SUN_WINDOWS))
		{
			LoggingUtil.log("OS: [Windows]");
			os = OperatingSystem.WINDOWS;
		} 
		else if (env.contains(SUN_MACOSX) || env.contains(OPENJDK_MACOSX))
		{
			LoggingUtil.log("OS: [Mac]");
			os = OperatingSystem.MACOSX;
		} 
		else
		{
			LoggingUtil.log("OS: [Linux]");
			os = OperatingSystem.LINUX;
		}
		
		return os;
	}
}
