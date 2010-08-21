package tests.flex.lang.reflect.constructor {
	import flex.lang.reflect.Constructor;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	
	import tests.flex.lang.reflect.constructor.helper.Constructor0ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor1ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor2ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor3ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.StubKlass;

	public class ConstructorWithStubKlass {
		
		[Test]
		public function shouldInstantiate3ArgClassWithAllArgs():void {
			var xml:XML = <constructor>
							<parameter index="1" type="int" optional="true"/>
							<parameter index="2" type="String" optional="true"/>
							<parameter index="3" type="Number" optional="true"/>
						  </constructor>;

			var stubKlass:StubKlass = new StubKlass( Constructor3ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			//Test the pass through from newInstance() to newInstanceApply()
			var instance:* = constructor.newInstance( 1, "test", 5.5 );
			
			assertTrue( instance is Constructor3ArgTestClass );
			assertEquals( 1, ( instance as Constructor3ArgTestClass ).arg1 );
			assertEquals( "test", ( instance as Constructor3ArgTestClass ).arg2 );
			assertEquals( 5.5, ( instance as Constructor3ArgTestClass ).arg3 );
		}

		[Test]
		public function shouldInstantiate0ArgClassByApply():void {
			var xml:XML = <constructor></constructor>;
			var stubKlass:StubKlass = new StubKlass( Constructor0ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstanceApply( null );
			
			assertTrue( instance is Constructor0ArgTestClass );
		} 

		[Test(expects="ArgumentError")]
		public function shouldFailToInstantiateWithTooManyArgs():void {
			var xml:XML = <constructor></constructor>;
			var stubKlass:StubKlass = new StubKlass( Constructor0ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstance( 1 );
		} 

		[Test(expects="ArgumentError")]
		public function shouldFailToInstantiateWithTooFewArgs():void {
			var xml:XML = <constructor></constructor>;
			var stubKlass:StubKlass = new StubKlass( Constructor2ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstance( 1 );
		} 
		
		[Test]
		public function shouldInstantiate1ArgClassByApply():void {
			var xml:XML = <constructor><parameter index="1" type="int" optional="false"/></constructor>;
			var stubKlass:StubKlass = new StubKlass( Constructor1ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstanceApply( [ 1 ] );
			
			assertTrue( instance is Constructor1ArgTestClass );
			assertEquals( 1, ( instance as Constructor1ArgTestClass ).arg1 );
		}
		
		[Test]
		public function shouldInstantiate2ArgClassByApply():void {
			var xml:XML = <constructor>
							<parameter index="1" type="int" optional="false"/>
							<parameter index="2" type="String" optional="false"/>
						  </constructor>;
			
			var stubKlass:StubKlass = new StubKlass( Constructor2ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstanceApply( [ 1, "test" ] );
			
			assertTrue( instance is Constructor2ArgTestClass );
			assertEquals( 1, ( instance as Constructor2ArgTestClass ).arg1 );
			assertEquals( "test", ( instance as Constructor2ArgTestClass ).arg2 );
		}
		
		[Test]
		public function shouldInstantiate3ArgClassWithAllArgsByApply():void {
			var xml:XML = <constructor>
							<parameter index="1" type="int" optional="true"/>
							<parameter index="2" type="String" optional="true"/>
							<parameter index="3" type="Number" optional="true"/>
						  </constructor>;
			
			var stubKlass:StubKlass = new StubKlass( Constructor3ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstanceApply( [ 1, "test", 5.5 ] );
			
			assertTrue( instance is Constructor3ArgTestClass );
			assertEquals( 1, ( instance as Constructor3ArgTestClass ).arg1 );
			assertEquals( "test", ( instance as Constructor3ArgTestClass ).arg2 );
			assertEquals( 5.5, ( instance as Constructor3ArgTestClass ).arg3 );
		}
		
		[Test]
		public function shouldInstantiate3ArgClassWithSomeArgsByApply():void {
			var xml:XML = <constructor>
							<parameter index="1" type="int" optional="true"/>
							<parameter index="2" type="String" optional="true"/>
							<parameter index="3" type="Number" optional="true"/>
						  </constructor>;
			
			var stubKlass:StubKlass = new StubKlass( Constructor3ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstanceApply( [ 9 ] );
			
			assertTrue( instance is Constructor3ArgTestClass );
			assertEquals( 9, ( instance as Constructor3ArgTestClass ).arg1 );
			assertEquals( "testMe", ( instance as Constructor3ArgTestClass ).arg2 );
			assertEquals( 3.5, ( instance as Constructor3ArgTestClass ).arg3 );
		}

		[Test]
		public function shouldInstantiateWithOnlyRequiredArgs():void {
			var xml:XML = <constructor>
							<parameter index="1" type="int" optional="true"/>
							<parameter index="2" type="String" optional="true"/>
							<parameter index="3" type="Number" optional="true"/>
						  </constructor>;
			
			var stubKlass:StubKlass = new StubKlass( Constructor3ArgTestClass );
			
			var constructor:Constructor = new Constructor( xml, stubKlass );
			var instance:* = constructor.newInstance();
			
			assertTrue( instance is Constructor3ArgTestClass );
			assertEquals( 0, ( instance as Constructor3ArgTestClass ).arg1 );
			assertEquals( "testMe", ( instance as Constructor3ArgTestClass ).arg2 );
			assertEquals( 3.5, ( instance as Constructor3ArgTestClass ).arg3 );
		}
		
	}
}