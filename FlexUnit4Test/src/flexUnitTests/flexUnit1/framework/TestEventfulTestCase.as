/*
   Copyright (c) 2008. Adobe Systems Incorporated.
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

     * Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
     * Neither the name of Adobe Systems Incorporated nor the names of its
       contributors may be used to endorse or promote products derived from this
       software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.
*/

package flexUnitTests.flexUnit1.framework
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   import flexunit.framework.AssertionFailedError;
   import flexunit.framework.EventfulTestCase;
   
   public class TestEventfulTestCase extends EventfulTestCase
   {      
      public function TestEventfulTestCase( name : String = null )
      {
         super( name );
      }
      
      override public function setUp() : void
      {
      	eventDispatcher = new EventDispatcher();
      }
            
      public function testAssertEventsExpected() : void
   	{
         listenForEvent( eventDispatcher, "eventName" );           
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
            
         assertEvents();
   	}

      public function testListenForMultipleEventsExpected() : void
   	{
         listenForEvent( eventDispatcher, "eventName" );           
         listenForEvent( eventDispatcher, "eventName2" );
                    
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
         eventDispatcher.dispatchEvent( new Event( "eventName2" ) );
            
         assertEvents();
   	}
   	
       public function testListenForMultipleEventsExpectedDispatchedInDifferentOrder() : void
   	{
         listenForEvent( eventDispatcher, "eventName" );           
         listenForEvent( eventDispatcher, "eventName2" );
                    
         eventDispatcher.dispatchEvent( new Event( "eventName2" ) );
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
            
         assertEvents();
   	}  	
   	
      public function testAssertEventsNotExpected() : void
   	{
         listenForEvent( eventDispatcher, "eventName", EVENT_UNEXPECTED );           
         eventDispatcher.dispatchEvent( new Event( "differentEventName" ) );
            
         assertEvents();
   	}

      public function testAssertEventsExpectedAndNotExpected() : void
   	{
         listenForEvent( eventDispatcher, "eventName" );           
         listenForEvent( eventDispatcher, "eventName2", EVENT_UNEXPECTED );     
               
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
            
         assertEvents();
   	}

      public function testAssertEventsExpectedAndNotExpectedWithOtherEventsDispatched() : void
   	{
         listenForEvent( eventDispatcher, "eventName" );           
         listenForEvent( eventDispatcher, "eventName2", EVENT_UNEXPECTED );     
               
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
         eventDispatcher.dispatchEvent( new Event( "differentEventName" ) );
            
         assertEvents();
   	}
   	
   	public function testGetDispatchedExpctedEvents() : void
   	{
         listenForEvent( eventDispatcher, "eventName" );           
         listenForEvent( eventDispatcher, "eventName2" );           
         listenForEvent( eventDispatcher, "eventName3", EVENT_UNEXPECTED );     
         
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
         eventDispatcher.dispatchEvent( new Event( "eventName2" ) );
         eventDispatcher.dispatchEvent( new Event( "differentEventName" ) );
            
         assertEvents();
         
         assertEquals( 2, dispatchedExpectedEvents.length );         
   	}
   	
   	public function testGetLastDispatchedExpctedEvents() : void
   	{
         listenForEvent( eventDispatcher, "eventName" );           
         listenForEvent( eventDispatcher, "eventName2" );           
         listenForEvent( eventDispatcher, "eventName3", EVENT_UNEXPECTED );     
         
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
         eventDispatcher.dispatchEvent( new Event( "eventName2" ) );
         eventDispatcher.dispatchEvent( new Event( "differentEventName" ) );
            
         assertEvents();
         
         assertEquals( "eventName2", lastDispatchedExpectedEvent.type );
         
   	}
   	
      public function testAssertEventsExpectedNoDispatch() : void
   	{
   		try
   		{
         	listenForEvent( eventDispatcher, "eventName" );           

         	assertEvents();         	
     		}
     		catch ( e : AssertionFailedError )
     		{
     			return;
     		}	
         fail ( "Should have throw an AssertionFailedError" );
   	}

      public function testAssertEventsExpectedWrongDispatch() : void
   	{
   		try
   		{
         	listenForEvent( eventDispatcher, "eventName" );           
         	listenForEvent( eventDispatcher, "eventName2", EVENT_UNEXPECTED );           
            
         	eventDispatcher.dispatchEvent( new Event( "eventName2" ) );
            
         	assertEvents();         	
     		}
     		catch ( e : AssertionFailedError )
     		{
     			return;
     		}	
         fail ( "Should have throw an AssertionFailedError" );
   	}

      public function testAssertEventsExpectedNoDispatchComplex() : void
   	{
   		try
   		{
         	listenForEvent( eventDispatcher, "eventName" );           
         	listenForEvent( eventDispatcher, "eventName2" );           
         	listenForEvent( eventDispatcher, "eventName3", EVENT_UNEXPECTED );           
            
         	eventDispatcher.dispatchEvent( new Event( "eventName" ) );
            
         	assertEvents();         	
     		}
     		catch ( e : AssertionFailedError )
     		{
     			return;
     		}	
         fail ( "Should have throw an AssertionFailedError" );
   	}
   	   	
      public function testAssertEventsNoListeners() : void
   	{
         eventDispatcher.dispatchEvent( new Event( "eventName" ) );
            
         assertEvents();
   	}
   	   	
   	private var eventDispatcher : EventDispatcher;
   }
}
