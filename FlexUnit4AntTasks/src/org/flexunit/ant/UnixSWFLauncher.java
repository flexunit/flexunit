package org.flexunit.ant;


/**
 * Launches a SWF on Unix.
 */
public class UnixSWFLauncher extends SWFLauncher
{
   private static final String UNIX_CMD = "gflashplayer ";
   private final String localTrustedDirectory = System.getProperty("user.home") + "/.macromedia/Flash_Player/#Security/FlashPlayerTrust/";

   public String getLocalTrustedDirectory()
   {
      return this.localTrustedDirectory;
   }

   protected void runTests(String swf) throws Exception
   {
      // If we are running in UNIX the fallback is to the browser. To do
      // this Netscape must be running for the "-remote" flag to work. If
      // the browser is not running we need to start it.
      Process p = Runtime.getRuntime().exec(UNIX_CMD + swf);

      // If the exist code is '0', then the browser was running, otherwise
      // we need to start the browser.
      int exitValue = p.waitFor();

      if (exitValue != 0)
      {
         Runtime.getRuntime().exec(UNIX_CMD + swf);
      }
   }

}