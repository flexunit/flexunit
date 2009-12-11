package org.flexunit.experimental.theories.cases
{
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.mocks.ConstructorMock;
	import flex.lang.reflect.mocks.FieldMock;
	import flex.lang.reflect.mocks.KlassMock;
	import flex.lang.reflect.mocks.MethodMock;
	
	import org.flexunit.Assert;
	import org.flexunit.experimental.theories.ParameterSignature;
	import org.flexunit.runners.model.mocks.FrameworkMethodMock;

	public class ParameterSignatureCase
	{
		//TODO: Ensure that these tests and this test case are implemented correctly
		
		protected var parameterSignature:ParameterSignature;
		protected var type:Class;
		protected var metadata:Array;
		protected var metadataXML:XML = 
			<test>
				<value name="Object"/>
				<value name="Method"/>;
			</test>;

		private static function convertToMetaDataAnnotations( metaXML:XMLList ):Array {
			var ar:Array = new Array();
			for ( var i:int=0; i<metaXML.length(); i++ )  {
				ar.push( new MetaDataAnnotation( metaXML[ i ] ) );
			}
			
			return ar;
		} 
		
		[Before(description="Create an instance of the ParameterSignature class")]
		public function createParameterSignature():void {
			type = Object;
			metadata = convertToMetaDataAnnotations( metadataXML.value );
			parameterSignature = new ParameterSignature(type, metadata);
		}
		
		[After(description="Remove the reference to the ParameterSignature class")]
		public function destroyParameterSignature():void {
			parameterSignature = null;
			type = null;
			metadata = null;
		}
		
		//TODO: Is there a way to check that the metadata is correct
		[Test(description="Ensure that an array ParameterSignatures is returned for a given Method")]
		public function signatureByMethodTest():void {
			var parameterTypes:Array = [Method, Object];
			var ar:Array = new Array();
			var methodMock:MethodMock = new MethodMock();
			methodMock.mock.property("parameterTypes").returns(parameterTypes);
			methodMock.mock.property("metadata").returns(ar);
			
			//Check to see that the array was properly built
			var signatures:Array = ParameterSignature.signaturesByMethod(methodMock);
			Assert.assertTrue( signatures[0] is ParameterSignature );
			Assert.assertEquals( (signatures[0] as ParameterSignature).type, parameterTypes[0] );
			Assert.assertTrue( signatures[1] is ParameterSignature );
			Assert.assertEquals( (signatures[1] as ParameterSignature).type, parameterTypes[1] );
			
		}
		
		//TODO: Is there a way to check that the metadata is correct
		[Test(description="Ensure that an array ParameterSignatures is returned for a given Constructor")]
		public function signaturesByContructorTest():void {
			var parameterTypes:Array = [Method, Object];
			var klassMock:KlassMock = new KlassMock(null);
			var constructorMock:ConstructorMock = new ConstructorMock(null, klassMock);
			constructorMock.mock.property("parameterTypes").returns(parameterTypes);
			
			//Check to see that the array was properly built
			var signatures:Array = ParameterSignature.signaturesByContructor(constructorMock);
			Assert.assertTrue( signatures[0] is ParameterSignature );
			Assert.assertEquals( (signatures[0] as ParameterSignature).type, parameterTypes[0] );
			Assert.assertTrue( signatures[1] is ParameterSignature );
			Assert.assertEquals( (signatures[1] as ParameterSignature).type, parameterTypes[1] );
		}
		
		[Test(description="Ensure the canAcceptType function reutrns false if the parameter class does not match the type class")]
		public function canAcceptTypeFalseTest():void {
			Assert.assertFalse( parameterSignature.canAcceptType(Klass) );
		}
		
		[Test(description="Ensure the canAcceptType function reutrns true if the parameter class matches the type class")]
		public function canAcceptTypeTrueTest():void {
			Assert.assertTrue( parameterSignature.canAcceptType(Object) );
		}
		
		[Test(description="Ensure the class type that was passed in the constructor is correctly returned")]
		public function getTypeTest():void {
			Assert.assertEquals( Object, parameterSignature.type );
		}
		
		[Test(description="Ensure canAcceptArrayType reutrns false if both the field's type is not an array and the field's elementType does not match the class' type")]
		public function canAcceptArrayTypeNotArrayNotTypeTest():void {
			var fieldMock:FieldMock = new FieldMock();
			fieldMock.mock.property("type").returns(null);
			fieldMock.mock.property("elementType").returns(null);
			
			Assert.assertFalse( parameterSignature.canAcceptArrayType(fieldMock) );
		}
		
		[Test(description="Ensure canAcceptArrayType reutrns false if the field's type is not an array but the field's elementType matches the class' type")]
		public function canAcceptArrayTypeNotArrayTypeTest():void {
			var fieldMock:FieldMock = new FieldMock();
			fieldMock.mock.property("type").returns(null);
			fieldMock.mock.property("elementType").returns(type);
			
			Assert.assertFalse( parameterSignature.canAcceptArrayType(fieldMock) );
		}
		
		[Test(description="Ensure canAcceptArrayType reutrns false if the field's type is an array but the field's elementType does not match the class' type")]
		public function canAcceptArrayTypeArrayNotTypeTest():void {
			var fieldMock:FieldMock = new FieldMock();
			fieldMock.mock.property("type").returns(Array);
			fieldMock.mock.property("elementType").returns(null);
			
			Assert.assertFalse( parameterSignature.canAcceptArrayType(fieldMock) );
		}
		
		[Test(description="Ensure canAcceptArrayType reutrns true if both the field's type an array and the field's elementType matches the class' type")]
		public function canAcceptArrayTypeArrayTypeTest():void {
			var fieldMock:FieldMock = new FieldMock();
			fieldMock.mock.property("type").returns(Array);
			fieldMock.mock.property("elementType").returns(type);
			
			Assert.assertTrue( parameterSignature.canAcceptArrayType(fieldMock) );
		}
		
		[Test(description="Ensure that canAcceptArrayTypeMethod returns false when the FrameworkMethod's producesType returns false and the FrameworkMethod's Method's element type does not match the class' element type")]
		public function canAcceptArrayTypeMethodNotArrayNotTypeTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var methodMock:MethodMock = new MethodMock();
			frameworkMethodMock.mock.method("producesType").withArgs(Array).once.returns(false);
			frameworkMethodMock.mock.property("methud").returns(methodMock);
			methodMock.mock.property("elementType").returns(null);
			
			Assert.assertFalse( parameterSignature.canAcceptArrayTypeMethod(frameworkMethodMock) )
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that canAcceptArrayTypeMethod returns false when the FrameworkMethod's producesType returns false but the FrameworkMethod's Method's element type matches the class' element type")]
		public function canAcceptArrayTypeMethodNotArrayTypeTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var methodMock:MethodMock = new MethodMock();
			frameworkMethodMock.mock.method("producesType").withArgs(Array).once.returns(false);
			frameworkMethodMock.mock.property("methud").returns(methodMock);
			methodMock.mock.property("elementType").returns(type);
			
			Assert.assertFalse( parameterSignature.canAcceptArrayTypeMethod(frameworkMethodMock) )
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that canAcceptArrayTypeMethod returns false when the FrameworkMethod's producesType returns true but the FrameworkMethod's Method's element type does not match the class' element type")]
		public function canAcceptArrayTypeMethodArrayNotTypeTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var methodMock:MethodMock = new MethodMock();
			frameworkMethodMock.mock.method("producesType").withArgs(Array).once.returns(true);
			frameworkMethodMock.mock.property("methud").returns(methodMock);
			methodMock.mock.property("elementType").returns(null);
			
			Assert.assertFalse( parameterSignature.canAcceptArrayTypeMethod(frameworkMethodMock) )
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure that canAcceptArrayTypeMethod returns true when the FrameworkMethod's producesType returns true and the FrameworkMethod's Method's element type matches the class' element type")]
		public function canAcceptArrayTypeMethodArrayTypeTest():void {
			var frameworkMethodMock:FrameworkMethodMock = new FrameworkMethodMock();
			var methodMock:MethodMock = new MethodMock();
			frameworkMethodMock.mock.method("producesType").withArgs(Array).once.returns(true);
			frameworkMethodMock.mock.property("methud").returns(methodMock);
			methodMock.mock.property("elementType").returns(type);
			
			Assert.assertTrue( parameterSignature.canAcceptArrayTypeMethod(frameworkMethodMock) )
			
			frameworkMethodMock.mock.verify();
		}
		
		[Test(description="Ensure the hasMetadata function returns false if no metadata is found that has a name that does not match the string type")]
		public function hasMetadataFalseTest():void {
			Assert.assertFalse( parameterSignature.hasMetadata("Klass") );
		}
		
		[Test(description="Ensure the hasMetadata function returns false if no metadata is found that has a name that matches the string type")]
		public function hasMetadataTrueTest():void {
			Assert.assertTrue( parameterSignature.hasMetadata("Method") );
		}
		
		//TODO: There currently is not a way to test a depth of 0, should there be a test for it; if so, what needs to be done?
		[Test(description="Ensure the particular piece of metadata is found if its name matches the string type")]
		public function findDeepAnnotationTest():void {
			//var xml:XML = <value name="Method"/>;
			Assert.assertEquals( "Method", parameterSignature.findDeepAnnotation("Method").name );
		}
		
		[Test(description="Ensure that the getAnnotationResult function returns null if the name in the metadata does not match the type")]
		public function getAnnotationNullResult():void {
			Assert.assertNull( parameterSignature.getAnnotation("Klass") );
		}
		
		[Test(description="Ensure that the getAnnotationResult function returns metadata if the name in the metadata matches the type")]
		public function getAnnotationResultTest():void {
//			var xml:XML = <value name="Object"/>;
			Assert.assertEquals( "Object", parameterSignature.getAnnotation("Object").name );
		}
		
		[Test(description="Ensure that the toString function returns the proper string value")]
		public function toStringTest():void {
			Assert.assertEquals( "ParameterSignature ( type:" + type + ", metadata:" + metadata + " )", parameterSignature.toString() );
		}
	}
}