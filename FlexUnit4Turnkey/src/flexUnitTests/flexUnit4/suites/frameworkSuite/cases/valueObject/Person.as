package flexUnitTests.flexUnit4.suites.frameworkSuite.cases.valueObject
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class Person extends EventDispatcher
	{
		public var firstName:String;
		public var lastName:String;

		private var _age:Number;
		
		[Bindable("ageChanged")]
		public function get age():Number {
			return _age;
		}
		
		public function set age( value:Number ):void {
			_age = value;
			dispatchEvent( new Event( "ageChanged" ) );
		}
	}
}