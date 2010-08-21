package tests.org.flexunit.utils {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.utils.ClassNameUtil;

	public class ClassNameUtilCase {
		
		[Test]
		public function shouldReplacePeriods():void {
			var name:String = ClassNameUtil.getLoggerFriendlyClassName( FlexUnitCore );
			
			assertTrue( name.length > 0 );
			assertTrue( name.indexOf( "FlexUnitCore" ) > 0 );
			assertEquals( -1, name.indexOf( "." ) );
		}

		[Test]
		public function shouldReplaceColons():void {
			var name:String = ClassNameUtil.getLoggerFriendlyClassName( FlexUnitCore );
			
			assertTrue( name.length > 0 );
			assertTrue( name.indexOf( "FlexUnitCore" ) > 0 );
			assertEquals( -1, name.indexOf( "::" ) );
		}

		[Test]
		public function shouldReplaceDollarSigns():void {
			var name:String = ClassNameUtil.getLoggerFriendlyClassName( InternalTestClass );
			
			assertTrue( name.length > 0 );
			assertTrue( name.indexOf( "InternalTestClass" ) > 0 );
			assertEquals( -1, name.indexOf( "$" ) );
		}
	}
}

class InternalTestClass {
	
}
