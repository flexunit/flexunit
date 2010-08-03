package tests.org.flexunit.assert.assertionsMade {
	import org.flexunit.Assert;

	public class AssertionsMadeCase {
		[Test(description="Ensure that the assertionsMade property returns the correct assertCount")]
		public function shouldShowOneAssertionMade():void {
			var count:int = Assert.assertionsMade;
			//Reset the fields to ensure the the count is accurate
			Assert.assertEquals( 0, 0 );
			Assert.assertEquals( count + 1, Assert.assertionsMade );
		}
		
		[Test(description="Ensure that the resetAssertionsFields function correctly resets the assertCount")]
		public function shouldResetAssertionsMadeToZero():void {
			var count:int = Assert.assertionsMade;
			
			//Ensure that the number of assertions are greater than zero
			Assert.assertEquals( 0, 0 );			
			Assert.assertTrue( Assert.assertionsMade > 0 );
			
			//Reset the assertions
			Assert.resetAssertionsFields();
			
			Assert.assertEquals( Assert.assertionsMade, 0 );
			
			Assert._assertCount = count + 1;
		}
		
	}
}