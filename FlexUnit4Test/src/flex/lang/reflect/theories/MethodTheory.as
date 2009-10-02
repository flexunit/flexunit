package flex.lang.reflect.theories
{
	import flex.lang.reflect.Method;
	import flex.lang.reflect.cases.MethodCase;
	
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	
	[RunWith("org.flexunit.experimental.theories.Theories")]
	public class MethodTheory
	{
		private var method:Method;
		
		[DataPoints]
		[ArrayElementType("flex.lang.reflect.Method")]
		public static function createMethod():Array {
			var ar:Array = new Array();
 			ar.push( new Method( new XML() ) );
			return ar;			
		}
		
		private static function buildMethodNameArray():Array {
			var ar:Array = new Array();
			ar.push("myTestMethod");
			ar.push("My Test Method");
			ar.push("M! TEst-M@tho#");
			ar.push("M! TEst-M@tho#M! TEst-M@tho#M! TEst-M@tho#M! TEst-M@tho#M! TEst-M@tho#M! TEst-M@tho#M! TEst-M@tho#");
			ar.push("1234");
			return ar;
		}
		
		private static function buildMetadataArray():Array {
			var ar:Array = new Array();
			ar.push( "<metadata name='Test'>"+
						"<arg key='description' value='my description'/>" +
					"</metadata>" );
					
			return ar;
		}
		
		private static function buildDeclaringClassesArray():Array {
			var ar:Array = new Array();
			ar.push( "flex.lang.reflect.cases.MethodCase" );
			return ar;
		}
		
		[DataPoints]
		[ArrayElementType("Object")]
		public static function createMethodXML():Array {
			var ar:Array = new Array();
			var xmlString:String;
			var arrayObj:Object;
			
			var methodNames:Array = buildMethodNameArray();
			var declaringClasses:Array = buildDeclaringClassesArray();
			var metadata:Array = buildMetadataArray();
			
			for(var i:uint; i < methodNames.length; i++  ) {
				xmlString = "<method name='" + methodNames[i] + "' declaredBy='" + declaringClasses[i] + "'>" + 
								metadata[i] +
							"</method>";
				arrayObj = new Object();
				arrayObj.methodXML = new XML( xmlString );
 				arrayObj.expectedName = methodNames[i];
 				arrayObj.declaringClass = declaringClasses[i];
 				arrayObj.metadata = XMLList(metadata[i]);
 				ar.push( arrayObj );
			}
			
			return ar;			
		}
		
		[Theory(description="ensure method name gets set properly when Method is initialized")]
		public function check_initialize_methodName( obj:Object ):void {
			method = new Method( obj.methodXML );
			Assert.assertEquals( obj.expectedName, method.name );
		}
		
		public function MethodTheory( method:Method ) {
			this.method = method;
		}

	}
}