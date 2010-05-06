package org.flexunit.internals.builders
{
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import org.flexunit.runner.IRunner;
	import org.flexunit.runners.model.TestClass;

	public class FlexUnit4QualifiedBuilder extends FlexUnit4Builder
	{
		
		public static const TEST:String = "Test";
		
		override public function canHandleClass(testClass:Class):Boolean {
			var klassInfo:Klass = new Klass( testClass );
			
			
			//var methods:Array = new Array(klassInfo.methods);
			var methods:Array = new Array();
			methods = klassInfo.methods;

			var arrayLen:int = methods.length;
			
			for(var i:int = 0; i < arrayLen; i++) {
				if( (methods[i] as Method).hasMetaData(TEST) )
					return true;
			}
			return false;
			
		}
	}
}