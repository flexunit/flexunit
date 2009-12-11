package flex.lang.reflect.cases
{
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.Assert;

	public class MetadataCase
	{		
		// testable object						
		private var metaAnnotation : MetaDataAnnotation;
		
		// xml data to test with
		private var testMetaDataXML:XML; 
		
		[Before]
		public function setup():void {
			
		}
		
		[After]
		public function tearDown():void {
			
		}
		
		[Test(description="Constructs a MetaDataAnnotation and verifies that the async argument set on it is set correctly.")]
		public function checkAsyncAttributeSetToKeyOnMetaDataArgument() : void
		{
			testMetaDataXML = <metadata name="Test">				
								<arg key="" value="async"/>
							</metadata>;
				
			metaAnnotation = new MetaDataAnnotation( testMetaDataXML );
			
			var testArg : MetaDataArgument = metaAnnotation.arguments[0] as MetaDataArgument;
			
			Assert.assertTrue( testArg.key == "async" ); 
			
		}
		
		[Test(description="Constructs a MetaDataAnnotation and verifies that the arguments set on it are set correctly.")]
		public function checkAsyncAttributeSetToKeyOnMetaDataArgumentWhenSecondAttribute() : void
		{
			testMetaDataXML = <metadata name="Test">				
								<arg key="description" value="this is the first argument"/>
								<arg key="" value="async"/>
							</metadata>;
				
			metaAnnotation = new MetaDataAnnotation( testMetaDataXML );
			
			var testArg : MetaDataArgument = metaAnnotation.arguments[1] as MetaDataArgument;
			
			Assert.assertTrue( testArg.key == "async" ); 
			
		}
		
		//TODO: will fail currently until the method for defaultArgument changes
		[Ignore]
		[Test(description="Constructs a MetaDataAnnotation and verifies that the defaultArgument returned has the key of async.")]
		public function checkDefaultArgumentGetCorrectly() : void
		{
			testMetaDataXML = <metadata name="Test">				
								<arg key="description" value="this is the first argument"/>
								<arg key="" value="async"/>
							</metadata>;
				
			metaAnnotation = new MetaDataAnnotation( testMetaDataXML );
			
			var testArg : MetaDataArgument = metaAnnotation.defaultArgument;
			
			Assert.assertTrue( testArg.key == "async" && testArg.value == "true" ); 
			
		}
		
		[Test(description="check that MetaDataAnnotation returns that it has argument passed to it and not 'ui'.")]
		public function checkMetaDatahasArguments() : void
		{
			testMetaDataXML = <metadata name="Test">				
								<arg key="description" value="this is the first argument"/>
								<arg key="" value="async"/>
								<arg key="" value="ui"/>
								<arg key="order" value="3"/>
								<arg key="expects" value="flexunit.blah.Class"/>
								<arg key="timeout" value="100"/>
								
							</metadata>;
			
			metaAnnotation = new MetaDataAnnotation( testMetaDataXML );
			
			Assert.assertTrue( metaAnnotation.hasArgument( "async" ) ); 
			Assert.assertTrue( metaAnnotation.hasArgument( "description" ) );
			Assert.assertTrue( metaAnnotation.hasArgument( "ui" ) );
			Assert.assertTrue( metaAnnotation.hasArgument( "order" ) );
			Assert.assertTrue( metaAnnotation.hasArgument( "expects" ) );
			Assert.assertTrue( metaAnnotation.hasArgument( "timeout" ) );
			Assert.assertFalse( metaAnnotation.hasArgument( "issueID" ) );
			
			
		}
		
		[Test(description="check that MetaDataAnnotation returns the name given to it")]
		public function checkMetaDatahasGivenName() : void
		{
			testMetaDataXML = <metadata name="Test">				
								<arg key="description" value="this is a description"/>
								<arg key="" value="async"/>
							</metadata>;
			
			metaAnnotation = new MetaDataAnnotation( testMetaDataXML );
			
			Assert.assertTrue( metaAnnotation.name ==  "Test" ); 
			
		}
		
		[Test(description="check that MetaDataAnnotation returns the a value from getArgument when passed the string name of an existing argument.")]
		public function checkMetaDataGetArgumentsNotNull() : void
		{
			testMetaDataXML = <metadata name="Test">				
								<arg key="" value="async"/>
								<arg key="description" value="this is a description "/>
								<arg key="timeout" value="1000"/>								
							</metadata>;
			
			metaAnnotation = new MetaDataAnnotation( testMetaDataXML );
			
			Assert.assertNotNull( metaAnnotation.getArgument( "async" ) ); 
			Assert.assertNotNull( metaAnnotation.getArgument( "description" ) ); 
			Assert.assertNotNull( metaAnnotation.getArgument( "timeout" ) ); 
			
		}

		[Test(description="check that MetaDataAnnotation returns the name given to it")]
		public function checkRunWithDefaultArgIsClassName() : void
		{
			testMetaDataXML = <metadata name="RunWith">				
								<arg key="" value="test.folder.Class"/>
							</metadata>;
			
			metaAnnotation = new MetaDataAnnotation( testMetaDataXML );
			
			Assert.assertTrue( metaAnnotation.defaultArgument.key ==  "test.folder.Class" ); 
			
		}
		
	}
}