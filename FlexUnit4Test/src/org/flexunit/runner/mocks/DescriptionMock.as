package org.flexunit.runner.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.runner.IDescription;

	public class DescriptionMock implements IDescription
	{
		public var mock:Mock;
		
		public function DescriptionMock()
		{
			mock = new Mock( this );
		}
		
		public function get children():Array
		{
			return mock.children;
		}
		
		public function get displayName():String
		{
			return mock.displayName;
		}
		
		public function get isSuite():Boolean
		{
			return mock.isSuite;
		}
		
		public function get isTest():Boolean
		{
			return mock.isTest;
		}
		
		public function get testCount():int
		{
			return mock.testCount;
		}
		
		public function getAllMetadata():Array
		{
			return mock.getAllMetadata;
		}
		
		public function get isInstance():Boolean
		{
			return mock.isInstance;
		}
		
		public function get isEmpty():Boolean
		{
			return mock.isEmpty;
		}
		
		public function addChild(description:IDescription):void
		{
			mock.addChild( description );
		}
		
		public function childlessCopy():IDescription
		{
			return mock.childlessCopy();
		}
		
		public function equals(obj:Object):Boolean
		{
			return mock.equals( obj );
		}
		
	}
}