package tests.flex.lang.reflect.method {
	import flash.utils.describeType;
	
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class MethodWithValidData {
		[Test]
		public function shouldReturnName():void {
			var xml:XML = <method name="testMethod" declaredBy="tests::SomeClass" returnType="void"/>;
			
			var method:Method = new Method( xml, false );
			assertEquals( "testMethod", method.name );
		}
		
		[Test]
		public function shouldReturnFalseIfInstance():void {
			var xml:XML = <method name="testMethod" declaredBy="tests::SomeClass" returnType="void"/>;
			
			var method:Method = new Method( xml, false );
			assertFalse( method.isStatic );
		}		

		[Test]
		public function shouldReturnTrueIfStatic():void {
			var xml:XML = <method name="testMethod" declaredBy="tests::SomeClass" returnType="void"/>;
			
			var method:Method = new Method( xml, true );
			assertTrue( method.isStatic );
		}		

		[Test]
		public function shouldReturnProvidedXML():void {
			var xml:XML = <method name="testMethod" declaredBy="tests::SomeClass" returnType="void"/>;
			
			var method:Method = new Method( xml, false );
			assertEquals( xml, method.methodXML );
		}
		
		[Test]
		public function shouldReturnStringDeclaringClass():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="String"/>;
			
			var method:Method = new Method( xml, false );
			assertEquals( String, method.declaringClass );
		}			

		[Test]
		public function shouldReturnNullAsReturnType():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="void"/>;
			
			var method:Method = new Method( xml, false );
			assertNull( method.returnType );
		}			

		[Test]
		public function shouldReturnBooleanAsReturnType():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Boolean"/>;
			
			var method:Method = new Method( xml, false );
			assertEquals( Boolean, method.returnType );
		}			

		[Test]
		public function shouldReturnObjectAsReturnType():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object"/>;
			
			var method:Method = new Method( xml, false );
			assertEquals( Object, method.returnType );
		}			

		[Test]
		public function shouldReturnOneParamOfTypeString():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<parameter index="1" type="String" optional="false"/>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertNotNull( method.parameterTypes );
			assertEquals( 1, method.parameterTypes.length );
			assertEquals( String, method.parameterTypes[ 0 ] );
		}			

		[Test]
		public function shouldReturnTwoParamsBooleanAndInt():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<parameter index="1" type="Boolean" optional="false"/>
							<parameter index="2" type="int" optional="false"/>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertNotNull( method.parameterTypes );
			assertEquals( 2, method.parameterTypes.length );
			assertEquals( Boolean, method.parameterTypes[ 0 ] );
			assertEquals( int, method.parameterTypes[ 1 ] );
		}

		[Test]
		public function shouldReturnNoMetaData():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object"/>;
			
			var method:Method = new Method( xml, false );
			assertNotNull( method.metadata );
			assertEquals( 0, method.metadata.length );
		}

		[Test]
		public function shouldReturnTwoMetaDataAnnotations():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<metadata name="annotationName1"/>
							<metadata name="annotationName2"/>
						  </method>;

			var method:Method = new Method( xml, false );
			assertEquals( 2, method.metadata.length );
			assertTrue( method.metadata[ 0 ] is MetaDataAnnotation );
			assertTrue( method.metadata[ 1 ] is MetaDataAnnotation );
			
			//Checking that the order is correct, annotation functionality is tested elsewhere
			assertEquals( "annotationName1", ( method.metadata[ 0 ] as MetaDataAnnotation ).name );
			assertEquals( "annotationName2", ( method.metadata[ 1 ] as MetaDataAnnotation ).name );
		}		

		[Test]
		public function shouldFindValidMetaData():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<metadata name="annotationName1"/>
							<metadata name="annotationName2"/>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertTrue( method.hasMetaData( "annotationName2" ) );
		}		

		[Test]
		public function shouldNotFindInvalidMetaData():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<metadata name="annotationName1"/>
							<metadata name="annotationName2"/>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertFalse( method.hasMetaData( "annotationName3" ) );
		}		
		
		[Test]
		public function shouldReturnValidMetaData():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<metadata name="annotationName1"/>
							<metadata name="annotationName2"/>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertEquals( "annotationName2", method.getMetaData( "annotationName2" ).name );
		}		
		
		[Test]
		public function shouldReturnNullForInvalidMetaData():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<metadata name="annotationName1"/>
							<metadata name="annotationName2"/>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertNull( method.getMetaData( "annotationName3" ) );
		}		

		[Test]
		public function shouldReturnStringForElementType():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Array">
							<metadata name="ArrayElementType">
								<arg key="" value="String"/> 				
							</metadata>
						  </method>;

			var method:Method = new Method( xml, false );
			assertEquals( String, method.elementType );
		}
		
		[Test]
		public function shouldReturnNullAsFieldIsNotAnArray():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Object">
							<metadata name="ArrayElementType">
								<arg key="" value="String"/> 				
							</metadata>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertNull( method.elementType );
		}
		
		[Test]
		public function shouldReturnNullAsTypeIsNotFound():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Array">
							<metadata name="ArrayElementType">
								<arg key="" value="monkey"/> 				
							</metadata>
						  </method>;
			
			var method:Method = new Method( xml, false );
			assertNull( method.elementType );
		}
		
		[Test]
		public function shouldReturnNullAsNoElementType():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Array"/>;
			
			var method:Method = new Method( xml, false );
			assertNull( method.elementType );
		}		

		[Test]
		public function shouldInvokeCharAtInstanceMethod():void {
			var myString:String = "123";

			var xml:XML = <method name="charAt" declaredBy="String" returnType="String"/>;

			var method:Method = new Method( xml, false );
			assertEquals( "1", method.invoke( myString, 0 ) );
		}		

		[Test]
		public function shouldApplyCharAtInstanceMethod():void {
			var myString:String = "123";
			
			var xml:XML = <method name="charAt" declaredBy="String" returnType="String"/>;
			
			var method:Method = new Method( xml, false );
			assertEquals( "2", method.apply( myString, [1] ) );
		}		
		
		[Test]
		public function shouldInvokeFromCharCodeStaticMethod():void {
			var xml:XML = <method name="fromCharCode" declaredBy="String" returnType="String"/>;
			
			var method:Method = new Method( xml, true );
			assertEquals( "A", method.invoke( null, 65 ) );
		}		

		[Test]
		public function shouldApplyFromCharCodeStaticMethod():void {
			var xml:XML = <method name="fromCharCode" declaredBy="String" returnType="String"/>;

			var method:Method = new Method( xml, true );
			assertEquals( "ABC", method.apply( null, [65,66,67] ) );
		}
		
		[Test]
		public function shouldNotBeEqual():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Array">
							<metadata name="ArrayElementType">
								<arg key="" value="monkey"/> 				
							</metadata>
							<metadata name="annotationName2"/>
							<parameter index="1" type="Boolean" optional="false"/>
							<parameter index="2" type="int" optional="false"/>							
						  </method>;
			
			var method1:Method = new Method( xml, false );
			var method2:Method = new Method( xml.copy(), false );
			
			assertTrue( method1.equals( method2 ) );
		}

		[Test]
		public function shouldNotBeEqualBecauseOfName():void {
			var xml1:XML = <method name="testMethod1" declaredBy="String" returnType="String"/>;
			var xml2:XML = <method name="testMethod2" declaredBy="String" returnType="String"/>;
			
			var method1:Method = new Method( xml1, false );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}
		
		[Test]
		public function shouldNotBeEqualBecauseOfReturnType():void {
			var xml1:XML = <method name="testMethod" declaredBy="String" returnType="String"/>;
			var xml2:XML = <method name="testMethod" declaredBy="String" returnType="int"/>;
			
			var method1:Method = new Method( xml1, false );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}
		
		[Test]
		public function shouldNotBeEqualBecauseOfStatic():void {
			var xml1:XML = <method name="testMethod" declaredBy="String" returnType="String"/>;
			var xml2:XML = <method name="testMethod" declaredBy="String" returnType="String"/>;
			
			var method1:Method = new Method( xml1, true );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}		
		
		[Test]
		public function shouldNotBeEqualBecauseOfDeclaredBy():void {
			var xml1:XML = <method name="testMethod" declaredBy="String" returnType="String"/>;
			var xml2:XML = <method name="testMethod" declaredBy="Number" returnType="String"/>;
			
			var method1:Method = new Method( xml1, false );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}			

		[Test]
		public function shouldNotBeEqualBecauseOfParamLength():void {
			var xml1:XML = <method name="testMethod" declaredBy="String" returnType="String">
							  <parameter index="1" type="Boolean" optional="false"/>
							  <parameter index="2" type="int" optional="false"/>							
						  </method>;						  			
			var xml2:XML = <method name="testMethod" declaredBy="String" returnType="String"/>;
			
			var method1:Method = new Method( xml1, false );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}
		
		[Test]
		public function shouldNotBeEqualBecauseOfParamTypes():void {
			var xml1:XML = <method name="testMethod" declaredBy="String" returnType="String">
							  <parameter index="1" type="Boolean" optional="false"/>
							  <parameter index="2" type="int" optional="false"/>							
						  </method>;						  			
			var xml2:XML = <method name="testMethod" declaredBy="String" returnType="String">
							  <parameter index="1" type="Boolean" optional="false"/>
							  <parameter index="2" type="Boolean" optional="false"/>							
						  </method>;						  			
			
			var method1:Method = new Method( xml1, false );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}		

		[Test]
		public function shouldNotBeEqualBecauseOfMetaDataLength():void {
			var xml1:XML = <method name="testMethod" declaredBy="String" returnType="Array">
							  <metadata name="ArrayElementType">
								<arg key="" value="monkey"/> 				
							  </metadata>
							  <metadata name="annotationName2"/>
						  </method>;
			var xml2:XML = <method name="testMethod" declaredBy="String" returnType="Array"/>
			
			var method1:Method = new Method( xml1, false );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}			
		
		[Test]
		public function shouldNotBeEqualBecauseOfMetaDataContent():void {
			var xml1:XML = <method name="testMethod" declaredBy="String" returnType="Array">
							  <metadata name="ArrayElementType">
								<arg key="" value="monkey"/> 				
							  </metadata>
							  <metadata name="annotationName1"/>
						  </method>;
			var xml2:XML = <method name="testMethod" declaredBy="String" returnType="Array">
							  <metadata name="ArrayElementType">
								<arg key="" value="monkey"/> 				
							  </metadata>
							  <metadata name="annotationName2"/>
						  </method>;
			
			var method1:Method = new Method( xml1, false );
			var method2:Method = new Method( xml2, false );
			
			assertFalse( method1.equals( method2 ) );
		}
		
		[Test]
		public function shouldCloneSuccessfully():void {
			var xml:XML = <method name="testMethod" declaredBy="String" returnType="Array">
							  <metadata name="ArrayElementType">
								<arg key="" value="monkey"/> 				
							  </metadata>
							  <metadata name="annotationName1"/>
						  </method>;
			
			var method1:Method = new Method( xml, false );
			var method2:Method = method1.clone();
			
			assertTrue( method1.equals( method2 ) );
			assertEquals( method1.methodXML, method2.methodXML );

			var method3:Method = new Method( xml, true );
			var method4:Method = method3.clone();

			assertTrue( method3.equals( method4 ) );
		}	
		
	}
}
