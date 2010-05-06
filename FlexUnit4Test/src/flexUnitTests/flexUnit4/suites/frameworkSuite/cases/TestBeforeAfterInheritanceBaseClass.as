package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	public class TestBeforeAfterInheritanceBaseClass extends TestBeforeAfterInheritanceBaseBaseClass
	{
		[Before(order=1)]
		public function beginOneParent():void {
			TestBeforeAfterInheritance.setupOrderArray.push("first");
		}
		
		[Before(order=2)]
		public function beginTwoParent():void {
			TestBeforeAfterInheritance.setupOrderArray.push("second");
		}
		
		
		[After(order=1)]
		public function afterOneParent():void {
			TestBeforeAfterInheritance.setupOrderArray.push("nineth");
		}
		
		[After(order=2)]
		public function afterTwoParent():void {
			TestBeforeAfterInheritance.setupOrderArray.push("tenth");
		}
	}
}