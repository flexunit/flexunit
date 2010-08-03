package tests.org.flexunit.token
{
	import org.flexunit.Assert;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.token.AsyncTestToken;
	import org.flexunit.token.ChildResult;

	public class ChildResultCase
	{
		[Test]
		public function shouldReturnProvidedToken():void {
			var token:AsyncTestToken = new AsyncTestToken();
			var childResult:ChildResult = new ChildResult( token );
			
			assertStrictlyEquals( token, childResult.token );
			assertNull( childResult.error );
		}
		
		[Test]
		public function shouldReturnProvidedError():void {
			var error:Error = new Error();
			var childResult:ChildResult = new ChildResult( null, error );
			
			assertStrictlyEquals( error, childResult.error );
			assertNull( childResult.token );
		}
	}
}