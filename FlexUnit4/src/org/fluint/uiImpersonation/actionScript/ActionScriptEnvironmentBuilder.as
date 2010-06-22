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
		protected var environment:IVisualTestEnvironment;
	
		/** 
		 * Returns a reference to the single instance of the ActionScriptVisualTestEnvironment
		 * where all visual components will be created during testing.
		 * 
		 * @return A reference to the ActionScriptVisualTestEnvironment class.
		 */
		public function buildVisualTestEnvironment():IVisualTestEnvironment {
			if ( !environment ) {
				environment = new ActionScriptVisualTestEnvironment();
			}
			
			if ( visualDisplayRoot && ( environment is DisplayObject ) ) {
				visualDisplayRoot.addChild( environment as DisplayObject );
			}

			return environment;			
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