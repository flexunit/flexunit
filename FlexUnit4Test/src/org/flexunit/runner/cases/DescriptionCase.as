package org.flexunit.runner.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.mocks.DescriptionMock;

	//TODO: This entire class needs to have tests written for it
	
	public class DescriptionCase
	{
		protected var description:Description;
		
		//At least three differnt types of tests need to be written for the Descirption class: one that uses the normal description 
		//constructor, one that uses the createTestDescription static method, and one that uses the createSuiteDescription static method
				
		[Before]
		public function setup():void {
		}
		
		[After]
		public function tearDown():void {
		}
		
		////////////////////////////////////////////
		//
		// Constructor tests
		//
		////////////////////////////////////////////
		
		[Test(description="Ensure displayName gets set properly during contructor initialization")]
		public function check_initialize_displayName():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			var expectedDisplayName:String = "myDisplayName";
			description = new Description( expectedDisplayName, xmlList );
			Assert.assertEquals( expectedDisplayName, description.displayName );
		}
		
		[Test(description="Ensure metadata gets set properly during contructor initialization")]
		public function check_initialize_metadata():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			Assert.assertEquals( xmlList, description.getAllMetadata() );
		}
		
		[Test(description="Ensure isInstance gets set properly during contructor initialization when set to true")]
		public function check_initialize_isInstance_true():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList, true );
			Assert.assertTrue( description.isInstance );
		}
		
		[Test(description="Ensure isInstance gets set properly during contructor initialization when set to false")]
		public function check_initialize_isInstance_false():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			Assert.assertFalse( description.isInstance );
		}
		
		[Test(description="Ensure children gets set properly during contructor initialization")]
		public function check_initialize_children():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			Assert.assertTrue( description.children is Array );
			Assert.assertEquals( 0, description.children as Array );
		}
		
		[Test(description="Ensure that a value of false is returned from the isSuite function if the description has no children")]
		public function check_initialize_isSuite_false():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			
			Assert.assertFalse( description.isSuite );
		}
		
		[Test(description="Ensure that a value of true is returned from the isSuite function if the description has one or more children")]
		public function check_initialize_isSuite_true():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			description.addChild(new Description( "somethingElse", xmlList ));
			
			Assert.assertTrue( description.isSuite );
		}
		
		[Test(description="Ensure that a value of false is returned from the isTest function if the description has one or more children")]
		public function check_initialize_isTest_False():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			description.addChild(new Description( "somethingElse", xmlList ));
			
			Assert.assertFalse( description.isTest );
		}
		
		[Test(description="Ensure that a value of true is returned from the isTest function if the description has no children")]
		public function check_initialize_isTest_true():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			
			Assert.assertTrue( description.isTest );
		}	
		
		[Test(description="Ensure that a value of false is returned from the isEmpty function if the description has one or more children")]
		public function check_initialize_isEmpty_false():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			description.addChild(new Description( "somethingElse", xmlList ));
			
			Assert.assertFalse( description.isEmpty );
		}
		
		[Test(description="Ensure that a value of true is returned from the isEmpty function if the description has no children")]
		public function check_initialize_isEmpty_true():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			
			Assert.assertFalse( description.isEmpty );
		}
		
		//TODO: This method has yet to be implemented and this test needs to be updated
		[Test(description="Ensure a childless copy of the description is obtained from the childlessCopy function")]
		public function check_initizlize_childlessCopy():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			description.addChild(new Description( "somethingElse", xmlList ));
			
			//Assert that a child has been added be checking to see if the description is a test
			Assert.assertFalse( description.isTest );
			
			//Get the childless copy
			var childlessDescription:IDescription = description.childlessCopy();
			
			//There should no longer be any children in this object, it should act like a test
			Assert.assertFalse( description.isTest );
		}
		
		[Test(description="Ensure a value of false is obtained from the equals function when the object isn't a description")]
		public function check_initialize_equals_notDescription():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			Assert.assertFalse( description.equals(new Object()) );
		}
		
		[Test(description="Ensure a value of false is obtained from the equals function when the object is a description but they are not equal")]
		public function check_initialize_equals_notEqual():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			var descriptionTwo:IDescription = new Description( "somethingElse", xmlList );
			Assert.assertFalse( description.equals(descriptionTwo) );
		}
		
		[Test(description="Ensure a value of true is obtained from the equals function when the object is a description and they are equal")]
		public function check_initialize_equals_areEqual():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			description = new Description( "something", xmlList );
			Assert.assertTrue( description.equals(description) );
		}
		
		////////////////////////////////////////////
		//
		// createTestDescription tests
		//
		////////////////////////////////////////////
		
		// TODO using mock class DescriptionMock causes the displayName to get set to
		// org.flexunit.runner.mocks::DescriptionMock.DescriptionMock
		// not sure if that is correct
		[Test(description="Ensure displayName gets set properly during createTestDescription initialization")]
		public function check_createTestDescription_initialize_displayName():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			var idescription:IDescription = Description.createTestDescription( DescriptionMock, "DescriptionMock", xmlList );
			Assert.assertEquals( "org.flexunit.runner.mocks::DescriptionMock.DescriptionMock", idescription.displayName );
		}
		
		[Test(description="Ensure metadata gets set properly during createTestDescription initialization")]
		public function check_createTestDescription_initialize_metadata():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			var idescription:IDescription = Description.createTestDescription( DescriptionMock, "DescriptionMock", xmlList );
			Assert.assertEquals( xmlList, idescription.getAllMetadata() );
		}
		
		[Test(description="Ensure isInstance gets set properly during createTestDescription initialization")]
		public function check_createTestDescription_initialize_isInstance():void {
			var idescription:IDescription = Description.createTestDescription( DescriptionMock, "DescriptionMock" );
			// since this description gets created static, isStatic should always be false in this case
			Assert.assertFalse( idescription.isInstance );
		}
		
		[Test(description="Ensure children gets set properly during createTestDescription initialization")]
		public function check_createTestDescription_initialize_children():void {
			var xmlList:XMLList = new XMLList( new XML( <metadata name="RunWith"/> ) );
			var idescription:IDescription = Description.createTestDescription( DescriptionMock, "DescriptionMock", xmlList );
			Assert.assertTrue( idescription.children is Array );
			Assert.assertEquals( 0, idescription.children as Array );
		}
		
		////////////////////////////////////////////
		//
		// createSuiteDescription tests
		//
		////////////////////////////////////////////
		
		[Test(description="Ensure displayName gets set properly during createSuiteDescription initialization with class definition")]
		public function check_createSuiteDescription_initialize_displayName():void {
			var idescription:IDescription = Description.createSuiteDescription( DescriptionMock, null );
			Assert.assertEquals( "org.flexunit.runner.mocks::DescriptionMock", idescription.displayName );
		}
		
		[Test(description="Ensure metadata gets set properly during createSuiteDescription initialization with class definition")]
		public function check_createSuiteDescription_initialize_metadata():void {
			var xmlList:XMLList = generateLocalTestClassMetaDataXMLList();
			var idescription:IDescription = Description.createSuiteDescription( LocalTestClass );
			xmlList = idescription.getAllMetadata();
			Assert.assertEquals( xmlList, idescription.getAllMetadata() );
		}
		
		[Test(description="Ensure isInstance gets set properly during createSuiteDescription initialization with class definition")]
		public function check_createSuiteDescription_initialize_isInstance():void {
			var idescription:IDescription = Description.createSuiteDescription( DescriptionMock, null );
			// since this description gets created static, isStatic should always be false in this case
			Assert.assertFalse( idescription.isInstance );
		}
		
		[Test(description="Ensure children gets set properly during createSuiteDescription initialization with class definition")]
		public function check_createSuiteDescriptio_initialize_children():void {
			var xmlList:XMLList = generateLocalTestClassMetaDataXMLList();
			var idescription:IDescription = Description.createSuiteDescription( LocalTestClass, xmlList );
			Assert.assertTrue( idescription.children is Array );
			Assert.assertEquals( 0, idescription.children as Array );
		}
		
		[Test(description="Ensure displayName gets set properly during createSuiteDescription initialization with class string")]
		public function check_createSuiteDescription_initialize_displayName_with_className():void {
			var idescription:IDescription = Description.createSuiteDescription( "DescriptionMock", null );
			Assert.assertEquals( "DescriptionMock", idescription.displayName );
		}
		
		[Test(description="Ensure metadata gets set properly during createSuiteDescription initialization with class string")]
		public function check_createSuiteDescription_initialize_metadata_with_className():void {
			var xmlList:XMLList = generateLocalTestClassMetaDataXMLList();
			var idescription:IDescription = Description.createSuiteDescription( "LocalTestClass" );
			xmlList = idescription.getAllMetadata();
			Assert.assertEquals( xmlList, idescription.getAllMetadata() );
		}
		
		[Test(description="Ensure isInstance gets set properly during createSuiteDescription initialization with class string")]
		public function check_createSuiteDescription_initialize_isInstance_with_className():void {
			var idescription:IDescription = Description.createSuiteDescription( "DescriptionMock" );
			// since this description gets created static, isStatic should always be false in this case
			Assert.assertFalse( idescription.isInstance );
		}
		
		[Test(description="Ensure children gets set properly during createSuiteDescription initialization with class string")]
		public function check_createSuiteDescriptio_initialize_children_with_className():void {
			var xmlList:XMLList = generateLocalTestClassMetaDataXMLList();
			var idescription:IDescription = Description.createSuiteDescription( "LocalTestClass", xmlList );
			Assert.assertTrue( idescription.children is Array );
			Assert.assertEquals( 0, idescription.children as Array );
		}
		
		////////////////////////////////////////////
		//
		// helper methods
		//
		////////////////////////////////////////////
	
		private function generateLocalTestClassMetaDataXMLList():XMLList {
			// this is the xml version of the metadata on LocalTestClass defined at the end of this file
			var xml:XML = <nodes>
							<metadata name="Ignore" />
							<metadata name="Suite"/>
							<metadata name="RunWith">
							  <arg key="" value="org.flexunit.runners.Suite"/>
							</metadata>
							</nodes>;
			// convert the xml into an XMLList
			return new XMLList( xml.metadata );
		}
	}
}

[Ignore]
[Suite]
[RunWith("org.flexunit.runners.Suite")]
class LocalTestClass {
	public var aVar:String;
	public var cVar:Number;
	public var bVar:Array;
	
	public function aMethod():void {}
	public function bMethod( param1:Number, param2:String, param3:Date ):void {}
	public function cMethod():void {}
}
