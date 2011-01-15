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

	public class SyncEventTesting {
		
		[Rule]
		public var expectEvent:EventRule = new EventRule();

		[Test]
		public function shouldPassEvent():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailNoEvent():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" );
			sprite.dispatchEvent( new Event( "YoYo" ) );
		}

		[Test]
		public function shouldPassType():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).instanceOf( DataEvent );
			sprite.dispatchEvent( new DataEvent( "Yo" ) );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailType():void {
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).instanceOf( DataEvent );
			sprite.dispatchEvent( new Event( "Yo" ) );
		}

		[Test]
		public function shouldPassCallMethod():void {
			var called:Boolean = false;
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).calls(
					function( event:Event ):void {
						called = true;
					}
				);

			sprite.dispatchEvent( new Event( "Yo" ) );
			assertThat( called, isTrue() );
		}

		[Test]
		public function shouldPassCallMethods():void {
			var called1:Boolean = false;
			var called2:Boolean = false;
			var sprite:Sprite = new Sprite();
			
			expectEvent.from( sprite ).hasType( "Yo" ).
				calls( function( event:Event ):void {
					called1 = true; 
				} ).
				calls( function( event:Event ):void {
					called2 = true;
				} );
			
			sprite.dispatchEvent( new Event( "Yo" ) );
			assertThat( called1, isTrue() );
			assertThat( called2, isTrue() );
		}

		[Test]
		public function shouldPassWithPropertyValue():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasPropertyWithValue( "data", "test1" );
			
			sprite.dispatchEvent( ev1 );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertyValue():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasPropertyWithValue( "data", "test2" );
			
			sprite.dispatchEvent( ev1 );
		}

		[Test]
		public function shouldPassWithPropertyMatcher():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasPropertyWithValue( "data", instanceOf( String ) );
			
			sprite.dispatchEvent( ev1 );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertyMatcher():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );

			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasPropertyWithValue( "data", instanceOf( Number ) );
			
			sprite.dispatchEvent( ev1 );
		}

		
		//hasProperties
		[Test]
		public function shouldPassWithPropertiesValue():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasProperties( { type:"Yo", data:"test1" } );
			
			sprite.dispatchEvent( ev1 );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertiesValue():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasProperties( { type:"Yo", data:"test2" } );
			
			sprite.dispatchEvent( ev1 );
		}
		
		[Test]
		public function shouldPassWithPropertiesMatcher():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasProperties( { type:"Yo", data:instanceOf( String ) } );
			
			sprite.dispatchEvent( ev1 );
		}
		
		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithPropertiesMatcher():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo", false, false, "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo" ).
				hasProperties( { type:"Yo", data:instanceOf( Number ) } );
			
			sprite.dispatchEvent( ev1 );
		}
		
		[Test]
		public function shouldPassWithMultipleEventsPassing():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo1", false, false, "test1" );
			var ev2:DataEvent = new DataEvent( "Yo2", false, false, "test2" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo1" ).
				hasPropertyWithValue( "data", "test1" );

			expectEvent.
				from( sprite ).
				hasType( "Yo2" ).
				hasPropertyWithValue( "data", "test2" );

			sprite.dispatchEvent( ev1 );
			sprite.dispatchEvent( ev2 );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithAnyFailure():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo1", false, false, "test1" );
			var ev2:DataEvent = new DataEvent( "Yo2", false, false, "test2" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo1" ).
				hasPropertyWithValue( "data", "test1" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo2" ).
				hasPropertyWithValue( "data", "test1" );
			
			sprite.dispatchEvent( ev1 );
			sprite.dispatchEvent( ev2 );
		}

		[Test(expects="flexunit.framework.AssertionFailedError")]
		public function shouldFailWithBothFailure():void {
			var sprite:Sprite = new Sprite();
			var ev1:DataEvent = new DataEvent( "Yo1", false, false, "test1" );
			var ev2:DataEvent = new DataEvent( "Yo2", false, false, "test2" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo1" ).
				hasPropertyWithValue( "data", "test2" );
			
			expectEvent.
				from( sprite ).
				hasType( "Yo2" ).
				hasPropertyWithValue( "data", "test1" );
			
			sprite.dispatchEvent( ev1 );
			sprite.dispatchEvent( ev2 );
		}
	}
}