package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	public class TestBeforeAfterInheritanceBaseClass extends TestBeforeAfterInheritanceBaseBaseClass
	{
		[Before(order=1)]
		public function beginOneParent():void {
			trace("beginOneParent");
		}
		
		[Before(order=2)]
		public function beginTwoParent():void {
			trace("beginTwoParent");
		}
		
		
		[After(order=1)]
		public function afterOneParent():void {
			trace("afterOneParent");
		}
		
		[After(order=2)]
		public function afterTwoParent():void {
			trace("afterTwoParent");
		}
	}
}