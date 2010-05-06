package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	public class TestBeforeAfterInheritance extends TestBeforeAfterInheritanceBaseClass
	{
		[Before(order=1)]
		public function beginOne():void {
			trace("beginOne");
		}
		
		[Before(order=2)]
		public function beginTwo():void {
			trace("beginTwo");
		}
		
		[Before(order=3)]
		public function beginThree():void {
			trace("beginThree");
		}
		
		[Test(order=1)]
		public function checkingBeforeOrder() : void {
			
		}
		
		[Test(order=2)]
		public function checkingAfterOrder() : void {
		}

		[After(order=1)]
		public function afterOne():void {
			trace("afterOne");
		}
		
		[After(order=2)]
		public function afterTwo():void {
			trace("afterTwo");
		}

		[After(order=3)]
		public function afterThree():void {
			trace("afterThree");
		}

	}
}