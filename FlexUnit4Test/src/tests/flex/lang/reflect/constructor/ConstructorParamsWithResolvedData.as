package tests.flex.lang.reflect.constructor {
	import flex.lang.reflect.Constructor;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	
	import tests.flex.lang.reflect.constructor.helper.Constructor0ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor1ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor2ArgTestClass;


	/** This is a difficult class to test as it cannot be truly sepearated into a unit. Flash does not correctly
	 *  provide parameters type the first time it describes a class. You actually need to instantiate it once,
	 *  then it can provide correct data... so we need to check both of those behaviors in a much uglier way */
	public class ConstructorParamsWithResolvedData {
		
		[Test]
		public function shouldReturn0Args():void {
			var xml:XML = <constructor></constructor>;
			
			var constructor:Constructor = new Constructor( xml, null );
			assertNotNull( constructor.parameterTypes );
			assertEquals( 0, constructor.parameterTypes.length );
		}
	
		[Test]
		public function shouldReturn1Args():void {
			var xml:XML = <constructor><parameter index="1" type="int" optional="false"/></constructor>;
			
			var constructor:Constructor = new Constructor( xml, null );
			assertNotNull( constructor.parameterTypes );
			assertEquals( 1, constructor.parameterTypes.length );
		}
		
		[Test]
		public function shouldReturn2Args():void {
			var xml:XML = <constructor><parameter index="1" type="int" optional="false"/><parameter index="1" type="String" optional="false"/></constructor>;
			
			var constructor:Constructor = new Constructor( xml, null );
			assertNotNull( constructor.parameterTypes );
			assertEquals( 2, constructor.parameterTypes.length );
		}

		[Test]
		public function shouldReturnInt():void {
			var xml:XML = <constructor><parameter index="1" type="int" optional="false"/></constructor>;
			
			var constructor:Constructor = new Constructor( xml, null );
			assertNotNull( constructor.parameterTypes );
			assertEquals( int, constructor.parameterTypes[ 0 ] );
		}
		
		[Test]
		public function shouldReturnString():void {
			var xml:XML = <constructor><parameter index="1" type="int" optional="false"/><parameter index="1" type="String" optional="false"/></constructor>;
			
			var constructor:Constructor = new Constructor( xml, null );
			assertNotNull( constructor.parameterTypes );
			assertEquals( int, constructor.parameterTypes[ 0 ] );
			assertEquals( String, constructor.parameterTypes[ 1 ] );
		}
		
		[Test]
		public function shouldReturnNumber():void {
			var xml:XML = <constructor><parameter index="1" type="int" optional="false"/><parameter index="1" type="String" optional="false"/><parameter index="3" type="Number" optional="false"/></constructor>;
			
			var constructor:Constructor = new Constructor( xml, null );
			assertNotNull( constructor.parameterTypes );
			assertEquals( int, constructor.parameterTypes[ 0 ] );
			assertEquals( String, constructor.parameterTypes[ 1 ] );
			assertEquals( Number, constructor.parameterTypes[ 2 ] );
		}
	}
}
