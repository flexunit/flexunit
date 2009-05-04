package org.flexunit.experimental.runners.statements {
	import org.flexunit.experimental.theories.IPotentialAssignment;
	import org.flexunit.experimental.theories.internals.Assignments;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.runners.model.MultipleFailureException;
	import org.flexunit.internals.runners.statements.AsyncStatementBase;
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;
	import org.flexunit.utils.ClassNameUtil;

	public class AssignmentSequencer extends AsyncStatementBase implements IAsyncStatement {
		protected var potential:Array;
		protected var parameterAssignment:Assignments;
		protected var counter:int = 0;
		protected var errors:Array;
		protected var testClass:Class;
		protected var anchor:TheoryAnchor;
		protected var frameworkMethod:FrameworkMethod;

		public function AssignmentSequencer( parameterAssignment:Assignments, frameworkMethod:FrameworkMethod, testClass:Class, anchor:TheoryAnchor ) {
			super();
			this.parameterAssignment = parameterAssignment;
			this.testClass = testClass;
			this.anchor = anchor;
			this.frameworkMethod = frameworkMethod;
			this.errors = new Array();

			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleChildExecuteComplete );
		}

		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;

			if (!parameterAssignment.complete ) {
				//incomplete
				potential = parameterAssignment.potentialsForNextUnassigned();
				handleChildExecuteComplete( null );
			} else {
				//complete
				runWithCompleteAssignment( parameterAssignment );
			}
		}
		
		public function handleChildExecuteComplete( result:ChildResult ):void {
			var source:IPotentialAssignment;

			if ( result && result.error && !( result.error is AssumptionViolatedException ) ) {
				errors.push( result.error );
			}
			
			if ( errors.length ) {
				//we received an error that was not an AssumptionViolation, we need to bail out of this case
				sendComplete();
				return;
			}
//i think we need to stop here on this error
			if ( ( potential ) && ( counter < potential.length ) ) {
				source = potential[ counter ] as IPotentialAssignment;
				counter++;
				var statement:AssignmentSequencer = new AssignmentSequencer( parameterAssignment.assignNext( source ), frameworkMethod, testClass, anchor );
				statement.evaluate( myToken );
			} else {
				sendComplete();
			}
		}

		override protected function sendComplete( error:Error=null ):void {
			var sendError:Error;

			if ( error ) {
				errors.push( error );
			}

			if (errors.length == 1)
				sendError = errors[ 0 ];
			else if ( errors.length > 1 ) {
				sendError = new MultipleFailureException(errors);
			}

			super.sendComplete( sendError );
		}

		protected function runWithCompleteAssignment( complete:Assignments ):void {
			//trace( "Complete" );
 			var runner:TheoryBlockRunner = new TheoryBlockRunner( testClass, anchor, complete );
			runner.getMethodBlock( frameworkMethod ).evaluate( myToken );
		}
	}
}