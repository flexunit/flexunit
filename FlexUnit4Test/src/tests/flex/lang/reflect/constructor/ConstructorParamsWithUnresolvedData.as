package tests.flex.lang.reflect.constructor {
	import flex.lang.reflect.Constructor;
	import flex.lang.reflect.Klass;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	
	import tests.flex.lang.reflect.constructor.helper.Constructor0ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor1ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor2ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.Constructor3ArgTestClass;
	import tests.flex.lang.reflect.constructor.helper.ConstructorUndefinedArgTestClass;

	/** This is the least unit style of the unit tests but until we can mock this better, it is our best choice **/ 
	public class ConstructorParamsWithUnresolvedData {

		[Test]
		public function shouldReturnFoundParameters():void {
			var klass:Klass = new Klass( ConstructorUndefinedArgTestClass );

			var xml:XML = <constructor>
							<parameter index="1" type="*" optional="true"/>
							<parameter index="2" type="*" optional="true"/>
							<parameter index="3" type="*" optional="true"/>
						  </constructor>;

			var constructor:Constructor = new Constructor( xml, klass );

			assertNotNull( constructor.parameterTypes );
			assertEquals( int, constructor.parameterTypes[ 0 ] );
			assertEquals( String, constructor.parameterTypes[ 1 ] );
			assertEquals( Number, constructor.parameterTypes[ 2 ] );
		}
	}
}
