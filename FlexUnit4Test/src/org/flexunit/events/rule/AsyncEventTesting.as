package org.flexunit.events.rule {
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.events.rule.EventRule;
	import org.hamcrest.object.instanceOf;

	public class AsyncEventTesting {
		
		[Rule]
		public var expectEvent:EventRule = new EventRule();
		
		[Test]
		public function shouldPassEvent():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
						hasType( TimerEvent.TIMER_COMPLETE ).
						withTimeout( 100 );

			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailNoEvent():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 50 );
		}
		
		[Test]
		public function shouldPassType():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				instanceOf( TimerEvent );

			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailType():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				instanceOf( DataEvent );
			
			timer.start();
		}
		
/*		[Test]
		public function shouldPassCallMethod():void {
			var called:Boolean = false;
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				instanceOf( DataEvent );

			expectEvent.from( timer ).hasType( "Yo" ).calls(
				function( event:Event ):void {
					called = true;
				}
			);
			
			timer.start();
			assertThat( called, isTrue() );
		}*/
		
/*		[Test]
		public function shouldPassCallMethods():void {
			var called1:Boolean = false;
			var called2:Boolean = false;
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).hasType( "Yo" ).
				calls( function( event:Event ):void {
					called1 = true; 
				} ).
				calls( function( event:Event ):void {
					called2 = true;
				} );
			
			sprite.dispatchEvent( new Event( "Yo" ) );
			assertThat( called1, isTrue() );
			assertThat( called2, isTrue() );
		}*/
		
		[Test]
		public function shouldPassWithPropertyValue():void {
			var timer:Timer = new Timer( 10, 1);

			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasPropertyWithValue( "target", timer ) ;
			
			timer.start();
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertyValue():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasPropertyWithValue( "target", this ) ;
			
			timer.start();
		}
		
		[Test]
		public function shouldPassWithPropertyMatcher():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasPropertyWithValue( "target", instanceOf( Timer ) ) ;
			
			timer.start();			
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertyMatcher():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasPropertyWithValue( "target", instanceOf( Number ) ) ;
			
			timer.start();			
		}
		
		
		//hasProperties
		[Test]
		public function shouldPassWithPropertiesValue():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasProperties( {target:timer, type:TimerEvent.TIMER_COMPLETE} ) ;
			
			timer.start();	
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertiesValue():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasProperties( {target:timer, type:'Nothing'} ) ;
			
			timer.start();	
		}
		
		[Test]
		public function shouldPassWithPropertiesMatcher():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasProperties( {target:timer, type:instanceOf( String )} ) ;
			
			timer.start();	
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertiesMatcher():void {
			var timer:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasProperties( {target:timer, type:instanceOf( Number )} ) ;
			
			timer.start();	
		}
		
		[Test]
		public function shouldPassWithMultipleEventsPassing():void {
			var timer1:Timer = new Timer( 10, 1);
			var timer2:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer1 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 );

			expectEvent.from( timer2 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 );
			
			timer1.start();	
			timer2.start();	
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithAnyFailure():void {
			var timer1:Timer = new Timer( 10, 1);
			var timer2:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer1 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 );
			
			expectEvent.from( timer2 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasPropertyWithValue( "target", null );
			
			timer1.start();	
			timer2.start();	
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithBothFailure():void {
			var timer1:Timer = new Timer( 10, 1);
			var timer2:Timer = new Timer( 10, 1);
			
			expectEvent.from( timer1 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasPropertyWithValue( "target", null );
			
			expectEvent.from( timer2 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 100 ).
				hasPropertyWithValue( "target", null );
			
			timer1.start();	
			timer2.start();	
		}
		
	}
}