package tests.flex.lang.reflect.metadata.metaDataAnnotation {
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class AnnotationWithValidData {
		[Test]
		public function shouldReturnName():void {
			var xml:XML = <metadata name="annotationName"/>; 
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );

			assertEquals( "annotationName", annotation.name );
		}

		[Test]
		public function shouldReturnZeroArguments():void {
			var xml:XML = <metadata name="annotationName"/>; 
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertEquals( 0, annotation.arguments.length );
		}

		[Test]
		public function shouldReturnTwoArguments():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;

			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertEquals( 2, annotation.arguments.length );
		}

		[Test]
		public function shouldReturnDefaultArgument():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="" value="one"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertEquals( "one", annotation.defaultArgument.key );
		}

		[Test]
		public function shouldReturnDefaultArgumentInDifferentOrder():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="two" value="2"/>
							<arg key="" value="one"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertEquals( "one", annotation.defaultArgument.key );
		}

		[Test]
		public function shouldFindMetaData():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertTrue( annotation.hasArgument( "one" ) );
		}

		[Test]
		public function shouldNotFindMetaData():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertFalse( annotation.hasArgument( "three" ) );
		}

		[Test]
		public function shouldReturnMetaData():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertEquals( "one", annotation.getArgument( "one" ).key );
		}

		[Test]
		public function shouldReturnNullForMissingMeta():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertNull( annotation.getArgument( "three" ) );
		}

		[Test]
		public function shouldFindMetaDataCaseInsensitive():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="tWo" value="2"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertTrue( annotation.hasArgument( "TwO", true ) );
		}

		[Test]
		public function shouldReturnMetaDataCaseInsensitive():void {
			var xml:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="tWo" value="2"/>
						  </metadata>;
			
			var annotation:MetaDataAnnotation = new MetaDataAnnotation( xml );
			
			assertEquals( "tWo", annotation.getArgument( "TwO", true ).key );
		}

		[Test]
		public function shouldBeEqualWithNoArgs():void {
			var xml1:XML = <metadata name="annotationName"/>;
			var xml2:XML = <metadata name="annotationName"/>;
			
			var annotation1:MetaDataAnnotation = new MetaDataAnnotation( xml1 );
			var annotation2:MetaDataAnnotation = new MetaDataAnnotation( xml2 );
			
			assertTrue( annotation1.equals( annotation2 ) );
		}

		[Test]
		public function shouldNotBeEqualWithNoArgs():void {
			var xml1:XML = <metadata name="annotationName1"/>;
			var xml2:XML = <metadata name="annotationName2"/>;
			
			var annotation1:MetaDataAnnotation = new MetaDataAnnotation( xml1 );
			var annotation2:MetaDataAnnotation = new MetaDataAnnotation( xml2 );
			
			assertFalse( annotation1.equals( annotation2 ) );
		}

		[Test]
		public function shouldBeEqualWithArgs():void {
			var xml1:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;

			var xml2:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;

			var annotation1:MetaDataAnnotation = new MetaDataAnnotation( xml1 );
			var annotation2:MetaDataAnnotation = new MetaDataAnnotation( xml2 );
			
			assertTrue( annotation1.equals( annotation2 ) );
		}

		[Test]
		public function shouldNotBeEqualComparerWithMoreArgs():void {
			var xml1:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var xml2:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
						  </metadata>;
			
			var annotation1:MetaDataAnnotation = new MetaDataAnnotation( xml1 );
			var annotation2:MetaDataAnnotation = new MetaDataAnnotation( xml2 );
			
			assertFalse( annotation1.equals( annotation2 ) );
		}

		[Test]
		public function shouldNotBeEqualCompareeWithMoreArgs():void {
			var xml1:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
						  </metadata>;
			
			var xml2:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var annotation1:MetaDataAnnotation = new MetaDataAnnotation( xml1 );
			var annotation2:MetaDataAnnotation = new MetaDataAnnotation( xml2 );
			
			assertFalse( annotation1.equals( annotation2 ) );
		}

		[Test]
		public function shouldNotBeEqualSameArgCountWithDifferentValue():void {
			var xml1:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="-2"/>
						  </metadata>;
			
			var xml2:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var annotation1:MetaDataAnnotation = new MetaDataAnnotation( xml1 );
			var annotation2:MetaDataAnnotation = new MetaDataAnnotation( xml2 );
			
			assertFalse( annotation1.equals( annotation2 ) );
		}

		[Test]
		public function shouldNotBeEqualDifferentOrder():void {
			var xml1:XML = <metadata name="annotationName">
							<arg key="one" value="1"/>
							<arg key="two" value="2"/>
						  </metadata>;
			
			var xml2:XML = <metadata name="annotationName">
							<arg key="two" value="2"/>
							<arg key="one" value="1"/>
						  </metadata>;
			
			var annotation1:MetaDataAnnotation = new MetaDataAnnotation( xml1 );
			var annotation2:MetaDataAnnotation = new MetaDataAnnotation( xml2 );
			
			assertFalse( annotation1.equals( annotation2 ) );
		}
	}
}