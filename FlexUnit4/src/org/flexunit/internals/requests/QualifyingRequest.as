package org.flexunit.internals.requests {
	import org.flexunit.internals.builders.OnlyRecognizedTestClassBuilder;
	import org.flexunit.runner.Request;
	
	public class QualifyingRequest extends Request {
		public function QualifyingRequest() {
			super();
		}

		public static function classes( ...argumentsArray ):Request {
			var allQualifiedBuilders:OnlyRecognizedTestClassBuilder = new OnlyRecognizedTestClassBuilder(true);
			var arrayLen:int = argumentsArray.length;
			var modifiedArray:Array = new Array();
			
			//Loop through array of classes and determine
			//if the classes are valid test case classes
			//If they are not, then remove them from the array			
			for(var i:int = 0; i<arrayLen; i++) {
				//if allqualifiedbuilders.qualify returns true, we've found
				//a builder so add the class to the modified array
				if ( ( allQualifiedBuilders.qualify(argumentsArray[i] ) ) )
					modifiedArray.push(argumentsArray[i]);				
			}
			
			//Take Arguments Array length minus the modified Array length
			//this will give us the number of files skipped
			//To Do: Somehow display this variable to the user
			//var totalFilesSkipped:int = arrayLen - modifiedArray.length;
			
			//Build out builders for every qualified testcase in the array
			return Request.classes.apply( null, modifiedArray );  
		}
	}
}