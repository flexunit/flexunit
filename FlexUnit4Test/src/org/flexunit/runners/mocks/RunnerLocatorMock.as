package org.flexunit.runners.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.RunnerLocator;

	[Bindable(event="testMetadata")]
	public class RunnerLocatorMock extends RunnerLocator
	{
		public var mock:Mock;
		
		
		/**
		 * Constructor
		 *
 		 * @param param1
		 * @param param2
		 * @param param3
		 * @param param4
		 * @param param5
		 * @param param6
		 * 
		 * <br/>
		 * All six params are generic arguments for use in testing Constructor.as
		 * See ConstructorCase check_newInstance_valid_number_of_agruments method 
		 */
		public function RunnerLocatorMock( param1:String=null,
										   param2:String=null,
										   param3:String=null,
										   param4:String=null,
										   param5:String=null,
										   param6:String=null,
										   param7:String=null ) {
			mock = new Mock( this );
		}
		
		override public function registerRunnerForTest( test:Object, runner:IRunner ):void {
			mock.registerRunnerForTest( test, runner );
		}
		
		override public function getRunnerForTest( test:Object ):IRunner {
			return getRunnerForTest( test );
		} 	
		
	}
}