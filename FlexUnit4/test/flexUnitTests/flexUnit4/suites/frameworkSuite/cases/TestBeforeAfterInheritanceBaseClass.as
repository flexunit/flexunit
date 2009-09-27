package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	public class TestBeforeAfterInheritanceBaseClass extends TestBeforeAfterInheritanceBaseBaseClass
	{
		[Before(order=1)]
		public function beginOneParent():void {
		}
		
		[Before(order=2)]
		public function beginTwoParent():void {
		}
		
		
		[After(order=1)]
		public function afterOneParent():void {
		}
		
		[After(order=2)]
		public function afterTwoParent():void {
		}
	}
}