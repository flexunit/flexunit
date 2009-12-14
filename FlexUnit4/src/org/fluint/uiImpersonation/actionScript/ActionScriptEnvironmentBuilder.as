package org.fluint.uiImpersonation.actionScript {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import org.fluint.uiImpersonation.IVisualEnvironmentBuilder;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	public class ActionScriptEnvironmentBuilder implements IVisualEnvironmentBuilder {
		protected var stage:Sprite;
		protected var environment:IVisualTestEnvironment;
		
		public function buildVisualTestEnvironment():IVisualTestEnvironment {
			if ( !environment ) {
				environment = new ActionScriptVisualTestEnvironment();
			}
			
			if ( stage && ( environment is DisplayObject ) ) {
				stage.addChild( environment as DisplayObject );
			}

			return environment;			
		}
		
		public function ActionScriptEnvironmentBuilder( stage:Sprite ):void {
			this.stage = stage;
		}
	}
}