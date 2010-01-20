package org.fluint.uiImpersonation.actionScript {
	import flash.display.Sprite;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	public class ActionScriptVisualTestEnvironment extends Sprite implements IVisualTestEnvironment {
		public function removeAllChildren():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}

		public function ActionScriptVisualTestEnvironment() {
		}
	}
}