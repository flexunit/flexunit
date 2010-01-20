package org.flexunit.runner.manipulation.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.manipulation.filters.DynamicFilter;
	
	public class FilterMock extends org.flexunit.runner.manipulation.filters.DynamicFilter
	{
		public var mock:Mock;
		
		public function FilterMock( shouldRun:Function, describe:Function ) {
			super( shouldRun, describe );
			mock = new Mock( this );
		}
		
		override public function apply(child:Object):void {
			mock.apply( child );
		}

	}
}