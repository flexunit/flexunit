package org.flexunit.events.rule {
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flexunit.async.Async;
	import org.flexunit.events.rule.EventRule;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.isTrue;

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
		
		[Test(async)]
		public function shouldPassCallMethod():void {
			var calledObject:Object = {};
			var timer1:Timer = new Timer( 10, 1);
			var timer2:Timer = new Timer( 100, 1);
			
			expectEvent.from( timer1 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 50 ).calls(
				function( event:Event ):void {
					calledObject.called = true;
				}
			);
			
			Async.handleEvent( this, 
							   timer2, 
							   TimerEvent.TIMER_COMPLETE, 
							   function( TimerEvent:Event, data:Object ):void {
								   assertThat( calledObject.called, isTrue() );
							   }, 
							   200, calledObject ); 
			timer1.start();
			timer2.start();
		}
		
		[Test(async)]
		public function shouldPassCallMethods():void {
			var calledObject:Object = {};
			var timer1:Timer = new Timer( 10, 1);
			var timer2:Timer = new Timer( 10, 1);
			var timer3:Timer = new Timer( 100, 1);
			
			expectEvent.from( timer1 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 50 ).calls(
					function( event:Event ):void {
						calledObject.called1 = true;
					}
				);

			expectEvent.from( timer2 ).
				hasType( TimerEvent.TIMER_COMPLETE ).
				withTimeout( 50 ).calls(
					function( event:Event ):void {
						calledObject.called2 = true;
					}
				);
			
			Async.handleEvent( this, 
				timer3, 
				TimerEvent.TIMER_COMPLETE, 
				function( TimerEvent:Event, data:Object ):void {
					assertThat( calledObject.called1, isTrue() );
					assertThat( calledObject.called2, isTrue() );
				}, 
				200, calledObject ); 

			timer1.start();
			timer2.start();
			timer3.start();
		}
		
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