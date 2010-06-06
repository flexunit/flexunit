package org.flexunit.runners.model.cases
{
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.mocks.KlassMock;
	import flex.lang.reflect.mocks.MethodMock;
	
	import org.flexunit.Assert;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.token.mocks.AsyncTestTokenMock;

	public class FrameworkMethodCase
	{
		//TODO: Ensure that the tests and this test case are being implemented correctly. Also, it appears that asyncComplete function
		//is never called in the FrameworkMethod class.

		private static function convertToMetaDataAnnotations( metaXML:XMLList ):Array {
			var ar:Array = new Array();
			for ( var i:int=0; i<metaXML.length(); i++ )  {
				ar.push( new MetaDataAnnotation( metaXML[ i ] ) );
			}
			
			return ar;
		} 

		protected var frameworkMethod:FrameworkMethod;
		protected var methodMock:MethodMock;
		
		[Before(description="Create an instance of the FrameworkMethod class")]
		public function createFrameworkMethod():void {
			methodMock = new MethodMock();
			frameworkMethod = new FrameworkMethod(methodMock);
		}
		
		[After(description="Remove the reference to the FrameworkMethod class")]
		public function destroyFrameworkMethod():void {
			frameworkMethod = null;
			methodMock = null;
		}
		
		[Test(description="Ensure that getMethod correctly returns the proper value")]
		public function getMethodTest():void {
			Assert.assertEquals(methodMock, frameworkMethod.method);
		}
		
		[Test(description="Ensure that getName correctly returns the proper value")]
		public function getNameTest():void {
			var testName:String = "testName";
			methodMock.mock.property("name").returns(testName);
			
			Assert.assertEquals(testName, frameworkMethod.name);
		}
		
		[Test(description="Ensure that getMetadata correctly returns the proper value")]
		public function getMetadataTest():void {
			var sampleMetaDataArray:Array = new Array();
			methodMock.mock.property("metadata").returns(sampleMetaDataArray);
			
			Assert.assertStrictlyEquals(sampleMetaDataArray, frameworkMethod.metadata);
		}
		
		[Test(description="Ensure that the getSpecificMetaDataArg method correctly operates when there is a return value")]
		public function getSpecificMetaDataArgReturnTest():void {
			var methodXML:XML = 
			<method name="getSpecificMetaDataArgReturnTest" 
				declaredBy="org.flexunit.runners.model:FrameworkMethodCase"
				returnType="void">
				<metadata name="Test">
					<arg key="description" value="Test Value"/>
				</metadata>
			</method>;

			var annotationsArray:Array = convertToMetaDataAnnotations( methodXML.metadata );
			methodMock.mock.method("getMetaData").withArgs("Test").returns( annotationsArray[0] );
			
			Assert.assertEquals("Test Value", frameworkMethod.getSpecificMetaDataArgValue("Test", "description") );
		}
		
		//TODO: The MetadataTools function call won't return an empty string for a key, should this test be altered?
		[Ignore("Need to determine how to handle the test")]
		[Test(description="Ensure that the getSpecificMetaDataArg method correctly operates when there is an empty return value")]
		public function getSpecificMetaDataArgEmptyReturnTest():void {
			var methodXML:XML = 
				<method name="getSpecificMetaDataArgEmptyReturnTest" 
					declaredBy="org.flexunit.runners.model:FrameworkMethodCase"
					returnType="void">
					<metadata name="Test">
						<arg key="description" value=""/>
					</metadata>
				</method>;
			
			methodMock.mock.property("methodXML").returns(methodXML);
			
			Assert.assertEquals("", frameworkMethod.getSpecificMetaDataArgValue("Test", "description") );
		}
		
		[Test(description="Ensure that the getSpecificMetaDataArg method correctly operates when a nonboolean value is received")]
		public function getSpecificMetaDataArgNullReturnValueTest():void {
			var methodXML:XML = 
				<method name="getSpecificMetaDataArgNullReturnValueTest" 
					declaredBy="org.flexunit.runners.model:FrameworkMethodCase"
					returnType="void">
					<metadata name="Test">
						<arg key="description" value="Test Value"/>
					</metadata>
				</method>;
			
			methodMock.mock.method("getMetaData").withArgs("Test");
			
			Assert.assertNull( frameworkMethod.getSpecificMetaDataArgValue("Test", "notAKey") );
		}

		[Test(description="Ensure that the getSpecificMetaDataArg method correctly operates when a boolean value is received")]
		public function getSpecificMetaDataArgNullReturnBoolTest():void {
			var methodXML:XML = 
				<method name="getSpecificMetaDataArgNullReturnBoolTest" 
					declaredBy="org.flexunit.runners.model:FrameworkMethodCase"
					returnType="void">
					<metadata name="Test">
						<arg key="description" value="Test"/>
						<arg key="" value="Test"/>
					</metadata>
				</method>;
			
			var annotationsArray:Array = convertToMetaDataAnnotations( methodXML.metadata );
			
			methodMock.mock.method("getMetaData").withArgs("Test").returns( annotationsArray[0] );
			
			Assert.assertEquals("true", frameworkMethod.getSpecificMetaDataArgValue("Test", "Test") );
		}
		
		[Test(description="Ensure that the metadata exists when an existing tag is passed")]
		public function hasMetaDataTrueTest():void {
			var methodXML:XML = 
				<method name="hasMetaDataTrueTest" 
					declaredBy="org.flexunit.runners.model:FrameworkMethodCase"
					returnType="void">
					<metadata name="Test">
						<arg key="description" value="Test Value"/>
					</metadata>
				</method>;

			var annotationsArray:Array = convertToMetaDataAnnotations( methodXML.metadata );
			
			methodMock.mock.method("hasMetaData").withArgs("Test").returns( true );
			methodMock.mock.method("getMetaData").withArgs("Test").returns( annotationsArray[0] );
			
			Assert.assertTrue( frameworkMethod.hasMetaData("Test") );
		}
		
		[Test(description="Ensure that the metadata does not exist when a non-existent tag is passed")]
		public function hasMetaDataFalseTest():void {
			var methodXML:XML = 
				<method name="hasMetaDataFalseTest" 
					declaredBy="org.flexunit.runners.model:FrameworkMethodCase"
					returnType="void">
					<metadata name="Test">
						<arg key="description" value="Test Value"/>
					</metadata>
				</method>;

			var annotationsArray:Array = convertToMetaDataAnnotations( methodXML.metadata );
			
			methodMock.mock.method("hasMetaData").withArgs("No Test").returns( false );
			methodMock.mock.method("getMetaData").withArgs("No Test").returns( null );
			
			Assert.assertFalse( frameworkMethod.hasMetaData("No Test") );
		}
		
		[Test(description="Ensure that producesType function returns false when the parameters array is not empty and the return types do not match")]
		public function producesTypeBothFalseTest():void {
			var parameterTypes:Array = ["testValue"];
			
			methodMock.mock.property("parameterTypes").returns(parameterTypes);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			Assert.assertFalse( frameworkMethod.producesType(MethodMock) );
		}
		
		[Test(description="Ensure that producesType function returns false when the parameters array empty and the return types do not match")]
		public function producesTypeTypeFalseTest():void {
			var parameterTypes:Array = new Array();
			
			methodMock.mock.property("parameterTypes").returns(parameterTypes);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			Assert.assertFalse( frameworkMethod.producesType(MethodMock) );
		}
		
		[Test(description="Ensure that producesType function returns false when the parameters array is not empty and the return types match")]
		public function producesTypeParamsFalseTest():void {
			var parameterTypes:Array = ["testValue"];
			
			methodMock.mock.property("parameterTypes").returns(parameterTypes);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			Assert.assertFalse( frameworkMethod.producesType(KlassMock) );
		}
		
		[Test(description="Ensure that producesType function returns true when the parameters array empty and the return types match")]
		public function producesTypeBothTrueTest():void {
			var parameterTypes:Array = new Array();
			
			methodMock.mock.property("parameterTypes").returns(parameterTypes);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			Assert.assertTrue( frameworkMethod.producesType(KlassMock) );
		}
		
		[Test(description="Ensure that the applyExplosively function is correctly called")]
		public function applyExplosivelyAsyncTest():void {
			var target:Object = new Object();
			var params:Array = new Array();
			
			methodMock.mock.method("apply").withArgs(target, params).once;
			
			frameworkMethod.applyExplosively(target, params);
			methodMock.mock.verify();
		}
		
		[Ignore("invokeExplosivelyAsync no longer exists")]
		[Test(description="Ensure that the invokeExplosivelyAsync function is correctly called")]
		public function invokeExplosivelyAsyncTest():void {
			var parentTokenMock:AsyncTestTokenMock = new AsyncTestTokenMock();
			var target:Object = new Object();
			var firstParam:Object = new Object();
			var secondParam:Object = new Object();
			
			parentTokenMock.mock.method("sendResult").withArgs(null).once;
			methodMock.mock.method("apply").withArgs(target, Array).once;
			
			//frameworkMethod.invokeExplosivelyAsync(parentTokenMock, target, firstParam, secondParam);
			
			parentTokenMock.mock.verify();
			methodMock.mock.verify();
		}
		
		[Test(description="Ensure that the invokeExplosively function is correctly called and correctly returns the proper value")]
		public function invokeExplosivelyTest():void {
			var target:Object = new Object();
			var firstParam:Object = new Object();
			var secondParam:Object = new Object();
			
			methodMock.mock.method("apply").withArgs(target, Array).once;
			
			frameworkMethod.invokeExplosively(target, firstParam, secondParam);
			
			methodMock.mock.verify();
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors when there are no parameter types")]
		public function validatePublicVoidNoArgNoParamTypesTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			var parameterTypes:Array = new Array();
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(false);
			methodMock.mock.property("returnType").returns(null);
			methodMock.mock.property("parameterTypes").returns(parameterTypes);
			
			frameworkMethod.validatePublicVoidNoArg(false, errors);
				
			Assert.assertEquals( 0, errors.length );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors when there are parameter types")]
		public function validatePublicVoidNoArgParamTypesTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			var parameterTypes:Array = ["paramType1", "paramType2"];
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(false);
			methodMock.mock.property("returnType").returns(null);
			methodMock.mock.property("parameterTypes").returns(parameterTypes);
			
			frameworkMethod.validatePublicVoidNoArg(false, errors);
			
			Assert.assertEquals( "Method " + testName + " should have no parameters", (errors[0] as Error).message );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a false isStatic and null returnType with a false isStatic parameter")]
		public function validatePublicVoidFalseNullFalseTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(false);
			methodMock.mock.property("returnType").returns(null);
			
			frameworkMethod.validatePublicVoid(false, errors);
			
			Assert.assertEquals( 0, errors.length );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a false isStatic and null returnType with a true isStatic parameter")]
		public function validatePublicVoidFalseNullTrueTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(false);
			methodMock.mock.property("returnType").returns(null);
			
			frameworkMethod.validatePublicVoid(true, errors);
			
			Assert.assertEquals( "Method " + testName + "() " + "should" + " be static", (errors[0] as Error).message );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a false isStatic and non-null returnType with a false isStatic parameter")]
		public function validatePublicVoidFalseNotNullFalseTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(false);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			frameworkMethod.validatePublicVoid(false, errors);
			
			Assert.assertEquals( "Method " + testName + "() should be void", (errors[0] as Error).message );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a false isStatic and non-null returnType with a true isStatic parameter")]
		public function validatePublicVoidFalseNotNullTrueTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(false);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			frameworkMethod.validatePublicVoid(true, errors);
			
			Assert.assertEquals( "Method " + testName + "() " + "should" + " be static", (errors[0] as Error).message );
			Assert.assertEquals( "Method " + testName + "() should be void", (errors[1] as Error).message );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a true isStatic and null returnType with a false isStatic parameter")]
		public function validatePublicVoidTrueNullFalseTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(true);
			methodMock.mock.property("returnType").returns(null);
			
			frameworkMethod.validatePublicVoid(false, errors);
			
			Assert.assertEquals( "Method " + testName + "() " + "should not" + " be static", (errors[0] as Error).message );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a true isStatic and null returnType with a true isStatic parameter")]
		public function validatePublicVoidTrueNullTrueTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(true);
			methodMock.mock.property("returnType").returns(null);
			
			frameworkMethod.validatePublicVoid(true, errors);
			
			Assert.assertEquals( 0, errors.length );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a true isStatic and non-null returnType with a false isStatic parameter")]
		public function validatePublicVoidTrueNotNullFalseTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(true);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			frameworkMethod.validatePublicVoid(false, errors);
			
			Assert.assertEquals( "Method " + testName + "() " + "should not" + " be static", (errors[0] as Error).message );
			Assert.assertEquals( "Method " + testName + "() should be void", (errors[1] as Error).message );
		}
		
		[Test(description="Ensure that the validatePublicVoid function generates the correct errors for a true isStatic and non-null returnType with a true isStatic parameter")]
		public function validatePublicVoidTrueNotNullTrueTest():void {
			var errors:Array = new Array();
			var testName:String = "testName";
			
			methodMock.mock.property("name").returns(testName);
			methodMock.mock.property("isStatic").returns(true);
			methodMock.mock.property("returnType").returns(KlassMock);
			
			frameworkMethod.validatePublicVoid(true, errors);
			
			Assert.assertEquals( "Method " + testName + "() should be void", (errors[0] as Error).message );
		}
		
		[Test(description="Ensure the toString function is returning the appropriate value")]
		public function toStringTest():void {
			var testName:String = "testName";
			methodMock.mock.property("name").returns("testName");
			
			Assert.assertEquals("FrameworkMethod " + testName, frameworkMethod.toString());
		}
	}
}