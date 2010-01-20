package org.flexunit.runner.manipulation.mocks {
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IDescription;

	public class BasicFilterMock {

		public var mock:Mock;

		public function shouldRun( description:IDescription ):Boolean {
			return mock.shouldRun( description );
		}

		public function describe( description:IDescription ):String {
			return mock.describe( description );
		}
		
		public function BasicFilterMock() {
			mock = new Mock( this );
		}
	}
}