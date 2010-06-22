package org.fluint.uiImpersonation.flex {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	import mx.core.Container;
	import mx.core.FlexVersion;
	import mx.managers.FocusManager;
	import mx.managers.SystemManager;
	
	import org.fluint.uiImpersonation.IVisualEnvironmentBuilder;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;

	/**
	 * Builds a visual test environment for Flex projects 
	 * @author mlabriola
	 * 
	 */
	public class FlexEnvironmentBuilder implements IVisualEnvironmentBuilder {
		/**
		 * @private 
		 */
		protected var environment:IVisualTestEnvironment;
		/**
		 * @private 
		 */
		protected var visualDisplayRoot:DisplayObjectContainer;

		/** 
		 * Returns a reference to the single instance of a Canvas
		 * where all visual components will be created during testing.
		 * 
		 * @return A reference to the Canvas that serves as the display environment class.
		 */
		public function buildVisualTestEnvironment():IVisualTestEnvironment {
			
			if ( !environment ) {
				environment = new FlexVisualTestEnvironment();
				
				if ( !visualDisplayRoot ) {
					if ( FlexVersion.CURRENT_VERSION > FlexVersion.VERSION_3_0 ) {
						var flexGlobals:Class = Class(getDefinitionByName("mx.core::FlexGlobals"));
						visualDisplayRoot = flexGlobals.topLevelApplication.systemManager;
					} else {
						var appGlobals:Class = Class(getDefinitionByName("mx.core::ApplicationGlobals"));
						visualDisplayRoot = appGlobals.application.systemManager;
					}
				}
				
				if ( visualDisplayRoot && ( environment is DisplayObject ) ) {
					visualDisplayRoot.addChild( environment as DisplayObject );
				}
				
				//If the SystemManager tries to remove a child bridge from the instance, from say a SWFLoader,
				//and there isn't a FocusManager, the SystemManager will throw an error.  To circumvent this,
				//we'll give the instance a valid FocusManager.
				//We need to be sure that the FocusManager is created *AFTER* adding the instance to the
				//SystemManager, because the FocusManager uses the instance's SystemManager property
				//during construction.
				if ( environment is Container ) {
					if ( !Container( environment ).focusManager ) {
						Container( environment ).focusManager = new FocusManager( Container( environment ) );
					}
				}
			}
			
			return environment;
		}
		
		/**
		 * Constructor 
		 * @param visualDisplayRoot
		 * 
		 */
		public function FlexEnvironmentBuilder( visualDisplayRoot:DisplayObjectContainer ) {
			this.visualDisplayRoot = visualDisplayRoot;			
		}
	}
}