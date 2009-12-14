/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
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
 **/ 
package org.fluint.uiImpersonation {
	import flash.display.Sprite;
	
	import org.fluint.uiImpersonation.actionScript.ActionScriptEnvironmentBuilder;

	/** 
	 * TestEnvironment is a singleton class that allows tests to have 
	 * visual components. 
	 * 
	 * The TestCase has a series of fascade methods such as addChild() 
	 * and removeChild() which actually call those methods on this class.
	 **/
	public class VisualTestEnvironmentBuilder implements IVisualEnvironmentBuilder {
        /**
         * @private
         */
		protected static var instance:VisualTestEnvironmentBuilder; 
		protected var builder:IVisualEnvironmentBuilder;
		protected var visualDisplayRoot:Sprite;

		/** 
		 * Returns a reference to the single instance of this class 
		 * where all visual components will be created during testing.
		 * 
		 * @return A reference to the TestEnvironment class.
		 */
		public static function getInstance( visualDisplayRoot:Sprite=null ):VisualTestEnvironmentBuilder {
			if ( !instance ) {
				instance = new VisualTestEnvironmentBuilder( visualDisplayRoot );
			}
			
			return instance;
		}

		public function buildVisualTestEnvironment():IVisualTestEnvironment {
			return builder.buildVisualTestEnvironment();
		}

		public function VisualTestEnvironmentBuilder( visualDisplayRoot:Sprite ) {
			this.visualDisplayRoot = visualDisplayRoot;

			CONFIG::useFlexClasses {
				import org.fluint.uiImpersonation.flex.FlexEnvironmentBuilder;
				builder = new FlexEnvironmentBuilder( visualDisplayRoot );
			}
			
			if ( !builder ) {
				builder = new ActionScriptEnvironmentBuilder( visualDisplayRoot );
			}
		}
	}
}







