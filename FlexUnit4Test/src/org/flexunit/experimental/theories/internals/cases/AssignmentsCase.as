package org.flexunit.experimental.theories.internals.cases
{
	import mockolate.mock;
	import mockolate.runner.MockolateRule;
	import mockolate.runner.MockolateRunner;
	import mockolate.strict;
	import mockolate.stub;
	import mockolate.verify; MockolateRunner; 
	
	import org.flexunit.Assert;
	import org.flexunit.experimental.theories.ParameterSignature;
	import org.flexunit.experimental.theories.PotentialAssignment;
	import org.flexunit.experimental.theories.internals.AllMembersSupplier;
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.runners.model.TestClass;
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Constructor;
	import flash.utils.getDefinitionByName;
	
	[RunWith("mockolate.runner.MockolateRunner")]
	public class AssignmentsCase
	{
		//TODO: Ensure that these tests and this test case have been correctly implemented
		[Mock(type="strict")]
		public var parameterSignatureMock1:ParameterSignature;
		[Mock(type="strict")]
		public var parameterSignatureMock2:ParameterSignature;
		[Mock(type="strict")]
		public var potentialAssignmentMock1:PotentialAssignment;
		[Mock(type="strict")]
		public var potentialAssignmentMock2:PotentialAssignment;
		[Mock(type="strict")]
		public var potentialAssignmentMock3:PotentialAssignment;
		[Mock(type="strict")]
		public var testClassMock:TestClass;
		[Mock(type="strict")]
		public var klassMock:Klass;
		[Mock(type="strict",inject="false")]
		public var constructorMock:Constructor;
		
		protected var realConstructor:Constructor
		protected var assigned:Array;
		protected var unassigned:Array;
		protected var assignments2:Assignments;
		
		[Before(description="Create an instance of the Assignments class")]
		public function createAssignments():void {
			assigned = new Array();
			unassigned = new Array();
			constructorMock = strict(Constructor,null,[null,klassMock]);
			realConstructor = new Constructor(null,klassMock);
			assignments2 = new Assignments(assigned,unassigned, testClassMock);
			
		}
		[After(description="Remove the reference to the Assignments class")]
		public function destroyAssignments():void {
			assigned = null;
			unassigned = null;
			assignments2 = null;
		}
		
		[Test(description="Ensure that the constructor correctly assigns the parameters values to the class variables")]
		public function assignmentsConstructorTest():void {
			Assert.assertEquals( assigned, assignments2.assigned );
			Assert.assertEquals( unassigned, assignments2.unassigned );
			Assert.assertEquals( testClassMock, assignments2.testClass );
		}
		
		//TODO: Is there a way to test this static function since it depends on another classes static functions?
		[Ignore]
		[Test(description="Ensure that the allUnassigned function correctly generates an Assignments with only values in the unassigned array")]
		public function allUnassignedTest():void {
			
		}
		
		[Test(description="Ensure that the get complete returns a value of false when the unassigned array is not empty")]
		public function getCompleteFalseTest():void {
			assignments2.unassigned = [null];
			
			Assert.assertFalse( assignments2.complete );
		}
		
		[Test(description="Ensure that the get complete returns a value of true when the unassigned array is empty")]
		public function getCompleteTrueTest():void {		
			Assert.assertTrue( assignments2.complete );
		}
		
		[Test(description="Ensure that the nextUnassigned function correctly handles an empty unassigned array")]
		public function nextUnassignedEmptyTest():void {		
			Assert.assertNull( assignments2.nextUnassigned() );
		}
		
		[Test(description="Ensure that the nextUnassigned function returns the next ParameterSignature of a non-empty unassigned array")]
		public function nextUnassignedNotEmptyTest():void {		
			assignments2.unassigned = [parameterSignatureMock1, parameterSignatureMock2];
			
			Assert.assertEquals( parameterSignatureMock1, assignments2.nextUnassigned() );
		}
		
		[Test(description="Ensure that a new Assignments class instance is correctly created when the unassigned array is empty")]
		public function assignNextEmptyUnassignedTest():void {
			
			var newAssignments:Assignments = assignments2.assignNext(potentialAssignmentMock1);
			
			Assert.assertEquals( potentialAssignmentMock1, newAssignments.assigned[0] );
			Assert.assertEquals( 0, newAssignments.unassigned.length );
			Assert.assertEquals( assignments2.testClass, newAssignments.testClass);
		}
		
		[Test(description="Ensure that a new Assignments class instance is correctly created when the unassigned array is not empty")]
		public function assignNextNotEmptyUnassignedTest():void {
	
			//Assign the arrays of assignments
			assignments2.assigned = [potentialAssignmentMock1];
			assignments2.unassigned = [parameterSignatureMock1, parameterSignatureMock2];
			
			var newAssignments:Assignments = assignments2.assignNext(potentialAssignmentMock2);
			
			Assert.assertEquals( potentialAssignmentMock2, newAssignments.assigned[1] );
			Assert.assertEquals( 1, newAssignments.unassigned.length );
			Assert.assertEquals( parameterSignatureMock2, newAssignments.unassigned[0] );
			Assert.assertEquals( assignments2.testClass, newAssignments.testClass);
		}
		
		[Test(expected="org.flexunit.experimental.theories.internals.error.CouldNotGenerateValueException",
			description="Ensure that getActualValues function throws a CouldNotGenerateValueException if null values are not ok")]
		public function getActualValuesNullsNotOkTest():void {
		
			mock(potentialAssignmentMock1).method("getValue").noArgs().returns(null).once();
			
			//Set the assigned array of assignments
			assignments2.assigned = [potentialAssignmentMock1];
			
			assignments2.getActualValues(0, 1, false);
			
			verify(potentialAssignmentMock2);
		}
		
		[Test(description="Ensure that getActualValues function returns an array of values, even null values, if null values are ok")]
		public function getActualValuesNullsOkTest():void {
			var valueOne:Object = null;
			var valueTwo:Object = new Object();
			
			mock(potentialAssignmentMock1).method("getValue").noArgs().returns(valueOne).once();
			mock(potentialAssignmentMock2).method("getValue").noArgs().returns(valueTwo).once();
			
			//Set the assigned array of assignments
			assignments2.assigned = [potentialAssignmentMock1, potentialAssignmentMock2];
			
			var actualValues:Array = assignments2.getActualValues(0, 2, true);
			
			Assert.assertNull( actualValues[0] );
			Assert.assertEquals( valueTwo, actualValues[1] );
			
			verify(potentialAssignmentMock1);
			verify(potentialAssignmentMock2);
		}
		
		[Test(description="Ensure that getActualValues function returns the correct subset array of values based on the parameters passed to the function")]
		public function getActualValuesSubsetTest():void {
			var valueOne:Object = null;
			var valueTwo:Object = new Object();
			var valueThree:Object = new Object();

			mock(potentialAssignmentMock1).method("getValue").noArgs().returns(valueOne).never();
			mock(potentialAssignmentMock2).method("getValue").noArgs().returns(valueTwo).once();
			mock(potentialAssignmentMock3).method("getValue").noArgs().returns(valueThree).once();
			
			//Set the assigned array of assignments
			assignments2.assigned = [potentialAssignmentMock1, potentialAssignmentMock2, potentialAssignmentMock3];
			
			var actualValues:Array = assignments2.getActualValues(1, 3, true);
			
			Assert.assertEquals( valueTwo, actualValues[0] );
			Assert.assertEquals( valueThree, actualValues[1] );
			
			verify(potentialAssignmentMock1);
			verify(potentialAssignmentMock2);
			verify(potentialAssignmentMock3);
		}
		
		//TODO: This test needs to be reexamined to determine how to best check this case
		[Ignore]
		[Test(description="Ensure that getActualValues function correctly handles bad start/stop values")]
		public function getActualValuesBadStartStopTest():void {
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();

			mock(potentialAssignmentMock1).method("getValue").noArgs().returns(valueOne).once();
			mock(potentialAssignmentMock2).method("getValue").noArgs().returns(valueTwo).once();
			
			//Set the assigned array of assignments
			assignments2.assigned = [potentialAssignmentMock1, potentialAssignmentMock2];
			
			var actualValues:Array = assignments2.getActualValues(1, -1, true);
			
			Assert.assertEquals( valueTwo, actualValues[0] );
			
			verify(potentialAssignmentMock1);
			verify(potentialAssignmentMock2);
		}
		
		//TODO: Is there a way to verify that this method is correctly called using the AllMembersSupplier?  It seems the only current way to test this is to set
		//expectations on the parameter signature mock and determine when it gets called and make assertions based on the values it returns.
		[Ignore]
		[Test(description="Ensure that the potentialsForNextUnassigned function returns an array based on the parameter signatures in the unassigned array")]
		public function potentialsForNextUnassignedTest():void {
			assignments2.unassigned [parameterSignatureMock1];
		}
		
		[Test(description="Ensure that the getSupplier function returns an instanc of the AllMembersSupplier if the supplier is null")]
		public function getSupplierNullSupplierTest():void {
			Assert.assertTrue( assignments2.getSupplier(parameterSignatureMock1) is AllMembersSupplier );
		}
		
		//TODO: This test needs to be readded once the getAnnotatedSupplier function is updated
		[Ignore("This test needs to be readded once the getAnnotatedSupplier function is updated")]
		[Test(description="Ensure that the getSupplier function returns the supplier if the supplier is not null")]
		public function getSupplierNonNullSupplierTest():void {
			Assert.assertTrue( assignments2.getSupplier(parameterSignatureMock1) is ParameterSignature );
		}
		
		//TODO: This will need to be updated once the actual function is updated
		[Test(description="Ensure that the getAnnotatedSupplier function returns an instance of IParameterSupplier")]
		public function getAnnotatedSupplierTest():void {
			Assert.assertNull( assignments2.getAnnotatedSupplier(parameterSignatureMock1) );
		}
		
		[Ignore("Until Klass != null from getType()")]
		[Test(description="Ensure that the getConstructorArguments function returns the correct array values")]
		public function getConstructorArgumentsTest():void {
			//Create values for the assigned array
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();

			mock(potentialAssignmentMock1).method("getValue").noArgs().returns(valueOne).once();
			mock(potentialAssignmentMock2).method("getValue").noArgs().returns(valueTwo).once();
			
			//Create the information needed for the constructor
			var parameterTypes:Array = [Object];
		
			mock(testClassMock).getter("klassInfo").returns(klassMock);
			mock(klassMock).getter("constructor").returns(constructorMock);		
			mock(constructorMock).getter("parameterTypes").returns(parameterTypes);				
			
			//Set the assigned array of assignments
			assignments2.assigned = [potentialAssignmentMock1, potentialAssignmentMock2];
			
			var constructorArguments:Array = assignments2.getConstructorArguments(true);
			
			Assert.assertEquals( valueOne, constructorArguments[0] );
			
			verify(potentialAssignmentMock1);
			verify(potentialAssignmentMock2);
		}
		[Ignore("Until Klass != null from getType()")]
		[Test(description="Ensure that the getMethodArguments function returns the correct array values")]
		public function getMethodArgumentsTest():void {
			//Create values for the assigned array
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();
			
			mock(potentialAssignmentMock1).method("getValue").noArgs().returns(valueOne).once();
			mock(potentialAssignmentMock2).method("getValue").noArgs().returns(valueTwo).once();
			
			
			//Create the information needed for the constructor
			var parameterTypes:Array = [Object];
			
			mock(testClassMock).getter("klassInfo").returns(klassMock);
			mock(klassMock).getter("constructor").returns(constructorMock);
			mock(constructorMock).getter("parameterTypes").returns(parameterTypes);
			
			//Set the assigned array of assignments
			assignments2.assigned = [potentialAssignmentMock1, potentialAssignmentMock2];
			
			var methodArguments:Array = assignments2.getMethodArguments(true);
			
			Assert.assertEquals( valueTwo, methodArguments[0] );
			
			verify(potentialAssignmentMock1);
			verify(potentialAssignmentMock2);
		}
		
		[Test(description="Ensure that the getAllArguments function returns the correct array values")]
		public function getAllArgumentsTest():void {
			//Create values for the assigned array
			var valueOne:Object = new Object();
			var valueTwo:Object = new Object();

			mock(potentialAssignmentMock1).method("getValue").noArgs().returns(valueOne).once();
			mock(potentialAssignmentMock2).method("getValue").noArgs().returns(valueTwo).once();
		
			//Set the assigned array of assignments
			assignments2.assigned = [potentialAssignmentMock1, potentialAssignmentMock2];
			
			var allArguments:Array = assignments2.getAllArguments(true);
			
			Assert.assertEquals( valueOne, allArguments[0] );
			Assert.assertEquals( valueTwo, allArguments[1] );
			
			verify(potentialAssignmentMock1);
			verify(potentialAssignmentMock2);
			
		}
		
		//TODO: Will the paraemter for this function be used? If so, another test will need to be written for a null case.
		[Test(description="Ensure that the getArgumentsString function returns an array of description strings")]
		public function getArgumentsStringTest():void {
			var descriptionOne:String = "testDescription";
			var descriptionTwo:String = null;

			mock(potentialAssignmentMock1).method("getDescription").noArgs().returns(descriptionOne).once();
			mock(potentialAssignmentMock2).method("getDescription").noArgs().returns(descriptionTwo).once();
			
			assignments2.assigned = [potentialAssignmentMock1, potentialAssignmentMock2];
			
			var argumentStrings:Array = assignments2.getArgumentStrings(true);
			
			Assert.assertEquals( descriptionOne, argumentStrings[0] );
			Assert.assertEquals( descriptionTwo, argumentStrings[2] );
			
			verify(potentialAssignmentMock1);
			verify(potentialAssignmentMock2);
		}
		
		[Test(description="Ensure that the toString method returns the correct string value")]
		public function toStringTest():void {
			
			mock(testClassMock).method("toString").noArgs().returns("testClassMock").twice();
			var str:String = "              Assignments :\n";
			str += ("                  testClass:" + testClassMock + "\n");
			str += ("                  assigned:" + assigned + "\n");
			str += ("                  unassigned:" + unassigned);
			
			Assert.assertEquals( str, assignments2.toString() );
			verify(testClassMock);
		}
	}
}