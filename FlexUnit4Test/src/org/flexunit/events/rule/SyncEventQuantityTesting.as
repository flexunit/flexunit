package org.flexunit.events.rule {
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flexunit.framework.AssertionFailedError;
	
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.events.rule.EventRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;

	public class SyncEventQuantityTesting {
		
		[Rule]
		public var expectEvent:EventRule = new EventRule();

		[Test]
		public function shouldPassNever():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).never();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailNever():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).never();
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test]
		public function shouldPassNeverWrongEvent():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).never();
			sprite.dispatchEvent( new Event( "YoHo" ) );
		}

		
		
		[Test]
		public function shouldPassOnce():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).once();
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailOnceUnder():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).once();
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailOnceOver():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).once();
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		
		[Test]
		public function shouldPassTwice():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).twice();
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTwiceUnder():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).twice();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTwiceOver():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).twice();
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		

		[Test]
		public function shouldPassThrice():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).thrice();
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailThriceUnder():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).thrice();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailThriceOver():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).thrice();
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		
		
		[Test]
		public function shouldPassTimes():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).times( 4 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTimesUnder():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).times( 4 );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTimesOver():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).times( 4 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		
		[Test]
		public function shouldPassAtMost():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).atMost( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailAtMost():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).atMost( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		

		[Test]
		public function shouldPassLessThan():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).lessThan( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessThanEqivalent():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).lessThan( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessThanExceed():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).lessThan( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		
		
		[Test]
		public function shouldPassLessThanEqualUnder():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).lessThanOrEqualTo( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test]
		public function shouldPassLessThanEqual():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).lessThanOrEqualTo( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessThanEqual():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).lessThanOrEqualTo( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		
		[Test]
		public function shouldPassAtLeastEqual():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).atLeast( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test]
		public function shouldPassAtLeastExceed():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).atLeast( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessAtLeast():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).atLeast( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test]
		public function shouldPassGreaterThan():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).greaterThan( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailGreatThanEqiv():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).greaterThan( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailGreaterThanLess():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).greaterThan( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test]
		public function shouldPassGreaterThanEqual():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).greaterThanOrEqualTo( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test]
		public function shouldPassGreatThanEqualEqiv():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).greaterThanOrEqualTo( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailGreaterThanEqualLess():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).greaterThanOrEqualTo( 2 );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}
	}
}