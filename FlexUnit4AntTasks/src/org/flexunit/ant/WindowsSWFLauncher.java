package org.flexunit.ant;


/**
 * Launches a SWF on Windows.
 */
public class WindowsSWFLauncher extends SWFLauncher
{
   private static final String WINDOWS_CMD = "rundll32 url.dll,FileProtocolHandler ";
   private final String localTrustedDirectory = "C:\\WINDOWS\\system32\\Macromed\\Flash\\FlashPlayerTrust\\";

   public String getLocalTrustedDirectory()
   {
      return this.localTrustedDirectory;
   }

   protected void runTests(String swf) throws Exception
   {
      // Ideally we want to launch the SWF in the player so we can close
      // it, not so easy in a browser. We let 'rundll32' do the work based
      // on the extension of the file passed in.
      Runtime.getRuntime().exec(WINDOWS_CMD + swf);
   }
}
