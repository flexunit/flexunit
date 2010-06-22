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