package org.flexunit.experimental.theories.internals.mocks
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.experimental.theories.IParameterSupplier;
	import org.flexunit.experimental.theories.IPotentialAssignment;
	import org.flexunit.experimental.theories.ParameterSignature;
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.runners.model.TestClass;
	
	public class AssignmentsMock extends Assignments
	{
		public var mock:Mock;
		
		override public function get complete():Boolean {
			return mock.complete;
		}
		
		override public function nextUnassigned():ParameterSignature {
			return mock.nextUnassigned();
		}
		
		override public function assignNext(source:IPotentialAssignment):Assignments {
			return mock.assignNext(source);
		}
		
		override public function getActualValues(start:int, stop:int, nullsOk:Boolean):Array {
			return mock.getActualValues(start, stop, nullsOk);
		}
		
		override public function potentialsForNextUnassigned():Array {
			return mock.potentialsForNextUnassigned();
		}
		
		override public function getSupplier(unassigned:ParameterSignature):IParameterSupplier {
			return mock.getSupplier(unassigned);
		}
		
		override public function getAnnotatedSupplier(unassigned:ParameterSignature) : IParameterSupplier {
			return mock.getAnnotatedSupplier(unassigned);
		}
		
		override public function getConstructorArguments(nullsOk:Boolean):Array {
			return mock.getConstructorArguments(nullsOk);
		}
		
		override public function getMethodArguments(nullsOk:Boolean):Array {
			return mock.getMethodArguments(nullsOk);
		}
		
		override public function getAllArguments(nullsOk:Boolean):Array {
			return mock.getAllArguments(nullsOk);
		}
		
		override public function getArgumentStrings(nullsOk:Boolean):Array {
			return mock.getArgumentStrings(nullsOk);
		}
		
		override public function toString():String {
			return mock.twoString();
		}
		
		public function AssignmentsMock(assigned:Array = null, unassigned:Array = null, testClass:TestClass = null)
		{
			mock = new Mock(this);
			
			super(assigned, unassigned, testClass);
		}
	}
}