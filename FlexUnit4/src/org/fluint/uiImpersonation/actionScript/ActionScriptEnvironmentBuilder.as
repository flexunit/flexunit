/**
 * Copyright (c) 2010 Digital Primates IT Consulting Group
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

package org.fluint.uiImpersonation.actionScript {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import org.fluint.uiImpersonation.IVisualEnvironmentBuilder;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	/**
	 * Builds a visual test environment for ActionScript only projects 
	 * @author mlabriola
	 * 
	 */
	public class ActionScriptEnvironmentBuilder implements IVisualEnvironmentBuilder {
		/**
		 * @private 
		 */
		protected var visualDisplayRoot:DisplayObjectContainer;
		/**
		 * @private
		 */
		protected var environmentProxy:IVisualTestEnvironment;
	
		/** 
		 * Returns a reference to the single instance of the ActionScriptVisualTestEnvironment
		 * where all visual components will be created during testing.
		 * 
		 * @return A reference to the ActionScriptVisualTestEnvironment class.
		 */
		public function buildVisualTestEnvironment():IVisualTestEnvironment {
			if ( !environmentProxy ) {
				environmentProxy = new ActionScriptVisualTestEnvironment();
			}
			
			if ( visualDisplayRoot && ( environmentProxy.testEnvironment is DisplayObject ) ) {
				visualDisplayRoot.addChild( environmentProxy.testEnvironment );
			}

			return environmentProxy;			
		}
		
		/**
		 * Constructor 
		 * @param visualDisplayRoot
		 * 
		 */
		public function ActionScriptEnvironmentBuilder( visualDisplayRoot:DisplayObjectContainer ):void {
			this.visualDisplayRoot = visualDisplayRoot;
		}
	}
}