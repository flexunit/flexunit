package org.flexunit.listeners
{
	import org.flexunit.listeners.closer.FlexCoverCloser;

   public class FlexCoverListener extends CIListener
   {
      import com.allurent.coverage.runtime.CoverageManager;
      
      public function FlexCoverListener(port : uint = DEFAULT_PORT, server : String = DEFAULT_SERVER)
      {
         super(port, server);
		 super.closer = new FlexCoverCloser();
      }
   }
}