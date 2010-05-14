package org.flexunit.internals.builders.cases
{
	import flex.lang.reflect.Klass;
	
	import flexunit.framework.TestCase;
	
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.FlexUnit1Builder;
	import org.flexunit.internals.builders.definitions.FlexUnit1Class;
	import org.flexunit.internals.runners.FlexUnit1ClassRunner;
	
	public class FlexUnit1BuilderCase extends FlexUnit1Builder
	{		
		protected var t1 : FlexUnit1Class;
		
		[Test(description="Ensure a FlexUnit1ClassRunner is returned if a FU1 class is passed")]
		public function testRunnerForClassClass() : void {
			Assert.assertTrue( runnerForClass( FlexUnit1Class ) is FlexUnit1ClassRunner );
		}
		
		[Ignore("Need to rework this test")]
		[Test(description="Ensure if a FlexUnit1 Class is not passed that the runner returns null")]
		public function testRunnerForClassNull(): void {
			Assert.assertNull( runnerForClass( Object ) ); 
		}
		
		[Test(description="Ensure that isPre4Test returns true in the case we have a pre FU4 test")]
		public function testIsPre4TestTrue() : void {
			Assert.assertTrue( isPre4Test( new Klass( FlexUnit1Class ) ) );
		}
		
		[Test(description="Ensure that if a pre FU4 test is not passed, that we recieve a false")]
		public function testIsPre4TestFalse() : void {
			Assert.assertFalse( isPre4Test( new Klass( Object ) ) );
		}
	}
	
	
}

