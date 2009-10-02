package org.flexunit.runners.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.internals.runners.statements.StatementSequencer;
	import org.flexunit.runner.notification.RunNotifier;
	import org.flexunit.runner.notification.mocks.RunNotifierMock;
	import org.flexunit.runners.ParentRunner;
	import org.flexunit.runners.model.TestClass;

	public class ParentRunnerCase extends ParentRunner
	{
		private var runner:ParentRunner;
		
		[Before]
		public function setUp():void {
			
		}
		
		[After]
		public function tearDown():void {

		}
		
		[Test(expected="TypeError")]
		public function testGetDescription():void {
			Assert.assertNull( description );
		}
		
		[Test]
		public function testToString():void {
			Assert.assertEquals( "ParentRunner", toString() );
		}
		
		[Test( description = "Ensure constructer sets the testClass" )]
		public function testClassSet() : void {
			Assert.assertTrue( testClass is TestClass  );
		}
		
		[Test( description = "Ensure constructor sets the name properly" )]
		public function testName(): void {
			Assert.assertEquals( "org.flexunit.runners.cases::ParentRunnerCase", name  );
		}
		
		[Test( description = "Ensure ParentRunner has no children" )]
		public function testChildren() : void {
			Assert.assertNull( children );
		}
		
		
		public function ParentRunnerCase() {
			super( ParentRunnerCase );
		}
	}
}