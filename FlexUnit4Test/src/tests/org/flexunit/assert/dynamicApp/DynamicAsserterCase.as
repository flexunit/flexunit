package tests.org.flexunit.assert.dynamicApp {
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.flexunit.Assert;
	
	import tests.org.flexunit.assert.dynamicApp.helper.AsserterHelper;

	public class DynamicAsserterCase {
		[Rule]
		public var mockolate:MockolateRule = new MockolateRule();
		
		[Mock]
		public var assertObj:AsserterHelper; 
		
		[Test(description="Ensure that the assertWithApply function correctly runs the function with the parameter array")]
		public function shouldPassUsingApply():void {
			var obj1:Object = new Object();
			var obj2:Object = new Object();
			
			stub( assertObj ).method( "assert" ).args( obj1,obj2 );
			
			Assert.assertWithApply( assertObj.assert, [obj1,obj2] );
		}
		
		[Test(description="Ensure that the assertWith function correct runs the function with the list of paramters")]
		public function shouldPassUsingInvoke():void {
			
			var obj1:Object = new Object();
			var obj2:Object = new Object();
			
			stub( assertObj ).method( "assert" ).args( obj1,obj2 );
			
			Assert.assertWith( assertObj.assert, obj1, obj2 );
		}
	}
}