package org.flexunit.events.rule.cases {
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
	
	public class AsyncEventQuantityTesting {
		
		[Rule]
		public var expectEvent:EventRule = new EventRule();
		
		[Test]
		public function shouldPassNever():void {
			var timer:Timer = new Timer( 5, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				never();
			
			//timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailNever():void {
			var timer:Timer = new Timer( 5, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				never();
			
			timer.start();
		}
		
		[Test]
		public function shouldPassOnce():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				once();
			
			timer.start();
		}
		
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailOnceUnder():void {
			var timer:Timer = new Timer( 5, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				once();
			
			//timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailOnceOver():void {
			var timer:Timer = new Timer( 5, 2);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				once();
			
			timer.start();
		}
		
		
		[Test]
		public function shouldPassTwice():void {
			var timer:Timer = new Timer( 5, 2);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				twice();
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTwiceUnder():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				twice();
			
			timer.start();
			
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTwiceOver():void {
			var timer:Timer = new Timer( 5, 3);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				twice();
			
			timer.start();
		}
		
		
		[Test]
		public function shouldPassThrice():void {
			var timer:Timer = new Timer( 5, 3);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				thrice();
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailThriceUnder():void {
			var timer:Timer = new Timer( 5, 2);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				thrice();
			
			timer.start();
			
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailThriceOver():void {
			var timer:Timer = new Timer( 5, 4);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				thrice();
			
			timer.start();
			
		}
		
		
		
		[Test]
		public function shouldPassTimes():void {
			var timer:Timer = new Timer( 5, 4 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				times(4);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTimesUnder():void {
			var timer:Timer = new Timer( 5, 3 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				times(4);
			
			timer.start();
			
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailTimesOver():void {
			var timer:Timer = new Timer( 5, 5 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				times(4);
			
			timer.start();
		}
		
		
		[Test]
		public function shouldPassAtMost():void {
			var timer:Timer = new Timer( 5, 2 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				atMost(2);
			
			timer.start();
		}
		
		[Test]
		public function shouldPassAtMostUnder():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				atMost(2);
			
			timer.start();
		}		
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailAtMost():void {
			var timer:Timer = new Timer( 5, 3 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				atMost(2);
			
			timer.start();
		}
		
		
		[Test]
		public function shouldPassLessThan():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				lessThan(2);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessThanEqivalent():void {
			var timer:Timer = new Timer( 5, 2 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				lessThan(2);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessThanExceed():void {
			var timer:Timer = new Timer( 5, 3 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				lessThan(2);
			
			timer.start();
		}
		
		
		
		[Test]
		public function shouldPassLessThanEqualUnder():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				lessThanOrEqualTo(2);
			
			timer.start();
		}
		
		[Test]
		public function shouldPassLessThanEqual():void {
			var timer:Timer = new Timer( 5, 2 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				lessThanOrEqualTo(2);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessThanEqual():void {
			var timer:Timer = new Timer( 5, 3 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				lessThanOrEqualTo(2);
			
			timer.start();
		}
		
		
		[Test]
		public function shouldPassAtLeastEqual():void {
			var timer:Timer = new Timer( 5, 2 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				atLeast(2);
			
			timer.start();
		}
		
		[Test]
		public function shouldPassAtLeastExceed():void {
			var timer:Timer = new Timer( 5, 3 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				atLeast(2);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailLessAtLeast():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				atLeast(2);
			
			timer.start();
		}
		
		[Test]
		public function shouldPassGreaterThan():void {
			var timer:Timer = new Timer( 5, 3 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				greaterThan(2);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailGreatThanEqiv():void {
			var timer:Timer = new Timer( 5, 2 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				greaterThan(2);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailGreaterThanLess():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				greaterThan(2);
			
			timer.start();
		}
		
		[Test]
		public function shouldPassGreaterThanEqual():void {
			var timer:Timer = new Timer( 5, 3 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				greaterThanOrEqualTo(2);
			
			timer.start();
		}
		
		[Test]
		public function shouldPassGreatThanEqualEqiv():void {
			var timer:Timer = new Timer( 5, 2 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				greaterThanOrEqualTo(2);
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailGreaterThanEqualLess():void {
			var timer:Timer = new Timer( 5, 1 );
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER ).
				withTimeout( 100 ).
				greaterThanOrEqualTo(2);
			
			timer.start();
		}
	}
}