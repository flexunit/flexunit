package tests.flex.lang.reflect.metadata.metaDataArgument {
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class ArgumentWithValidData {
		[Test]
		public function shouldReturnKey():void {
			var xml:XML = <arg key="theKey" value="theValue"/>; 
			var argument:MetaDataArgument = new MetaDataArgument( xml );
			
			assertEquals( "theKey", argument.key );
		}

		[Test]
		public function shouldReturnValue():void {
			var xml:XML = <arg key="theKey" value="theValue"/>; 
			var argument:MetaDataArgument = new MetaDataArgument( xml );
			
			assertEquals( "theValue", argument.value );
		}

		[Test]
		public function shouldReturnValueAsKey():void {
			var xml:XML = <arg key="" value="async"/>; 
			var argument:MetaDataArgument = new MetaDataArgument( xml );
			
			assertEquals( "async", argument.key );
		}

		[Test]
		public function shouldReturnValueAsTrue():void {
			var xml:XML = <arg key="" value="async"/>; 
			var argument:MetaDataArgument = new MetaDataArgument( xml );
			
			assertEquals( "true", argument.value );
		}

		[Test]
		public function shouldBeUnpaired():void {
			var xml:XML = <arg key="" value="async"/>; 
			var argument:MetaDataArgument = new MetaDataArgument( xml );
			
			assertTrue( argument.unpaired );
		}

		[Test]
		public function shouldNotBeUnpaired():void {
			var xml:XML = <arg key="theKey" value="theValue"/>; 
			var argument:MetaDataArgument = new MetaDataArgument( xml );
			
			assertFalse( argument.unpaired );
		}
		
		[Test]
		public function shouldBeEqualArguments():void {
			var xml1:XML = <arg key="theKey" value="theValue"/>;
			var xml2:XML = <arg key="theKey" value="theValue"/>;

			var argument1:MetaDataArgument = new MetaDataArgument( xml1 );
			var argument2:MetaDataArgument = new MetaDataArgument( xml2 );
			
			assertTrue( argument1.equals( argument2 ) );
		}

		[Test]
		public function shouldNotBeEqualArgumentsBecauseOfKey():void {
			var xml1:XML = <arg key="theKey1" value="theValue"/>;
			var xml2:XML = <arg key="theKey2" value="theValue"/>;
			
			var argument1:MetaDataArgument = new MetaDataArgument( xml1 );
			var argument2:MetaDataArgument = new MetaDataArgument( xml2 );
			
			assertFalse( argument1.equals( argument2 ) );
		}

		[Test]
		public function shouldNotBeEqualArgumentsBecauseOfValue():void {
			var xml1:XML = <arg key="theKey" value="theValue1"/>;
			var xml2:XML = <arg key="theKey" value="theValue2"/>;
			
			var argument1:MetaDataArgument = new MetaDataArgument( xml1 );
			var argument2:MetaDataArgument = new MetaDataArgument( xml2 );
			
			assertFalse( argument1.equals( argument2 ) );
		}

		[Test]
		public function shouldNotBeEqualArgumentsBecauseOfMultiple():void {
			var xml1:XML = <arg key="theKey1" value="theValue1"/>;
			var xml2:XML = <arg key="theKey2" value="theValue2"/>;
			
			var argument1:MetaDataArgument = new MetaDataArgument( xml1 );
			var argument2:MetaDataArgument = new MetaDataArgument( xml2 );
			
			assertFalse( argument1.equals( argument2 ) );
		}
	}
}