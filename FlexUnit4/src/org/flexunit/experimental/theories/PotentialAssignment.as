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
package org.flexunit.experimental.theories {
	
	/**
	 * A <code>PotentialAssignment</code> stores information for a particular value 
	 * that is assigned to a parameter in a theory method.
	 */
	public class PotentialAssignment implements IPotentialAssignment {
		/**
		 * The value that can be applied to a particular parameter.
		 */
		public var value:Object;
		/**
		 * The name of the variable that is providing the potential value.
		 */
		public var name:String;
		
		/**
		 * Creates a <code>PotentialAssignment</code> for a given name and value.
		 * 
		 * @param name The name of the variable that is providing the potential value.
		 * @param value The value that can be applied to a particular parameter.
		 * 
		 * @return a <code>PotentialAssignment</code>.
		 */
		public static function forValue( name:String, value:Object ):PotentialAssignment {
			return new PotentialAssignment( name, value );
		}
		
		/**
		 * Constructor.
		 * 
		 * @param name The name of the variable that is providing the potential value.
		 * @param value The value that can be applied to a particular parameter.
		 */
		public function PotentialAssignment( name:String, value:Object ) {
			this.name = name;
			this.value = value;
		}
		
		/**
		 * Returns the value of the <code>PotentialAssignment</code>.
		 */
		public function getValue():Object {
			return value;
		}
		
		/**
		 * Returns the name of the variable associated with the <code>PotentialAssignment</code>.
		 */
		public function getDescription():String {
			return name;
		}
		
		/**
		 * Returns a string that includes the name of the parameter the potential assignment is associated with
		 * as well as the value being assigned to the parameter.
		 */
		public function toString():String {
			return name + ' ' + "[" + String( value ) + "]";
		}
	}
}