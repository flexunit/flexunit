package org.flexunit.internals.builders.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.SuiteMethodBuilder;
	import org.flexunit.internals.builders.definitions.FlexUnit4Class;
	import org.flexunit.internals.runners.SuiteMethod;

	public class SuiteMethodBuilderCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		protected var suiteMethodBuilder:SuiteMethodBuilder;
		
		[Before(description="Create an instance of the SuiteMethodBuilder class")]
		public function createSuiteMethodBuilder():void {
			suiteMethodBuilder = new SuiteMethodBuilder();
		}
		
		[After(description="Remove the referecne to the instance of the SuiteMethodBuilder class")]
		public function destroySuiteMethodBuilder():void {
			suiteMethodBuilder = null;
		}
		
		[Test(description="Ensure the runner can handle a real Suite class")]
		public function canHandleClassRight() : void {
			Assert.assertTrue( suiteMethodBuilder.canHandleClass( FlexUnit4Class ) );
		}
		
		[Test(description="Ensure the runner doesn't handle a non Suite class")]
		public function canHandleClassWrong() : void {
			Assert.assertFalse( suiteMethodBuilder.canHandleClass( Object ) );
		}
		
		[Ignore]
		[Test(description="Ensure that the runnerForClass function returns a Suite Method if the Class has a suite method")]
		public function runnerForClassSuiteMethodTest():void {
			Assert.assertTrue( suiteMethodBuilder.runnerForClass(FlexUnit4Class) is SuiteMethod );
		}
		
		[Test(description="Ensure that the hasSuiteMethod function returns false if the Class does not have a suite mothod")]
		public function hasSuiteMethodFalseTest():void {
			Assert.assertFalse( suiteMethodBuilder.hasSuiteMethod(Object) );
		}
		
		[Test(description="Ensure that the hasSuiteMethod function returns true if the Class has a suite method")]
		public function hasSuiteMethodTrueTest():void {
			Assert.assertTrue( suiteMethodBuilder.hasSuiteMethod(FlexUnit4Class) );
		}
	}
}