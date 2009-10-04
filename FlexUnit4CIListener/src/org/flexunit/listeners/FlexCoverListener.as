package org.flexunit.listeners
{
   public class FlexCoverListener extends CIListener
   {
      import com.allurent.coverage.runtime.CoverageManager;
      
      public function FlexCoverListener(port : uint = DEFAULT_PORT, server : String = DEFAULT_SERVER)
      {
         super(port, server);
      }

      override protected function exit() : void
      {
         CoverageManager.exit();
      }
   }
}