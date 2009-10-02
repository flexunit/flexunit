package org.flexunit.experimental.theories.internals.cases
{
	import flex.lang.reflect.mocks.ConstructorMock;
	import flex.lang.reflect.mocks.KlassMock;
	
	import org.flexunit.Assert;
	import org.flexunit.experimental.theories.ParameterSignature;
	import org.flexunit.experimental.theories.internals.AllMembersSupplier;
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.experimental.theories.mocks.ParameterSignatureMock;
	import org.flexunit.experimental.theories.mocks.PotentialAssignmentMock;
	import org.flexunit.runners.model.mocks.TestClassMock;

	public class AssignmentsCase
	{
		//TODO: Ensure that these tests and this test case have been correctly implemented
		
		protected var assignments:Assignments;
		protected var assigned:Array;
		protected var unassigned:Array;
		protected var testClassMock:TestClassMock;
		
		[Before(description="Create an instance of the Assignments class")]
		public function createAssignments():void {
			assigned = new Array();
			unassigned = new Array();
			testClassMock = new TestClassMock();
			assignments = new Assignments(assigned, unassigned, testClassMock);
		}
		
		[After(description="Remove the reference to the Assignments class")]
		public function destroyAssignments():void {
			assignments = null;
			unassigned = null;
			testClassMock = null;
			assignments = null;
		}
		
		[Test(description="Ensure that the constructor correctly assigns the parameters values to the class variables")]
		public function assignmentsConstructorTest():void {
			Assert.assertEquals( assigned, assignments.assigned );
			Assert.assertEquals( unassigned, assignments.unassigned );
			Assert.assertEquals( testClassMock, assignments.testClass );
		}
		
		//TODO: Is there a way to test this static function since it depends on another classes static functions?
		[Test(description="Ensure that the allUnassigned function correctly generates an Assignments with only values in the unassigned array")]
		public function allUnassignedTest():void {
			
		}
		
		[Test(description="Ensure that the get complete returns a value of false when the unassigned array is not empty")]
		public function getCompleteFalseTest():void {
			assignments.unassigned = [null];
			
			Assert.assertFalse( assignments.complete );
		}
		
		[Test(description="Ensure that the get complete returns a value of true when the unassigned array is empty")]
		public function getCompleteTrueTest():void {		
			Assert.assertTrue( assignments.complete );
		}
		
		[Test(description="Ensure that the nextUnassigned function correctly handles an empty unassigned array")]
		public function nextUnassignedEmptyTest():void {		
			Assert.assertNull( assignments.nextUnassigned() );
		}
		
		[Test(description="Ensure that the nextUnassigned function returns the next ParameterSignature of a non-empty unassigned array")]
		public function nextUnassignedNotEmptyTest():void {		
			var parameterSignatureMockOne:ParameterSignatureMock = new ParameterSignatureMock();
			var parameterSignatureMockTwo:ParameterSignatureMock = new ParameterSignatureMock();
			
			assignments.unassigned = [parameterSignatureMockOne, parameterSignatureMockTwo];
			
			Assert.assertEquals( parameterSignatureMockOne, assignments.nextUnassigned() );
		}
		
		[Test(description="Ensure that a new Assignments class instance is correctly created when the unassigned array is empty")]
		public function assignNextEmptyUnassignedTest():void {
			var potentialAssignmentMock:PotentialAssignmentMock = new PotentialAssignmentMock();
			
			var newAssignments:Assignments = assignments.assignNext(potentialAssignmentMock);
			
			Assert.assertEquals( potentialAssignmentMock, newAssignments.assigned[0] );
			Assert.assertEquals( 0, newAssignments.unassigned.length );
			Assert.assertEquals( assignments.testClass, newAssignments.testClass);
		}
		
		[Test(description="Ensure that a new Assignments class instance is correctly created when the unassigned array is not empty")]
		public function assignNextNotEmptyUnassignedTest():void {
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			var parameterSignatureMockOne:ParameterSignatureMock = new ParameterSignatureMock();
			var parameterSignatureMockTwo:ParameterSignatureMock = new ParameterSignatureMock();
			
			//Assign the arrays of assignments
			assignments.assigned = [potentialAssignmentMockOne];
			assignments.unassigned = [parameterSignatureMockOne, parameterSignatureMockTwo];
			
			var newAssignments:Assignments = assignments.assignNext(potentialAssignmentMockTwo);
			
			Assert.assertEquals( potentialAssignmentMockTwo, newAssignments.assigned[1] );
			Assert.assertEquals( 1, newAssignments.unassigned.length );
			Assert.assertEquals( parameterSignatureMockTwo, newAssignments.unassigned[0] );
			Assert.assertEquals( assignments.testClass, newAssignments.testClass);
		}
		
		[Test(expected="org.flexunit.experimental.theories.internals.error.CouldNotGenerateValueException",
			description="Ensure that getActualValues function throws a CouldNotGenerateValueException if null values are not ok")]
		public function getActualValuesNullsNotOkTest():void {
			var potentialAssignmentMock:PotentialAssignmentMock = new PotentialAssignmentMock();
			potentialAssignmentMock.mock.method("getValue").withNoArgs.once.returns(null);
			
			//Set the assigned array of assignments
			assignments.assigned = [potentialAssignmentMock];
			
			assignments.getActualValues(0, 1, false);
			
			potentialAssignmentMock.mock.verify();
		}
		
		[Test(description="Ensure that getActualValues function returns an array of values, even null values, if null values are ok")]
		public function getActualValuesNullsOkTest():void {
			var valueOne:Object = null;
			var valueTwo:Object = new Object();
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			potentialAssignmentMockOne.mock.method("getValue").withNoArgs.once.returns(valueOne);
			potentialAssignmentMockTwo.mock.method("getValue").withNoArgs.once.returns(valueTwo);
			
			//Set the assigned array of assignments
			assignments.assigned = [potentialAssignmentMockOne, potentialAssignmentMockTwo];
			
			var actualValues:Array = assignments.getActualValues(0, 2, true);
			
			Assert.assertNull( actualValues[0] );
			Assert.assertEquals( valueTwo, actualValues[1] );
			
			potentialAssignmentMockOne.mock.verify();
			potentialAssignmentMockTwo.mock.verify();
		}
		
		[Test(description="Ensure that getActualValues function returns the correct subset array of values based on the parameters passed to the function")]
		public function getActualValuesSubsetTest():void {
			var valueOne:Object = null;
			var valueTwo:Object = new Object();
			var valueThree:Object = new Object();
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockThree:PotentialAssignmentMock = new PotentialAssignmentMock();
			potentialAssignmentMockOne.mock.method("getValue").withNoArgs.never.returns(valueOne);
			potentialAssignmentMockTwo.mock.method("getValue").withNoArgs.once.returns(valueTwo);
			potentialAssignmentMockThree.mock.method("getValue").withNoArgs.once.returns(valueThree);
			
			//Set the assigned array of assignments
			assignments.assigned = [potentialAssignmentMockOne, potentialAssignmentMockTwo, potentialAssignmentMockThree];
			
			var actualValues:Array = assignments.getActualValues(1, 3, true);
			
			Assert.assertEquals( valueTwo, actualValues[0] );
			Assert.assertEquals( valueThree, actualValues[1] );
			
			potentialAssignmentMockOne.mock.verify();
			potentialAssignmentMockTwo.mock.verify();
			potentialAssignmentMockThree.mock.verify();
		}
		
		//TODO: This test needs to be reexamined to determine how to best check this case
		[Ignore]
		[Test(description="Ensure that getActualValues function correctly handles bad start/stop values")]
		public function getActualValuesBadStartStopTest():void {
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			potentialAssignmentMockOne.mock.method("getValue").withNoArgs.never.returns(valueOne);
			potentialAssignmentMockTwo.mock.method("getValue").withNoArgs.once.returns(valueTwo);
			
			//Set the assigned array of assignments
			assignments.assigned = [potentialAssignmentMockOne, potentialAssignmentMockTwo];
			
			var actualValues:Array = assignments.getActualValues(1, -1, true);
			
			Assert.assertEquals( valueTwo, actualValues[0] );
			
			potentialAssignmentMockOne.mock.verify();
			potentialAssignmentMockTwo.mock.verify();
		}
		
		//TODO: Is there a way to verify that this method is correctly called using the AllMembersSupplier?  It seems the only current way to test this is to set
		//expectations on teh parameter signature mock and determine when it gets called and make assertions based on the values it returns.
		[Test(description="Ensure that the potentialsForNextUnassigned function returns an array based on the parameter signatures in the unassigned array")]
		public function potentialsForNextUnassignedTest():void {
			var parameterSignatureMock:ParameterSignatureMock = new ParameterSignatureMock();
			
			assignments.unassigned [parameterSignatureMock];
		}
		
		[Test(description="Ensure that the getSupplier function returns an instanc of the AllMembersSupplier if the supplier is null")]
		public function getSupplierNullSupplierTest():void {
			var parameterSignatureMock:ParameterSignatureMock = new ParameterSignatureMock();
			
			Assert.assertTrue( assignments.getSupplier(parameterSignatureMock) is AllMembersSupplier );
		}
		
		//TODO: This test needs to be readded once the getAnnotatedSupplier function is updated
		[Ignore("This test needs to be readded once the getAnnotatedSupplier function is updated")]
		[Test(description="Ensure that the getSupplier function returns the supplier if the supplier is not null")]
		public function getSupplierNonNullSupplierTest():void {
			var parameterSignatureMock:ParameterSignatureMock = new ParameterSignatureMock();
			
			Assert.assertTrue( assignments.getSupplier(parameterSignatureMock) is ParameterSignature );
		}
		
		//TODO: This will need to be updated once the actual function is updated
		[Test(description="Ensure that the getAnnotatedSupplier function returns an instance of IParameterSupplier")]
		public function getAnnotatedSupplierTest():void {
			var parameterSignatureMock:ParameterSignatureMock = new ParameterSignatureMock();
			
			Assert.assertNull( assignments.getAnnotatedSupplier(parameterSignatureMock) );
		}
		
		[Test(description="Ensure that the getConstructorArguments function returns the correct array values")]
		public function getConstructorArgumentsTest():void {
			//Create values for the assigned array
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			potentialAssignmentMockOne.mock.method("getValue").withNoArgs.once.returns(valueOne);
			potentialAssignmentMockTwo.mock.method("getValue").withNoArgs.never.returns(valueTwo);
			
			//Create the information needed for the constructor
			var parameterTypes:Array = [Object];
			var klassMock:KlassMock = new KlassMock(null);
			var constructorMock:ConstructorMock = new ConstructorMock(null, null);
			testClassMock.mock.property("klassInfo").returns(klassMock);
			klassMock.mock.property("constructor").returns(constructorMock);
			constructorMock.mock.property("parameterTypes").returns(parameterTypes);
			
			//Set the assigned array of assignments
			assignments.assigned = [potentialAssignmentMockOne, potentialAssignmentMockTwo];
			
			var constructorArguments:Array = assignments.getConstructorArguments(true);
			
			Assert.assertEquals( valueOne, constructorArguments[0] );
			
			potentialAssignmentMockOne.mock.verify();
			potentialAssignmentMockTwo.mock.verify();
		}
		
		[Test(description="Ensure that the getMethodArguments function returns the correct array values")]
		public function getMethodArgumentsTest():void {
			//Create values for the assigned array
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			potentialAssignmentMockOne.mock.method("getValue").withNoArgs.never.returns(valueOne);
			potentialAssignmentMockTwo.mock.method("getValue").withNoArgs.once.returns(valueTwo);
			
			//Create the information needed for the constructor
			var parameterTypes:Array = [Object];
			var klassMock:KlassMock = new KlassMock(null);
			var constructorMock:ConstructorMock = new ConstructorMock(null, null);
			testClassMock.mock.property("klassInfo").returns(klassMock);
			klassMock.mock.property("constructor").returns(constructorMock);
			constructorMock.mock.property("parameterTypes").returns(parameterTypes);
			
			//Set the assigned array of assignments
			assignments.assigned = [potentialAssignmentMockOne, potentialAssignmentMockTwo];
			
			var methodArguments:Array = assignments.getMethodArguments(true);
			
			Assert.assertEquals( valueTwo, methodArguments[0] );
			
			potentialAssignmentMockOne.mock.verify();
			potentialAssignmentMockTwo.mock.verify();
		}
		
		[Test(description="Ensure that the getAllArguments function returns the correct array values")]
		public function getAllArgumentsTest():void {
			//Create values for the assigned array
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			potentialAssignmentMockOne.mock.method("getValue").withNoArgs.once.returns(valueOne);
			potentialAssignmentMockTwo.mock.method("getValue").withNoArgs.once.returns(valueTwo);
			
			//Set the assigned array of assignments
			assignments.assigned = [potentialAssignmentMockOne, potentialAssignmentMockTwo];
			
			var allArguments:Array = assignments.getAllArguments(true);
			
			Assert.assertEquals( valueOne, allArguments[0] );
			Assert.assertEquals( valueTwo, allArguments[1] );
			
			potentialAssignmentMockOne.mock.verify();
			potentialAssignmentMockTwo.mock.verify();
			
		}
		
		//TODO: Will the paraemter for this function be used? If so, another test will need to be written for a null case.
		[Test(description="Ensure that the getArgumentsString function returns an array of description strings")]
		public function getArgumentsStringTest():void {
			var descriptionOne:String = "testDescription";
			var descriptionTwo:String = null;
			var potentialAssignmentMockOne:PotentialAssignmentMock = new PotentialAssignmentMock();
			var potentialAssignmentMockTwo:PotentialAssignmentMock = new PotentialAssignmentMock();
			
			potentialAssignmentMockOne.mock.method("getDescription").withNoArgs.once.returns(descriptionOne);
			potentialAssignmentMockTwo.mock.method("getDescription").withNoArgs.once.returns(descriptionTwo);
			
			assignments.assigned = [potentialAssignmentMockOne, potentialAssignmentMockTwo];
			
			var argumentStrings:Array = assignments.getArgumentStrings(true);
			
			Assert.assertEquals( descriptionOne, argumentStrings[0] );
			Assert.assertEquals( descriptionTwo, argumentStrings[2] );
			
			potentialAssignmentMockOne.mock.verify();
			potentialAssignmentMockTwo.mock.verify();
		}
		
		[Test(description="Ensure that the toString method returns the correct string value")]
		public function toStringTest():void {
			var str:String = "              Assignments :\n";
			str += ("                  testClass:" + testClassMock + "\n");
			str += ("                  assigned:" + assigned + "\n");
			str += ("                  unassigned:" + unassigned);
			
			Assert.assertEquals( str, assignments.toString() );
		}
	}
}