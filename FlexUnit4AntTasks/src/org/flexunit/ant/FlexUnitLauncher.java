package org.flexunit.ant;


/**
 * This class is used to launch the FlexUnit tests.
 */
public class FlexUnitLauncher
{
   private static final String WINDOWS_OS = "Windows";
   private static final String MAC_OS_X = "Mac OS X";

   /**
    * Run the SWF that contains the FlexUnit tests.
    * 
    * @param swf
    *           the name of the SWF
    * @throws Exception
    *            if there is an error launching the tests.
    */
   public void runTests(String swf, boolean localTrusted) throws Exception
   {
      SWFLauncher launcher = createSWFLauncher();

      launcher.launch(swf, localTrusted);
   }

   /**
    * Creates a SWF launcher suitable for the OS.
    * 
    * @return a new SWF launcher
    */
   private SWFLauncher createSWFLauncher()
   {
      SWFLauncher launcher = null;

      String os = System.getProperty("os.name");

      if (os.startsWith(WINDOWS_OS))
      {
         launcher = new WindowsSWFLauncher();
      }
      else if (os.startsWith(MAC_OS_X))
      {
         launcher = new MacSWFLauncher();
      }
      else
      {
         launcher = new UnixSWFLauncher();
      }

      return launcher;
   }
}