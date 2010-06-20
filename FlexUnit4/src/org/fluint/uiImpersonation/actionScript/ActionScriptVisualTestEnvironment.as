package org.fluint.uiImpersonation.actionScript {
	import flash.display.Sprite;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	/**
	 * A visual test environment for ActionScript projects
	 * @author mlabriola
	 * 
	 */
	public class ActionScriptVisualTestEnvironment extends Sprite implements IVisualTestEnvironment {
		/**
		 * Removes all children from visual test environment 
		 * 
		 */		
		public function removeAllChildren():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
		/**
		 * Constructor 
		 * 
		 */
		public function ActionScriptVisualTestEnvironment() {
		}
	}
}