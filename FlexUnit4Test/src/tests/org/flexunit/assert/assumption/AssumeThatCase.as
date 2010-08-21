package tests.org.flexunit.assert.assumption {
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.flexunit.Assume;
	import org.flexunit.assumeThat;
	import org.hamcrest.Matcher;
	import org.hamcrest.object.equalTo;

	public class AssumeThatCase {
		[Rule]
		public var mockolate:MockolateRule = new MockolateRule();
		
		[Mock]
		public var matcher:Matcher; 
		
		[Test]
		public function shouldPassUsingFunction() : void {
			var value:int = 5;
			
			stub( matcher ).method( "matches" ).args( value ).returns( true );
			assumeThat( value, matcher );
		}

		[Test(expects="org.flexunit.internals.AssumptionViolatedException")]
		public function shouldFailUsingFunction() : void {
			var value:int = 5;
			
			stub( matcher ).method( "matches" ).args( value ).returns( false );

			assumeThat( value, matcher );
		}
		
		[Test]
		public function shouldPassUsingStaticClass() : void {
			var value:int = 5;
			
			stub( matcher ).method( "matches" ).args( value ).returns( true );
			Assume.assumeThat( value, matcher );
		}
		
		[Test(expects="org.flexunit.internals.AssumptionViolatedException")]
		public function shouldFailUsingStaticClass() : void {
			var value:int = 5;
			
			stub( matcher ).method( "matches" ).args( value ).returns( false );
			
			Assume.assumeThat( value, matcher );
		}
	}
}
