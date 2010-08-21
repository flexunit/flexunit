package tests.org.flexunit.assert.that {
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.flexunit.assertThat;
	import org.hamcrest.Matcher;
	import org.hamcrest.number.greaterThan;

	public class AssertThatCase {
		[Rule]
		public var mockolate:MockolateRule = new MockolateRule();
		
		[Mock]
		public var matcher:Matcher; 

		[Test]
		public function shouldPass() : void {
			var value:int = 5;
			
			stub( matcher ).method( "matches" ).args( value ).returns( true );
			
			assertThat( value, matcher );
		}
		
		[Test(expects="org.hamcrest.AssertionError")]
		public function shouldFail() : void {
			var value:int = 5;
			
			stub( matcher ).method( "matches" ).args( value ).returns( false );
			
			assertThat( value, matcher );
		}
	}
}