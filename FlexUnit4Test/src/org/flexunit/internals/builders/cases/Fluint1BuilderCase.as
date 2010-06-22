package org.flexunit.internals.builders.cases
{
	import flex.lang.reflect.Klass;
	
	import net.digitalprimates.fluint.tests.TestCase;
	
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.Fluint1Builder;
	import org.flexunit.internals.builders.definitions.Fluint1Class;
	import org.flexunit.internals.builders.definitions.Fluint1Suite;
	import org.flexunit.internals.runners.Fluint1ClassRunner;
	
	public class Fluint1BuilderCase extends Fluint1Builder
	{
		protected var f1 : Fluint1Class;
		protected var f2 : Fluint1Suite;
		
		[Test(description="Ensure that if a Fluin1Class is passed we get back a Fluint class runner")]
		public function testRunnerForClassCase() : void {
			Assert.assertTrue( runnerForClass( Fluint1Class ) is Fluint1ClassRunner );
		}
		
		[Test(description="Ensure that if a fluint suite is passed we recieve a fluint class runner")]
		public function testRunnerForClassSuite() : void {
			Assert.assertTrue( runnerForClass( Fluint1Suite ) is Fluint1ClassRunner );
		}
		
		[Test(description="Ensure the runner can handle a real Fluint class")]
		public function canHandleClassRight() : void {
			Assert.assertTrue( canHandleClass( Fluint1Class ) );
		}
		
		[Test(description="Ensure the runner doesn't handle a non Fluint class")]
		public function canHandleClassWrong() : void {
			Assert.assertFalse( canHandleClass( Object ) );
		}
		
		[Test(description="Ensure that if a fluint class is passed, FU4 properly recoginizes it as such")]
		public function testIsFluintSuiteOrCase() : void {
			Assert.assertTrue( isFluintSuiteOrCase( new Klass( Fluint1Class ) ) );	
		}
		
		[Test(description="Ensure that if a fluint suite is passed, FU4 recognizes it as such")]
		public function testIsFluintSuiteOrCaseCase() : void {
			Assert.assertTrue( isFluintSuiteOrCase( new Klass ( Fluint1Suite ) ) );
		}
		
		[Test(description="Ensure that if a fluint class or suite is not passed FU4 does nto recognize it mistakenly")]
		public function testIsFluintSuiteOrCaseFalse() : void {
			Assert.assertFalse( isFluintSuiteOrCase( new Klass( Object ) ) );
		}
		
	}
}