package tests.flex.lang.reflect.metadata.utils
{
	import flex.lang.reflect.utils.MetadataTools;
	
	import org.flexunit.Assert;
	
	public class MetaDataToolsCase
	{
		[Test(description="Check if class description indicates this class has a base type of 'Class'")]
		public function check_isClass():void {
			var descXML:XML = 	<classxml name="MyClass" base="Class" returnType="void"></classxml>;
			var result:Boolean = MetadataTools.isClass( descXML );
			Assert.assertTrue( result );
		}
		
		[Test(description="Check if class description indicates this class does not have a base type 'Class'")]
		public function check_not_isClass():void {
			var descXML:XML = 	<classxml name="MyClass" base="DescriptionMock" returnType="void"></classxml>;
			var result:Boolean = MetadataTools.isClass( descXML );
			Assert.assertFalse( result );
		}
		
		[Test(description="Check if class description indicates this class is not an instance")]
		public function check_not_isInstance():void {
			var descXML:XML = 	<classxml name="MyClass" base="Class" returnType="void"></classxml>;
			var result:Boolean = MetadataTools.isInstance( descXML );
			Assert.assertFalse( result );
		}
		
		[Test(description="Check if class description indicates this class is not an instance")]
		public function check_isInstance():void {
			var descXML:XML = 	<classxml name="MyClass" base="DescriptionMock" returnType="void"></classxml>;
			var result:Boolean = MetadataTools.isInstance( descXML );
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure when description does not describe a class that the correct value is returned from classExtends method")]
		public function check_classExtends_nonClass_description():void {
			var descXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<extendsClass type="DescriptionMock" />
								</classxml>;
			var result:Boolean = MetadataTools.classExtends( descXML, "DescriptionMock" );
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure when description does not describe a class that the correct value is returned from classExtends method")]
		public function check_classExtends_Class_description():void {
			var descXML:XML = 	<classxml name="MyClass" base="Class" returnType="void">
									<factory>
										<extendsClass type="DescriptionMock" />
									</factory>
								</classxml>;
			var result:Boolean = MetadataTools.classExtends( descXML, "DescriptionMock" );
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure when description does not describe a class that the correct value is returned from classImplements method")]
		public function check_classImplements_nonClass_description():void {
			var descXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<implementsInterface type="IDescription" />
								</classxml>;
			var result:Boolean = MetadataTools.classImplements( descXML, "IDescription" );
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure when description describes a class that the correct value is returned from classImplements method")]
		public function check_classImplements_class_description():void {
			var descXML:XML = 	<classxml name="MyClass" base="Class" returnType="void">
									<factory>
										<implementsInterface type="IDescription" />
									</factory>
								</classxml>;
			var result:Boolean = MetadataTools.classImplements( descXML, "IDescription" );
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure when description does not describe a class that the correct value is returned from getArgValueFromDescription method")]
		public function check_getArgValueFromDescription_nonClass_description():void {
			var descXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<metadata name="Test">
										<arg key="description" value="this is my description"/>
									</metadata>
								</classxml>;
			var result:String = MetadataTools.getArgValueFromDescription( descXML, "Test", "description" );
			Assert.assertEquals( "this is my description", result );
		}
		
		[Test(description="Ensure when description describes a class that the correct value is returned from getArgValueFromDescription method")]
		public function check_getArgValueFromDescription_class_description():void {
			var descXML:XML = 	<classxml name="MyClass" base="Class" returnType="void">
									<factory>
										<metadata name="Test">
											<arg key="description" value="this is my description"/>
										</metadata>
									</factory>
								</classxml>;
			var result:String = MetadataTools.getArgValueFromDescription( descXML, "Test", "description" );
			Assert.assertEquals( "this is my description", result );
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure method list is retrieved properly")]
		public function check_retrieve_method_list():void {
			var methodXML0:XML = <method name="myFirstMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="String"> 
									<metadata name="Test">
										<arg key="description" value="First description"/>
									</metadata>
								</method>;
			var methodXML1:XML = <method name="mySecondMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="String"> 
									<metadata name="Async">
										<arg key="description" value="Second description"/>
									</metadata>
								</method>;
			
			var descriptionXML:XML = <classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									 </classxml>;
			descriptionXML.appendChild( methodXML0 );
			descriptionXML.appendChild( methodXML1 );
			
			var expectedMethodXMLList:XMLList = new XMLList();
			expectedMethodXMLList[0] = methodXML0;
			expectedMethodXMLList[1] = methodXML1;
			
			var result:XMLList = MetadataTools.getMethodsList( descriptionXML );
			
			Assert.assertEquals( expectedMethodXMLList, result );
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure nothing is returned if no methods are listed in the description xml")]
		public function check_retrieve_null_when_no_methods_in_description():void {
			var descriptionXML:XML = <classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void"></classxml>;
			var result:XMLList = MetadataTools.getMethodsList( descriptionXML );
			// verify that an empty XMLList is returned
			Assert.assertEquals( 0, result.length() );
		}
		
		[Test(description="Ensure we can retrieve a method from the method list by metadata name")]
		public function check_getMethodsDecoratedBy():void {
			var methodXML0:XML = <method name="myFirstMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="String"> 
									<metadata name="Test">
										<arg key="description" value="First description"/>
									</metadata>
								</method>;
			var methodXML1:XML = <method name="mySecondMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="String"> 
									<metadata name="Async">
										<arg key="description" value="Second description"/>
									</metadata>
								</method>;
			
			var methodXMLList:XMLList = new XMLList();
			methodXMLList[0] = methodXML0;
			methodXMLList[1] = methodXML1;
			
			var result:XMLList = MetadataTools.getMethodsDecoratedBy( methodXMLList, "Async" );
			
			Assert.assertEquals( methodXML1, result );
		}
		
		[Test(description="Ensure we can retrieve a method from the method list by metadata name")]
		public function check_getMethodsDecoratedBy_not_found():void {
			var methodXML0:XML = <method name="myFirstMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="String"> 
									<metadata name="Test">
										<arg key="description" value="First description"/>
									</metadata>
								</method>;
			
			var methodXMLList:XMLList = new XMLList();
			methodXMLList[0] = methodXML0;
			
			var result:XMLList = MetadataTools.getMethodsDecoratedBy( methodXMLList, "Async" );
			
			// verify that an empty XMLList is returned
			Assert.assertEquals( 0, result.length() );
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect if a class implements an interface")]
		public function check_class_impements_interface():void {
			var nodeXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<implementsInterface type="IDescription" />
								</classxml>;
			var result:Boolean = MetadataTools.classImpementsNode( nodeXML, "IDescription" );
			Assert.assertTrue( result );
			
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect if a class does not implement an interface")]
		public function check_class_does_not_implement_interface():void {
			var nodeXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<implementsInterface type="IDescription" />
								</classxml>;
			var result:Boolean = MetadataTools.classImpementsNode( nodeXML, "IDontImpelementAnything" );
			Assert.assertFalse( result );
			
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect if interface node is not passed in with the class xml")]
		public function check_classxml_contains_no_interface():void {
			var nodeXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
								</classxml>;
			var result:Boolean = MetadataTools.classImpementsNode( nodeXML, "IDontImpelementAnything" );
			Assert.assertFalse( result );
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect when classxml is null we aren't detecting that we implement anything")]
		public function when_classxml_isNull_ensure_class_does_not_implement_anything():void {
			var result:Boolean = MetadataTools.classImpementsNode( null, "IDontImpelementAnything" );
			Assert.assertFalse( result );
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect if a class extends another class")]
		public function check_class_extends_interface():void {
			var nodeXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<extendsClass type="DescriptionMock" />
								</classxml>;
			var result:Boolean = MetadataTools.classExtendsFromNode( nodeXML, "DescriptionMock" );
			Assert.assertTrue( result );
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect if a class does not extend another class")]
		public function check_class_does_not_extend_another_class():void {
			var nodeXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<extendsClass type="DescriptionMock" />
								</classxml>;
			var result:Boolean = MetadataTools.classExtendsFromNode( nodeXML, "IDontExtendAnything" );
			Assert.assertFalse( result );
			
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect if extendsClass node is not passed in with the class xml")]
		public function check_classxml_contains_no_extendsClass():void {
			var nodeXML:XML = 	<classxml name="MyClass" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
								</classxml>;
			var result:Boolean = MetadataTools.classExtendsFromNode( nodeXML, "IDontExtendAnything" );
			Assert.assertFalse( result );
		}
		
		// TODO : Not sure of the xml used here is the correct syntax
		[Test(description="Ensure we can detect when classxml is null we aren't detecting that we extend anything")]
		public function when_classxml_isNull_ensure_class_does_not_extend_anything():void {
			var result:Boolean = MetadataTools.classExtendsFromNode( null, "IDontExtendAnything" );
			Assert.assertFalse( result );
		}
		
		[Test(description="Ensure we can detect when a method has metadata of a specific name")]
		public function check_nodeHasMetaData_true():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void"></method>;
			
			// create some metadata xml for the method
			var metadata:XML =	<metadata name="Test">
									<arg key="description" value="ensure that setting layoutImpl makes the appropriate calls"/>
								</metadata>;
			// add the metadata to the method description
			nodeXML.appendChild( metadata );
			
			// check to see if node has metadata
			var result:Boolean = MetadataTools.nodeHasMetaData( nodeXML, "Test" );
			
			// verify that we found the metadata
			Assert.assertTrue(result);
		}
		
		[Test(description="Ensure we can detect when method does not have metadata of a specific name")]
		public function check_nodeHasMetaData_do_not_have_metadata_with_a_certain_name():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void"></method>;
			
			// create some metadata xml for the method
			var metadata:XML =	<metadata name="Test" />;
			
			// add the metadata to the method description
			nodeXML.appendChild( metadata );
			
			// check to see if node has metadata
			var result:Boolean = MetadataTools.nodeHasMetaData( nodeXML, "iDontHaveThisMetaData" );
			
			// verify that we found the metadata
			Assert.assertFalse(result);
		}
		
		[Test(description="Ensure node xml does not contain metadata that call to nodeHasMetaData returns the correct value")]
		public function check_nodeHasMetaData_no_metadata_in_xml():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void"></method>;
			
			// check to see if node has metadata
			var result:Boolean = MetadataTools.nodeHasMetaData( nodeXML, "iDontHaveAnyMetaData" );
			
			// verify that we did not find any metadata
			Assert.assertFalse( result );
		}
		
		[Test(description="Ensure when there is no node xml that call to nodeHasMetaData returns the correct value")]
		public function check_nodeHasMetaData_no_nodeXML():void {
			// check to see if node has metadata
			var result:Boolean = MetadataTools.nodeHasMetaData( null, "iDontHaveAnyMetaData" );
			
			// verify that we did not find any metadata
			Assert.assertFalse( result );
		}
		
		[Test(description="Ensure that we can detect if method accepts parameters when method has at least one parameter")]
		public function check_method_accepts_params_at_least_1_param():void {
			var methodXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<parameter name="param1"/>
								</method>;
			var result:Boolean = MetadataTools.doesMethodAcceptsParams( methodXML );
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure that we can detect if method accepts parameters when method has more than one parameter")]
		public function check_method_accepts_params_greater_than_1_param():void {
			var methodXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void">
									<parameter name="param1"/>
									<parameter name="param2"/>
								</method>;
			var result:Boolean = MetadataTools.doesMethodAcceptsParams( methodXML );
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure that we can detect if method does not accept parameters")]
		public function check_method_does_not_accept_params():void {
			var methodXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void"></method>;
			var result:Boolean = MetadataTools.doesMethodAcceptsParams( methodXML );
			Assert.assertFalse( result );
		}
		
		[Test(description="Ensure get method return type returns null when there is not methodXML")]
		public function check_getMethodReturnType_no_methodXML():void {
			var returnType:String = MetadataTools.getMethodReturnType( null );
			Assert.assertEquals( "", returnType );
		}
		
		[Test(description="Ensure get method return type returns the correct value")]
		public function check_getMethodReturnType():void {
			var methodXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void"></method>;
			var returnType:String = MetadataTools.getMethodReturnType( methodXML );
			Assert.assertEquals( "void", returnType );
		}
		
		[Test(description="Ensure that if node arg does not contain any metadata nodes that call to nodeMetaData returns null")]
		public function check_nodeMetadata_when_node_arg_does_not_contain_metadata():void {
			var nodeXML:XML = <variable name="constructorCase" type="flex.lang.reflect.cases::ConstructorCase"/>;
			var result:XMLList = MetadataTools.nodeMetaData( nodeXML );
			Assert.assertNull( result );
		}
		
		// TODO : method nodeMetaData in MetadataTools variable metaNodes is not being used
		[Test(description="Ensure that if node arg contains metadata nodes that call to nodeMetaData converts the metadata nodes to an XMLList")]
		public function check_nodeMetadata_when_node_arg_contains_metadata():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod" declaredBy="flex.lang.reflect.cases::MethodCase" returnType="void"></method>;
			
			// create some metadata xml for the method
			var metadata1:XML = <metadata name="Ignore" />
			var metadata2:XML =	<metadata name="Test">
									<arg key="description" value="ensure that setting layoutImpl makes the appropriate calls"/>
								</metadata>;
			// add the metadata to the method description
			nodeXML.appendChild( metadata1 );
			nodeXML.appendChild( metadata2 );
			
			// create an xmlList out of the metadata
			var metadataXMLList:XMLList = new XMLList();
			metadataXMLList[0] = metadata1;
			metadataXMLList[1] = metadata2;
			
			// attempt to get the nodeMetaData
			var result:XMLList = MetadataTools.nodeMetaData( nodeXML );
			
			// verify that the metadata returned matches what we expect
			Assert.assertEquals( metadataXMLList, result );
		}
		
		[Test(description="If there are no metadata nodes make sure this method returns null")]
		public function check_getMetaDataNodeFromNodesList_no_metadata():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod"></method>;
			// attempt to get the nodeMetaData
			var result:XMLList = MetadataTools.nodeMetaData( nodeXML );
			Assert.assertNull( result );
		}
		
		[Test(description="If metadata node is retrieved properly")]
		public function check_getMetaDataNodeFromNodesList_with_metadata():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod"></method>;
			
			// create some metadata xml for the method
			var metadata1:XML = <metadata name="Ignore" />
			var metadata2:XML =	<metadata name="Test">
									<arg key="description" value="ensure that setting layoutImpl makes the appropriate calls"/>
								</metadata>;
			// add the metadata to the method description
			nodeXML.appendChild( metadata1 );
			nodeXML.appendChild( metadata2 );
			
			// create an xmlList out of the metadata
			var metadataXMLList:XMLList = new XMLList();
			metadataXMLList[0] = metadata1;
			metadataXMLList[1] = metadata2;
			
			// attempt to retrieve a specific metadata node
			var retrievedNode:XML = MetadataTools.getMetaDataNodeFromNodesList( metadataXMLList, "Test" );
			
			// verify that the node retrieved is equal to what we expect
			Assert.assertEquals( metadata2, retrievedNode );
		}
		
		[Test(description="Ensure a blank key in the metadata can be detected")]
		public function check_blank_key_in_metadata():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod"></method>;
			
			// create some metadata xml for the method
			var metadata1:XML =	<metadata name="Test">
									<arg key="" value="this arg has a blank key"/>
								</metadata>;
			// add the metadata to the method description
			nodeXML.appendChild( metadata1 );
			
			// create an xmlList out of the metadata
			var metadataXMLList:XMLList = new XMLList();
			metadataXMLList[0] = metadata1;
			
			// attempt to detect presence of a blank key
			var result:Boolean = MetadataTools.checkForValueInBlankMetaDataNode( nodeXML, "Test", "this arg has a blank key" );
			
			// verify that metadata with a blank key was found
			Assert.assertTrue( result );
		}
		
		[Test(description="Ensure a blank key in the metadata is not detected")]
		public function check_non_blank_key_in_metadata():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod"></method>;
			
			// create some metadata xml for the method
			var metadata1:XML =	<metadata name="Test">
									<arg key="someKey" value="this arg has a key that is not blank"/>
								</metadata>;
			// add the metadata to the method description
			nodeXML.appendChild( metadata1 );
			
			// create an xmlList out of the metadata
			var metadataXMLList:XMLList = new XMLList();
			metadataXMLList[0] = metadata1;
			
			// attempt to detect presence of a blank key
			var result:Boolean = MetadataTools.checkForValueInBlankMetaDataNode( nodeXML, "Test", "this arg has a blank key" );
			
			// verify that metadata with a blank key was found
			Assert.assertFalse( result );
		}
		
		[Test(description="Ensure metadata value is retrieved properly")]
		public function check_getArgValueFromMetaDataNode_key_exists():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod"></method>;
			
			// create some metadata xml for the method
			var metadata:XML =	<metadata name="Test">
									<arg key="description" value="this is my description"/>
								</metadata>;
			// add the metadata to the method description
			nodeXML.appendChild( metadata );
			
			// create an xmlList out of the metadata
			var metadataXMLList:XMLList = new XMLList();
			metadataXMLList[0] = metadata;
			
			// attempt to retrieve value from metadata using key
			var result:String = MetadataTools.getArgValueFromMetaDataNode( nodeXML, "Test", "description" );
			
			// verify that the returned metadata value is the value we expect
			Assert.assertEquals("this is my description", result);
		}
		
		// TODO : should the getArgValueFromMetaDataNode method by updated to ignore the
		// 		  case of the key entered? As of now, the case matters.
		/* [Test(description="Ensure metadata value is retrieved properly when key is in a different case")]
		public function check_getArgValueFromMetaDataNode_key_different_case_exists():void {
		// create a method xml description
		var nodeXML:XML = <method name="myTestMethod"></method>;
		
		// create some metadata xml for the method
		var metadata1:XML =	<metadata name="Test">
		<arg key="description" value="this is my description"/>
		</metadata>;
		// add the metadata to the method description
		nodeXML.appendChild( metadata1 );
		
		// create an xmlList out of the metadata
		var metadataXMLList:XMLList = new XMLList();
		metadataXMLList[0] = metadata1;
		
		// attempt to retrieve value from metadata using key
		var result:String = MetadataTools.getArgValueFromMetaDataNode( nodeXML, "Test", "DESCRIPTION" );
		
		// verify that the returned metadata value is the value we expect
		Assert.assertEquals("this is my description", result);
		} */
		
		[Test(description="Ensure metadata value is retrieved properly when key does not exist")]
		public function check_getArgValueFromMetaDataNode_key_does_not_exist():void {
			// create a method xml description
			var nodeXML:XML = <method name="myTestMethod"></method>;
			
			// create some metadata xml for the method
			var metadata1:XML =	<metadata name="Test">
									<arg key="description" value="this is my description"/>
								</metadata>;
			// add the metadata to the method description
			nodeXML.appendChild( metadata1 );
			
			// create an xmlList out of the metadata
			var metadataXMLList:XMLList = new XMLList();
			metadataXMLList[0] = metadata1;
			
			// attempt to retrieve value from metadata using key
			var result:String = MetadataTools.getArgValueFromMetaDataNode( nodeXML, "Test", "noKeyWithThisName" );
			
			// verify that the returned metadata value is null
			Assert.assertNull( result );
		}
		
		[Test(description="Ensure single metadata arg value is retrieved properly")]
		public function check_getArgValueFromSingleMetaDataNode_key_exists():void {
			// create some metadata xml for the method
			var metadata:XML =	<metadata name="Test">
									<arg key="description" value="this is my description"/>
									<arg key="async" value="some async value"/>
									<arg key="expects" value="this method really doesn't expect anything"/>
								</metadata>;
			
			// attempt to get arg value from a single metadata node
			var result:String = MetadataTools.getArgValueFromSingleMetaDataNode( metadata, "async" );
			
			// verify that the arg value that we expect is retrieved
			Assert.assertEquals("some async value", result);
		}
		
		[Test(description="Ensure single metadata arg value is retrieved properly when key does not exist")]
		public function check_getArgValueFromSingleMetaDataNode_key_does_not_exist():void {
			// create some metadata xml for the method
			var metadata:XML =	<metadata name="Test">
									<arg key="description" value="this is my description"/>
									<arg key="async" value="some async value"/>
									<arg key="expects" value="this method really doesn't expect anything"/>
								</metadata>;
			
			// attempt to get arg value from a single metadata node
			var result:String = MetadataTools.getArgValueFromSingleMetaDataNode( metadata, "noKeyWithThisName" );
			
			// verify that the returned arg value is null
			Assert.assertNull( result );
		}
		
		[Test(desciption="Ensure if a node has metadata with the matching name the xml is retrieved properly")]
		public function check_getArgsFromNode_metadataExists_valueExists() : void {
			var metadata:XML = 	<node>
									<metadata name="Before">
										<arg value="Not yet"/>
									</metadata>
									<metadata name="Test">
										<arg key="description" value="I exist"/>
									</metadata>
								</node>;
			
			
			var result:XML = MetadataTools.getArgsFromFromNode( metadata, 'Test' );
			
			Assert.assertEquals( "I exist", result.arg.@value );
			
		}
		
		[Test(desciption="Ensure if a node has metadata that does not match the name no xml is retrieved")]
		public function check_getArgsFromNode_metadataExists_valueDoesNotExist() : void {
			var metadata:XML = 	<node>
									<metadata name="Test">
										<arg key="description" value="I exist"/>
									</metadata>
								</node>;
			
			
			var result:XML = MetadataTools.getArgsFromFromNode( metadata, 'Before' );
			
			Assert.assertNull( result );
			
		}
		
		[Test(desciption="Ensure if a node does not have metadata that nothing is retrieved")]
		public function check_getArgsFromNode_metadataDoesNotExist() : void {
			var metadata:XML = 	<node name="Test">
									<arg key="description" value="I exist"/>
								</node>;
			
			
			var result:XML = MetadataTools.getArgsFromFromNode( metadata, 'Test' );
			
			Assert.assertNull( result );
			
		}
		
	}
}