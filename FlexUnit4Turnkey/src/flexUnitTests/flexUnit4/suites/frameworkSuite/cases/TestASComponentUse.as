/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 **/ 
package flexUnitTests.flexUnit4.suites.frameworkSuite.cases
{
	import flash.events.Event;
	
	import mx.controls.TextInput;
	import mx.events.FlexEvent;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	
    /**
     * @private
     */
	public class TestASComponentUse {
		protected var textInput:TextInput;
		
		[Before(async,ui)]
		public function setUp():void {
			//Create a textInput, add it to the testEnvironment. Wait until it is created, then run tests on it
			textInput = new TextInput();
			Async.proceedOnEvent( this, textInput, FlexEvent.CREATION_COMPLETE, 100 );
			//textInput.addEventListener( FlexEvent.CREATION_COMPLETE, Async.asyncHandler( this, handleSetupComplete, 100 ), false, 0, true );
			UIImpersonator.addChild( textInput );
		}
		
		[After(async,ui)]
		public function tearDown():void {
			UIImpersonator.removeChild( textInput );			
			textInput = null;

		}

		[Test(async,ui)]
	    public function testSetTextProperty() : void {

	    	var passThroughData:Object = new Object();
	    	passThroughData.propertyName = 'text';
	    	passThroughData.propertyValue = 'digitalprimates';
	    	
	    	textInput.addEventListener( FlexEvent.VALUE_COMMIT, Async.asyncHandler( this, handleVerifyProperty, 100, passThroughData, handleEventNeverOccurred ), false, 0, true );
	    	setProperty( textInput, passThroughData );
	    }

		[Test(async,ui)]
	    public function testSetHTMLTextProperty() : void {
	    	var passThroughData:Object = new Object();
	    	passThroughData.propertyName = 'htmlText';
	    	passThroughData.propertyValue = 'digitalprimates';
	    	
	    	textInput.addEventListener( "htmlTextChanged", Async.asyncHandler( this, handleVerifyProperty, 100, passThroughData, handleEventNeverOccurred ), false, 0, true );
	    	setProperty( textInput, passThroughData );
	    }

		[Test(async,ui)]
	    public function testSetEnabledTwiceProperty() : void {
	    	//A nice clear box test. The enabled property only emmits an event if it acutally changes. So, if enabled is set to true
	    	//I should not get an event
	    	var passThroughData:Object = new Object();
	    	passThroughData.propertyName = 'enabled';
	    	passThroughData.propertyValue = true;
	    	
	    	textInput.addEventListener( "enabledChanged", Async.asyncHandler( this, handleUnexpectedEvent, 100, passThroughData, handleExpectedTimeout ), false, 0, true );
	    	setProperty( textInput, passThroughData );
	    }

	    protected function setProperty( target:Object, passThroughData:Object ):void {
	    	target[ passThroughData.propertyName ] = passThroughData.propertyValue;
	    }
	    
	    protected function handleSetupComplete( event:FlexEvent, passThroughData:Object ):void {
	    	//This method will be called after the TextInput is created. The TextInput will be ready to use
	    	//before any of our test methods run
	    }

	    protected function handleVerifyProperty( event:Event, passThroughData:Object ):void {
	    	//This method will be called after the TextInput is created. The TextInput will be ready to use
	    	//before any of our test methods run
	    	Assert.assertEquals( event.target[ passThroughData.propertyName ], passThroughData.propertyValue );
	    }
	    
	    protected function handleEventNeverOccurred( passThroughData:Object ):void {
	    	Assert.fail('Pending Event Never Occurred');
	    }
	    
	    protected function handleUnexpectedEvent( event:Event, passThroughData:Object ):void {
	    	Assert.fail('Unexpected Event Received');
	    }
	    
	    protected function handleExpectedTimeout( passThroughData:Object ):void {
	    }
	}
}