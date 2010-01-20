package org.fluint.uiImpersonation.cases
{
	import flash.display.Sprite;
	
	import mx.core.Container;
	
	import org.flexunit.Assert;
	import org.fluint.uiImpersonation.IVisualEnvironmentBuilder;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;

	public class TestEnvironmentCase
	{
		protected static var testEnvironment:IVisualTestEnvironment;
		
		[BeforeClass]
		public static function beforeClass():void {
			var builder:VisualTestEnvironmentBuilder = VisualTestEnvironmentBuilder.getInstance(); 
			testEnvironment = builder.buildVisualTestEnvironment();
		}
		
		//TODO: Since this is a singleton, it is currently impossible to cover both branches, any way in which this can be remedied?
		[Test(description="Ensure that an instance to the TestEnvironmentBuilder class is obtained the first time")]
		public function getInstanceNotCreatedTest():void
		{
			var builder:VisualTestEnvironmentBuilder = VisualTestEnvironmentBuilder.getInstance(); 
			var newEnvironment:IVisualTestEnvironment = builder.buildVisualTestEnvironment();
			
			Assert.assertTrue( testEnvironment is IVisualTestEnvironment );
			Assert.assertNotNull( testEnvironment );
			
			if ( testEnvironment is Sprite ) {
				Assert.assertNotNull( ( testEnvironment as Sprite ).stage );
			}
		}
		
		[Test(description="Ensure that the same instance to the TestEnvironmentBuilder class is obtained the second time")]
		public function getInstanceCreatedTest():void
		{
			var builder:VisualTestEnvironmentBuilder = VisualTestEnvironmentBuilder.getInstance(); 
			var newEnvironment:IVisualTestEnvironment = builder.buildVisualTestEnvironment();
			
			Assert.assertStrictlyEquals( testEnvironment, newEnvironment );
		}
		
		[Test(order=3,description="Ensure that a focus manager exists on an instance if it is flex-based")]
		public function getFocusManagerCreatedTest():void
		{
			if ( testEnvironment is Container ) {
				Assert.assertNotNull( ( testEnvironment as Container ).focusManager );	
			}
		}
	}
}