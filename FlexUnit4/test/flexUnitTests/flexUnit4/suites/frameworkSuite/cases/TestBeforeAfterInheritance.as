package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	public class TestBeforeAfterInheritance extends TestBeforeAfterInheritanceBaseClass
	{
		[Before(order=1)]
		public function beginOne():void {
		}
		
		[Before(order=2)]
		public function beginTwo():void {
		}
		
		[Before(order=3)]
		public function beginThree():void {
		}
		
		[Test(order=1)]
		public function checkingBeforeOrder() : void {
		}
		
		[Test(order=2)]
		public function checkingAfterOrder() : void {
		}

		[After(order=1)]
		public function afterOne():void {
		}
		
		[After(order=2)]
		public function afterTwo():void {
		}

		[After(order=3)]
		public function afterThree():void {
		}

	}
}