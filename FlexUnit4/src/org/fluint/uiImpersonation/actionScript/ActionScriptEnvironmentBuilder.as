package org.fluint.uiImpersonation.actionScript {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import org.fluint.uiImpersonation.IVisualEnvironmentBuilder;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	public class ActionScriptEnvironmentBuilder implements IVisualEnvironmentBuilder {
		protected var visualDisplayRoot:DisplayObjectContainer;
		protected var environment:IVisualTestEnvironment;
		
		public function buildVisualTestEnvironment():IVisualTestEnvironment {
			if ( !environment ) {
				environment = new ActionScriptVisualTestEnvironment();
			}
			
			if ( visualDisplayRoot && ( environment is DisplayObject ) ) {
				visualDisplayRoot.addChild( environment as DisplayObject );
			}

			return environment;			
		}
		
		public function ActionScriptEnvironmentBuilder( visualDisplayRoot:DisplayObjectContainer ):void {
			this.visualDisplayRoot = visualDisplayRoot;
		}
	}
}