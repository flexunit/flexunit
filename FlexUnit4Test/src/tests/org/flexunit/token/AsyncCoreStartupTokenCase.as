package tests.org.flexunit.token {
	import mockolate.runner.MockolateRule;
	import mockolate.stub;
	
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.runner.IRunner;
	import org.flexunit.token.AsyncCoreStartupToken;
	
	import tests.org.flexunit.token.helper.PendingStub;

	public class AsyncCoreStartupTokenCase {
		[Rule]
		public var mockolate:MockolateRule = new MockolateRule();
		
		[Mock]
		public var pendingMock:PendingStub;
		
		[Mock]
		public var runner:IRunner;
		
		[Test]
		public function shouldStoreAndRetrieveIRunner():void {
			var token:AsyncCoreStartupToken = new AsyncCoreStartupToken();

			token.runner = runner;

			assertStrictlyEquals( runner, token.runner );
		}
		
		[Test]
		public function shouldNotCrashWithNoMethodEntries():void {
			var token:AsyncCoreStartupToken = new AsyncCoreStartupToken();
			token.sendReady();
		}

		[Test]
		public function shouldReturnReferenceToToken():void {
			var token:AsyncCoreStartupToken = new AsyncCoreStartupToken();
			assertStrictlyEquals( token, token.addNotificationMethod( null ) );
		}

		[Test]
		public function shouldNotifySingleMethodEntry():void {
			var token:AsyncCoreStartupToken = new AsyncCoreStartupToken();
			
			token.runner = runner;

			stub( pendingMock ).method("notifyMe").args( runner ).once();

			token.addNotificationMethod( pendingMock.notifyMe );
			token.sendReady();
		}

		[Test]
		public function shouldNotifyThreeMethodEntries():void {
			var token:AsyncCoreStartupToken = new AsyncCoreStartupToken();
			
			token.runner = runner;
			
			stub( pendingMock ).method("notifyMe").args( runner ).thrice();
			
			token.addNotificationMethod( pendingMock.notifyMe );
			token.addNotificationMethod( pendingMock.notifyMe );
			token.addNotificationMethod( pendingMock.notifyMe );

			token.sendReady();
		}

	}
}