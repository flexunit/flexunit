package tests.org.flexunit.runner.util {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.utils.DescriptionUtil;
	
	import tests.flex.lang.reflect.klass.KlassWithInvalidData;

	public class DescriptionUtilTest {
		[Test]
		public function shouldFindNameWhenStandardTest():void {
			var desc:IDescription = Description.createTestDescription( KlassWithInvalidData, "tests.flex.lang.reflect.klass::KlassWithInvalidData.shouldFindZeroFields" );
			assertEquals( "shouldFindZeroFields", DescriptionUtil.getMethodNameFromDescription( desc ) );
		}

		[Test]
		public function shouldFindNameWhenParameterizedTest():void {
			var desc:IDescription = Description.createTestDescription( KlassWithInvalidData, "tests.flex.lang.reflect.klass::KlassWithInvalidData.shouldFindZeroFields (5,3)" );
			assertEquals( "shouldFindZeroFields", DescriptionUtil.getMethodNameFromDescription( desc ) );
		}

		[Test]
		public function shouldFindNameWhenParameterizedTestWithDots():void {
			var desc:IDescription = Description.createTestDescription( KlassWithInvalidData, "tests.flex.lang.reflect.klass::KlassWithInvalidData.shouldFindZeroFields (5.7,3.4)" );
			assertEquals( "shouldFindZeroFields", DescriptionUtil.getMethodNameFromDescription( desc ) );
		}

		[Test]
		public function shouldFindNameWhenParameterizedTestWithSpaces():void {
			var desc:IDescription = Description.createTestDescription( KlassWithInvalidData, "tests.flex.lang.reflect.klass::KlassWithInvalidData.shouldFindZeroFields (5,3, 5)" );
			assertEquals( "shouldFindZeroFields", DescriptionUtil.getMethodNameFromDescription( desc ) );
		}
	}
}