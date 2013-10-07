package org.sonatype.flexmojos.util;

public class OSUtils
{

    private static final String WINDOWS_CMD = "FlashPlayer.exe";

    private static final String MAC_CMD = "Flash Player";

    private static final String UNIX_CMD = "flashplayer";

    public enum OS
    {
        windows, linux, solaris, mac, unix, other;
    }

    public static OS getOSType()
    {
        String osName = System.getProperty( "os.name" ).toLowerCase();
        for ( OS os : OS.values() )
        {
            if ( osName.contains( os.toString() ) )
            {
                return os;
            }
        }
        return OS.other;
    }

    public static String[] getPlatformDefaultFlashPlayer()
    {
        switch ( getOSType() )
        {
            case windows:
                return new String[] { WINDOWS_CMD };
            case mac:
                return new String[] { MAC_CMD };
            default:
                return new String[] { UNIX_CMD };
        }
    }

    public static String[] getPlatformDefaultAdl()
    {
        switch ( getOSType() )
        {
            case windows:
                return new String[] { "adl.exe" };
            default:
                return new String[] { "adl" };
        }
    }

    public static boolean isLinux()
    {
        switch ( getOSType() )
        {
            case windows:
            case mac:
                return false;
            default:
                return true;
        }
    }

    public static boolean isWindows()
    {
        return getOSType().equals( OS.windows );
    }

    public static boolean isMacOS()
    {
        return getOSType().equals( OS.mac );
    }

}