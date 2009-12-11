/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
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
	
	/**
	 * The <code>AssignmentSequencer</code> is responsible for the sequencing of parameters to be provided 
	 * to a particular theory method test.  It determines what potential parameters need to be provided to the 
	 * parameters in the theory test method.<br/>
	 * 
	 * Based on the number of parameters in the theory method test, additional <code>AssignmentSequencer</code>s will 
	 * be created.  If there are still parameters that need to be assigned a value and there are still potential values 
	 * to assign to those parameters, assign an unused value to the next parameter and create a new 
	 * <code>AssignmentSequencer</code>, determining if all parameters have then been assigned a value.  Once all of the 
	 * parameters in the theory method test have been assigned, that theory method will be run with that configuration.
	 * All permutations of potential parameters will be provided to the theory method.
	 */
	public class AssignmentSequencer extends AsyncStatementBase implements IAsyncStatement {
		
		/**
		 * @private
		 */
		protected var potential:Array;
		/**
		 * @private
		 */
		protected var parameterAssignment:Assignments;
		/**
		 * @private
		 */
		protected var counter:int = 0;
		/**
		 * @private
		 */
		protected var errors:Array;
		/**
		 * @private
		 */
		protected var testClass:Class;
		/**
		 * @private
		 */
		protected var anchor:TheoryAnchor;
		/**
		 * @private
		 */
		protected var frameworkMethod:FrameworkMethod;
		
		/**
		 * Constructor.
		 * 
		 * @param parameterAssignment The current parameter assignments for a theory method test.
		 * @param frameworkMethod The theory method that is being tested.
		 * @param testClass The test class that contains the theory method.
		 * @param anchor The anchor for the theory method.
		 */
		public function AssignmentSequencer( parameterAssignment:Assignments, frameworkMethod:FrameworkMethod, testClass:Class, anchor:TheoryAnchor ) {
			super();
			this.parameterAssignment = parameterAssignment;
			this.testClass = testClass;
			this.anchor = anchor;
			this.frameworkMethod = frameworkMethod;
			this.errors = new Array();
			
			//Create a new token that will alert this class when the provided statement has completed
			myToken = new AsyncTestToken( ClassNameUtil.getLoggerFriendlyClassName( this ) );
			myToken.addNotificationMethod( handleChildExecuteComplete );
		}
		
		/**
		 * Determines if all parameters have been assigned for a particular configuration of a theory method.  If they have 
		 * all been assigned, run the theory with the particular parameter configuration.  If all parameter values have not 
		 * been assinged, determine what parameters can be provided to the next unassigned parameter.
		 * 
		 * @param parentToken The token to be notified when the theory method has finished running for a particluar permutation
		 * of parameters.
		 */
		public function evaluate( parentToken:AsyncTestToken ):void {
			this.parentToken = parentToken;
			
			//Determine if all parameters for a theory have been assigned a value
			if (!parameterAssignment.complete ) {
				//incomplete, determine what parameters can be supplied to the next unassigned parameter
				potential = parameterAssignment.potentialsForNextUnassigned();
				handleChildExecuteComplete( null );
			} else {
				//complete, run the theory with the provided parameter configuration
				runWithCompleteAssignment( parameterAssignment );
			}
		}
		
		/**
		 * Determine if any errors were encountered if the theory method test executed.  If the error was not an
		 * <code>AssumptionViolatedException</code>, add it to the array of encountered errors and stop running the theory test.
		 * 
		 * If there are still parameters that need to be assigned a value and there are still potential values to assign to 
		 * those parameters, assign an unused value to the next parameter and create a new <code>AssignmentSequencer</code>, 
		 * determining if all parameters have then been assigned a value.
		 * 
		 * If there are no furuther potential values to assign a parameter or all values have already been assigned to a parameter,
		 * this <code>AssignmentSequencer</code> has finished its duty to sequence parameters.
		 * 
		 * @param result A <code>ChildResult</code> that contains potential errors encountered during the theory's execution.
		 */
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
				//Obtain a value that has yet to be assigned to a parameter
				source = potential[ counter ] as IPotentialAssignment;
				counter++;
				var statement:AssignmentSequencer = new AssignmentSequencer( parameterAssignment.assignNext( source ), frameworkMethod, testClass, anchor );
				statement.evaluate( myToken );
			} else {
				sendComplete();
			}
		}
		
		/**
		 * Reports to the parentToken that the current configuration of parameter assignments have finished running in the theory
		 * method test and determines if any error were encountered during execution of that test.
		 * 
		 * @param error A potential error that was encountered during a configuration of the theory meethod.
		 */
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
		
		/**
		 * Runs the theory for the <code>complete</code> set of assigned parameters.
		 * 
		 * @param complete Contains a permutation of current assigned parameter / value pairs to be supplied to the 
		 * theory method test for this particular configuration.
		 */
		protected function runWithCompleteAssignment( complete:Assignments ):void {
			//trace( "Complete" );
 			var runner:TheoryBlockRunner = new TheoryBlockRunner( testClass, anchor, complete );
			runner.getMethodBlock( frameworkMethod ).evaluate( myToken );
		}
	}
}