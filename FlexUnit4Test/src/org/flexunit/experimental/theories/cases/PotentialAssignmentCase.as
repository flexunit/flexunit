package org.flexunit.experimental.theories.cases
{
	import org.flexunit.Assert;
	import org.flexunit.experimental.theories.PotentialAssignment;

	public class PotentialAssignmentCase
	{
		protected var potentialAssignment:PotentialAssignment;
		protected var name:String;
		protected var value:Object;
		
		[Before(description="Create an instance of the PotentialAssignment class")]
		public function createPotentialAssignment():void {
			name = "testName";
			value = new Object();
			
			potentialAssignment = new PotentialAssignment(name, value);
		}
		
		[After(description="Remove the reference to the PotentialAssignment class")]
		public function destroyPotentialAssignment():void {
			potentialAssignment = null;
			value = null;
			name = null;
		}
		
		[Test(description="Ensure that the forValue function correctly creates an instance of the PotentialAssignment class")]
		public function forValueTest():void {
			var generatedPotentialAssignment:PotentialAssignment = PotentialAssignment.forValue(name, value);
			Assert.assertEquals( name, generatedPotentialAssignment.name );
			Assert.assertEquals( value, generatedPotentialAssignment.value );
		}
		
		[Test(description="Ensure that the PotentialAssignment constructor correctly assigns the parameters to the proper class variables")]
		public function potentialAssignmentConstructorTest():void {
			Assert.assertEquals( name, potentialAssignment.name);
			Assert.assertEquals( value, potentialAssignment.value );
		}
		
		[Test(description="Ensure that the getValue function correctly returns the value")]
		public function getValueTest():void {
			Assert.assertEquals( value, potentialAssignment.getValue() );
		}
		
		[Test(description="Ensure that the getDescription function correctly returns the name")]
		public function getDescriptionTest():void {
			Assert.assertEquals( name, potentialAssignment.getDescription() );
		}
		
		[Test(description="Ensure that the toString method returns the correct string value")]
		public function toStringTest():void {
			Assert.assertEquals( name + ' ' + "[" + String( value ) + "]", potentialAssignment.toString() );
		}
	}
}