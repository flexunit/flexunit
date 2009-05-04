package flexUnitTests.flexUnit4.suites.frameworkSuite.theorySuite {
	import org.flexunit.assertThat;
	import org.flexunit.assumeThat;
	import org.flexunit.experimental.theories.Theories;
	import org.hamcrest.number.lessThan;
	import org.hamcrest.object.instanceOf;
	
	[RunWith("org.flexunit.experimental.theories.Theories")]
	public class TheorySuite {
		private var theory:Theories;
 
   		[DataPoints]
  		[ArrayElementType("Boolean")]
		public static var boolValues:Array = [true, false];

   		[DataPoints]
  		[ArrayElementType("String")]
		public static var stringValues:Array = ["one","two","three","four","five"];

   		[DataPoints]
  		[ArrayElementType("int")]
		public static var intValues:Array = [1,2,3,4,5,6,7,8,9];

   		[DataPoint]
		public static var values1:int = 10;
  		[DataPoint]
		public static var values2:int = 12;
 		[DataPoint]
		public static var str:String = "happy";
 		[DataPoint]
		public static var str2:String = "days";

   		[DataPoint]
		public static function getDataPoint():int {
			return 67;
		}

   		[DataPoints]
  		[ArrayElementType("int")]
		public static function provideData():Array {
			return [50,52,54,56];
		}

  		[Theory]
		public function testIntOnly( value:int ):void {
			assumeThat( value, lessThan( 10 ) );
			assertThat( value, instanceOf(int) );
			// test which involves int value	
			//trace( "      int case " + value );
		}		

   		[Theory]
		public function testStringOnly( value1:String ):void {
			// test which involves int value	
			//trace( "    string case " + value1 );
			assertThat( value1, instanceOf(String) );
		} 		

  		[Theory]
		public function testStringIntCombo( boolValue:Boolean, stringValue:String ):void {
			//trace( boolValue + " " + stringValue );
		} 	

		public function TheorySuite():void {
			//assumeThat( intValue, lessThan( 2 ) );
			//assumptions in constructor do not yet work... don't know if they ever could, what exactly would you do if you couldn't construct?
			//trace("Constructor with " + intValue );
		}
		
	}
}