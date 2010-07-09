package flexUnitTests.flexUnit4.suites.frameworkSuite.theorySuite
{
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertEquals;

	[RunWith("org.flexunit.experimental.theories.Theories")]
	public class TestTheoriesSuite
	{
		//*****************************************************
		//
		// Variables
		//
		//*****************************************************
		
		//String test variables
		protected static var testedStringArray : Array;
		protected static var testedTwoStringArray : Array;
		
		//Expected string results
		protected static var allStringValues : Array = ["one","two","three","four","five","happy","days"];
		protected static var allDoubledStringValues : Array;		
		
		//Int test variables
		protected static var testedIntArray : Array;
		protected static var testedTwoIntArray : Array;
		
		//Expected int results
		protected static var allIntValues : Array = [1,2,3,4,5,6,7,8,9,10,12,50,52,54,56,67];
		protected static var allTwoIntValues : Array;
		
		//Boolean test variables
		protected static var testedBooleanArray : Array;
		
		//Expected boolean results
		protected static var allBooleanValues : Array = [true, false];
		
		//Combo test variables
		protected static var testedComboArray : Array;
		
		//Expected combo results
		protected static var allComboArray : Array = ["true:one","true:two","true:three","true:four","true:five","true:happy","true:days",
			"false:one","false:two","false:three","false:four","false:five","false:happy","false:days"];
		
		//*****************************************************
		//
		// DataPoints
		//
		//*****************************************************
		
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
				

		//*****************************************************
		//
		// BeforeClass
		//
		//*****************************************************
		
		[BeforeClass]
		public static function setUpSingleStringTests() : void
		{
			testedStringArray = new Array();
		}
		
		[BeforeClass]
		public static function setUpDoubleStringTests() : void
		{
			testedTwoStringArray = new Array();
			allDoubledStringValues = new Array();
			
			for ( var i : int = 0; i < allStringValues.length; i++ )
			{
				for ( var k : int = 0; k < allStringValues.length; k++ )
				{
					allDoubledStringValues.push( allStringValues[i] + allStringValues[k] );
				}
			}
		}
		
		[BeforeClass]
		public static function setUpIntTest() : void
		{
			testedIntArray = new Array;
		}
		
		[BeforeClass]
		public static function setUpTwoIntTest() : void
		{
			testedTwoIntArray = new Array;
			allTwoIntValues = new Array();
			
			for ( var i : int = 0; i < allIntValues.length; i++ )
			{
				for ( var k : int = 0; k < allIntValues.length; k++ )
				{
					allTwoIntValues.push( allIntValues[i] + ":" + allIntValues[k] );
				}
			}
		}
		
		[BeforeClass]
		public static function setUpBooleanTest() : void
		{
			testedBooleanArray = new Array();
		}
		
		[BeforeClass]
		public static function setUpComboTest() : void
		{
			testedComboArray = new Array();
		}
		
		//*****************************************************
		//
		// AfterClass
		//
		//*****************************************************
		
		[AfterClass]
		public static function breakDownSingleStringTests() : void
		{
			var stringCount : int = 0;
			for ( var i : int = 0; i < testedStringArray.length; i++ )
			{
				if ( allStringValues.indexOf( testedStringArray[i] ) != -1 )
				{
					stringCount++;
				} else {
					Assert.fail("Test Theories Suite failed while testing the Single String tests.");
				}
			}
			
			assertEquals( stringCount, allStringValues.length );
			
			testedStringArray = null;
		}
		
		[AfterClass]
		public static function breakDownDoubleStringTests() : void
		{
			var stringCount : int = 0;
			for ( var i : int = 0; i < testedTwoStringArray.length; i++ )
			{
				if ( allDoubledStringValues.indexOf( testedTwoStringArray[i] ) != -1 )
				{
					stringCount++;
				} else {
					Assert.fail("Test Theories Suite failed while testing the Two String tests.");
				}
			}
			
			assertEquals( stringCount, allDoubledStringValues.length );
			
			testedTwoStringArray = null;
		}
		
		[AfterClass]
		public static function breakDownIntTest() : void
		{
			var intCount : int = 0;
			for ( var i : int = 0; i < testedIntArray.length; i++ )
			{
				if ( allIntValues.indexOf( testedIntArray[i] ) != -1 )
				{
					intCount++;
				} else {
					Assert.fail("Test Theories Suite failed while testing the single int tests.");
				}
			}
			
			assertEquals( intCount, allIntValues.length );
			
			testedIntArray = null;
		}
		
		[AfterClass]
		public static function breakDownTwoIntTests() : void
		{
			var twoIntCount : int = 0;
			for ( var i : int = 0; i < testedTwoIntArray.length; i++ )
			{
				if ( allTwoIntValues.indexOf( testedTwoIntArray[i] ) != -1 )
				{
					twoIntCount++;
				} else {
					Assert.fail("Test Theories Suite failed while testing the two int tests.");
				}
			}
			
			assertEquals( twoIntCount, allTwoIntValues.length );
			
			testedTwoIntArray = null;
		}
		
		[AfterClass]
		public static function breakDownBooleanTest() : void
		{
			var booleanCount : int = 0;
			for ( var i : int = 0; i < testedBooleanArray.length; i++ )
			{
				if ( allBooleanValues.indexOf( testedBooleanArray[i] ) != -1 )
				{
					booleanCount++;
				} else {
					Assert.fail("Test Theories Suite failed while testing the boolean tests.");
				}
			}
			
			assertEquals( booleanCount, allBooleanValues.length );
			
			testedBooleanArray = null;
		}
		
		[AfterClass]
		public static function breakDownComboTest() : void
		{
			var comboCount : int = 0;
			for ( var i : int = 0; i < testedComboArray.length; i++ )
			{
				if ( allComboArray.indexOf( testedComboArray[i] ) != -1 )
				{
					comboCount++;
				} else {
					Assert.fail("Test Theories Suite failed while testing the combo tests.");
				}
			}
			
			assertEquals( comboCount, allComboArray.length );
			
			testedComboArray = null;
		}
		
		//*****************************************************
		//
		// Theories
		//
		//*****************************************************
		
		[Theory]
		public function testStringOnly( value1:String ):void {
			testedStringArray.push( value1 );
		} 		
		
		[Theory]
		public function testTwoStrings( value1:String, value2:String ):void {
			testedTwoStringArray.push( value1 + value2 );
		} 		
		
		[Theory]
		public function testIntOnly( value1:int ):void {
			testedIntArray.push( value1 );
		}		
		
		[Theory]
		public function testTwoInt( value1:int, value2:int ):void {
			testedTwoIntArray.push( value1 + ":" + value2 );
		}		
		
		[Theory]
		public function testBooleanOnly( value1 : Boolean ) : void
		{
			testedBooleanArray.push( value1 );
		}
		
		[Theory]
		public function testStringIntCombo( boolValue:Boolean, stringValue:String ):void {
			trace( "boolValue: ", boolValue, "stringValue: ", stringValue );
			var arrayStr : String = boolValue.toString() + ":" + stringValue;
			testedComboArray.push( arrayStr );
		} 	
		
		[Ignore]
		[Theory]
		public function testIgnoreMetadata( value1 : Boolean ) : void
		{
			Assert.assertTrue( false );
		}
	}
}