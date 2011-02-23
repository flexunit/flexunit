/**
 * Copyright (c) 2010 Digital Primates
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
package org.flexunit.internals.builders
{
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import org.flexunit.constants.AnnotationConstants;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.TestClass;

	/**
	 *
	 * This class is used as an alternate builder for FlexUnit 4. Normally FlexUnit4 is the default
	 * builder, so it accepts all classes. In this class we determine if it is actually a FlexUnit 4
	 * test
	 *  
	 * @author mlabriola
	 * 
	 */
	public class FlexUnit4QualifiedBuilder extends FlexUnit4Builder {
		/**
		 * @inheritDoc
		 */
		override public function canHandleClass(testClass:Class):Boolean {
			var klassInfo:Klass = new Klass( testClass );
			var found:Boolean = false;
			
			var methods:Array = new Array();
			methods = klassInfo.methods;

			var arrayLen:int = methods.length;
			
			for(var i:int = 0; i < arrayLen; i++) {
				if ( (methods[i] as Method).hasMetaData( AnnotationConstants.TEST ) ) {
					found = true;
					break;
				}
			}

			return found;
		}
	}
}