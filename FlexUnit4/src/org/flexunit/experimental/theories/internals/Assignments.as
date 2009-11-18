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
package org.flexunit.experimental.theories.internals {
	import flex.lang.reflect.Constructor;
	import flex.lang.reflect.Method;
	
	import org.flexunit.experimental.theories.IParameterSupplier;
	import org.flexunit.experimental.theories.IPotentialAssignment;
	import org.flexunit.experimental.theories.ParameterSignature;
	import org.flexunit.experimental.theories.internals.error.CouldNotGenerateValueException;
	import org.flexunit.runners.model.TestClass;
	
	/**
	 * The <code>Assignments</code> is responsible for keeping track of assigned and unassigned parameters for a given
	 * configuration of a theory method.
	 */
	public class Assignments {
		/**
		 * An array of <code>IPotentialAssignment</code>s that have been assigned values.
		 */
		public var assigned:Array;
		/**
		 * An array of <code>ParameterSignature</code>s that not been assigned values.
		 */
		public var unassigned:Array;
		/**
		 * The test class that contains the theory.
		 */
		public var testClass:TestClass;
		
		/**
		 * Constructor.
		 * 
		 * @param assigned An array of <code>IPotentialAssignment</code>s that have been assigned values.
		 * @param unassigned An array of <code>ParameterSignature</code>s that not been assigned values.
		 * @param testClass The test class that contains the theory.
		 */
		public function Assignments( assigned:Array, unassigned:Array, testClass:TestClass ) {
			this.assigned = assigned;
			this.unassigned = unassigned;
			this.testClass = testClass;
		}
		
		/** This is perhaps a tad bit more complicated than really needed for AS. The java version really
		 *  needs to worry about multiple method signatures including multiple constructor signatures.
		 *  No such worries here, but the basic flow was kept the same to be relatable and cause...
		 *  who knows what the future could bring.
		 * 
		 * @param method The current theory method.
		 * @param testClass The test class that contains the method.
		 * 
		 * @return an <code>Assignments</code> that contains all unassigned <code>ParameterSignature</code> that need to be assigned
		 * before a theory method test can be run.
		 **/
		public static function allUnassigned( method:Method, testClass:TestClass ):Assignments {
			var signatures:Array;
			var constructor:Constructor = testClass.klassInfo.constructor;

			signatures = ParameterSignature.signaturesByContructor( constructor );
			signatures = signatures.concat( ParameterSignature.signaturesByMethod( method ) );
			//trace( signatures.toString() );
			return new Assignments( new Array(), signatures, testClass );
		}
		
		/**
		 * Returns a Boolean value indicating whether all unassigned values have been assigned.
		 */
		public function get complete():Boolean {
			return unassigned.length == 0;
		}
		
		/**
		 * Returns the next unassigned <code>ParameterSignature</code>.
		 */
		public function nextUnassigned():ParameterSignature {
			return unassigned[ 0 ];
		}
		
		/**
		 * Creates a new <code>Assignments</code> consiting of the assigned array containing the new source and
		 * the the array of still unassigned <code>ParameterSignature</code>s minus the first element which was
		 * just assigned.
		 * 
		 * @param source The new <code>IPotentialAssignment</code> to add.
		 * 
		 * @return an new <code>Assignments</code> with one more assigned parameter and one fewer unassigned parameters.
		 */
		public function assignNext( source:IPotentialAssignment ):Assignments {
			var assigned:Array = assigned.slice();
			assigned.push(source);
	
			return new Assignments(assigned, unassigned.slice(1,unassigned.length), testClass);
		}
		
		/**
		 * Returns an array of values from <code>IPotentialAssignment</code>s ranging from the start poisition to the stop position
		 * in the assigned array.
		 * 
		 * @param start The starting position in the assigned array.
		 * @param stop The ending position in the assigned array.
		 * @param nullsOk A Boolean value indicating whether a null value is acceptable.  If a null values are not ok,
		 * a <code>CouldNotGenerateValueException</code> will be thrown.
		 * 
		 * @return An array of values from <code>IPotentialAssignment</code>s ranging from the start poisition to the stop position
		 * in the assigned array.
		 * 
		 * @throws CouldNotGenerateValueException if a value of null is encountered a nulls are not allowed.
		 */
		public function getActualValues( start:int, stop:int, nullsOk:Boolean ):Array{
			var values:Array = new Array(stop - start); //Object[stop - start];
			for (var i:int= start; i < stop; i++) {
				var value:Object= assigned[i].getValue();
				if (value == null && !nullsOk)
					throw new CouldNotGenerateValueException();
				values[i - start]= value;
			}
			return values;
		}
		
		/**
		 * Retrieves the potential values that the next unassigned <code>ParameterSignature</code> can use.
		 * 
		 * @return an Array consisting of values that can be potentially used by the next 
		 * unassigned <code>ParameterSignature</code>.
		 */
		public function potentialsForNextUnassigned():Array  {
			var unassigned:ParameterSignature = nextUnassigned();
			return getSupplier(unassigned).getValueSources(unassigned);
		}
		
		/**
		 * Retrieves an object that implements <code>IParameterSupplier</code> that can be used to obtain potential values
		 * for the provided <code>ParameterSignature</code>.
		 * 
		 * @param unassigned The parameter signature used to determine the <code>IParameterSupplier</code>.
		 * 
		 * @return an object that implements <code>IParameterSupplier</code> that can be used to get potential values 
		 * for the <code>ParameterSignature</code>.
		 */
		public function getSupplier( unassigned:ParameterSignature ):IParameterSupplier {
			var supplier:IParameterSupplier = getAnnotatedSupplier(unassigned);
			if (supplier != null)
				return supplier;
	
			return new AllMembersSupplier(testClass);
		}
		
		/**
		 * Retrieves an object that implements <code>IParameterSupplier</code> that can be used to obtain potential values
		 * for the provided <code>ParameterSignature</code>.
		 * 
		 * @param unassigned The parameter signature used to determine the <code>IParameterSupplier</code>.
		 * 
		 * @return an object that implements <code>IParameterSupplier</code> that can be used to get potential values 
		 * for the <code>ParameterSignature</code>.  If no annotated suppliet can be found for the <code>ParameterSignature</code>,
		 * a value of null is returned.
		 */
		public function getAnnotatedSupplier( unassigned:ParameterSignature ):IParameterSupplier {
/* 			var supplier:Boolean = unassigned.findDeepAnnotation( "ParametersSuppliedBy" );
			if ( supplier == null)
 				return null;
 */
			//fix me 	return annotation.value().newInstance();
			return null;
		}
		
		/**
		 * Retrieves an array of constructor arguments from the assigned array.
		 * 
		 * @param nullsOk A Boolean value indicating whether null values are acceptable as an argument.
		 * 
		 * @return an array of constructor arguments from the assigned array.
		 */
		public function getConstructorArguments( nullsOk:Boolean ):Array {
			return getActualValues(0, getConstructorParameterCount(), nullsOk);
		}
		
		/**
		 * Retrieves an array of method arguments from the assigned array.
		 * 
		 * @param nullsOk A Boolean value indicating whether null values are acceptable as an argument.
		 * 
		 * @return an array of method arguments from the assigned array.
		 */
		public function getMethodArguments( nullsOk:Boolean ):Array {
			return getActualValues(getConstructorParameterCount(),assigned.length, nullsOk);
		}
		
		/**
		 * Retrieves an array of all arguments from the assigned array.
		 * 
		 * @param nullsOk A Boolean value indicating whether null values are acceptable as an argument.
		 * 
		 * @return an array of all arguments from the assigned array.
		 */
		public function getAllArguments( nullsOk:Boolean ):Array {
			return getActualValues(0, assigned.length, nullsOk);
		}
		
		/**
		 * Determines the number of parameters in the constructor of the test class.
		 * 
		 * @return the number of parameters in the constructor of the test class.
		 */
		private function getConstructorParameterCount():int {
			var constructor:Constructor = testClass.klassInfo.constructor;
			var signatures:Array = ParameterSignature.signaturesByContructor( constructor );
			var constructorParameterCount:int = signatures.length;
			return constructorParameterCount;
		}
		
		/**
		 * Returns an array of descriptions for all currently assigned <code>IPotentialAssignment</code>s.
		 * 
		 * @param nullsOk A Boolean that indicates whether null values will be accepted.
		 * 
		 * @return an array of descriptions for all currently assigned <code>IPotentialAssignment</code>s.
		 */
		public function getArgumentStrings( nullsOk:Boolean ):Array {
			var values:Array = new Array( assigned.length );
			for (var i:int = 0; i < values.length; i++) {
				values[i]= assigned[ i ].getDescription();
			}
			return values;
		}
		
		/**
		 * Returns a string containing the name of the test class, the assigned parameters, and the 
		 * unassigned parameters.
		 */
		public function toString():String {
			var str:String = "              Assignments :\n";
			
			str += ("                  testClass:" + testClass + "\n");
			str += ("                  assigned:" + assigned + "\n");
			str += ("                  unassigned:" + unassigned);

			return str; 		
		}
 	}
}