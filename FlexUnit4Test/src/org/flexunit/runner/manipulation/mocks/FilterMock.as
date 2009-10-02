package org.flexunit.runner.manipulation.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.manipulation.Filter;
	
	public class FilterMock extends Filter
	{
		public var mock:Mock;
		
		public function FilterMock( shouldRun:Function=null, describe:Function=null ) {
			mock = new Mock( this );
		}
		
		override public function apply(child:Object):void {
			mock.apply( child );
		}

	}
}