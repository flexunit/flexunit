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
	
	import flexUnitTests.flexUnit4.suites.frameworkSuite.cases.valueObject.Person;
	
	import org.flexunit.Assert;
	import org.fluint.sequence.SequenceBindingWaiter;
	import org.fluint.sequence.SequenceRunner;
	import org.fluint.sequence.SequenceSetter;

    /**
     * @private
     */
	public class TestBindingUse {
		protected static var SHORT_TIME:int = 50;

		protected var person:Person;
		
		[Before]
		public function setUp():void {
			person = new Person();
		}
		
		[After]
		public function tearDown():void {
			person = null;
		}

		[Test(async)]
	    public function testSetPropertySuccess() : void {
	    	var passThroughData:Object = new Object();
	    	passThroughData.firstName = 'mike';
	    	passThroughData.lastName = 'labriola';

			//set firstName, listen for firstName change
			//set lastName, listen for lastName change
	    	var sequence:SequenceRunner = new SequenceRunner( this );
	    	
	    	with ( sequence ) {
				addStep( new SequenceSetter( person, {firstName:passThroughData.firstName} ) );
				addStep( new SequenceBindingWaiter( person, 'firstName', SHORT_TIME ) );
	
				addStep( new SequenceSetter( person, {lastName:passThroughData.lastName} ) );
				addStep( new SequenceBindingWaiter( person, 'lastName', SHORT_TIME ) );
				
				addAssertHandler( handlePropertySetEvent, passThroughData );
				
				run();	    		
	    	}
	    }

		[Test(async)]
	    public function testSetNonPropertyChangeEventProperty() : void {
	    	var passThroughData:Object = new Object();
	    	passThroughData.age = 400;

			//set firstName, listen for firstName change
			//set lastName, listen for lastName change
	    	var sequence:SequenceRunner = new SequenceRunner( this );

	    	with ( sequence ) {
				addStep( new SequenceSetter( person, {age:passThroughData.age} ) );
				addStep( new SequenceBindingWaiter( person, 'age', SHORT_TIME ) );
				
				addAssertHandler( handlePropertySetEvent, passThroughData );
				
				run();
	    	}
	    }

		//This test case is valid, but I need to find a way to test it within the right context
		[Test(async)]
	    public function testSetPropertyFail() : void {
	    	var passThroughData:Object = new Object();
	    	passThroughData.firstName = 'mike';
	    	passThroughData.lastName = 'labriola';

			//This time we set the firstName property but wait for the lastName
	    	var sequence:SequenceRunner = new SequenceRunner( this );

			with ( sequence ) {
				addStep( new SequenceSetter( person, {firstName:passThroughData.firstName} ) );
				addStep( new SequenceBindingWaiter( person, 'firstName', SHORT_TIME ) );

				addStep( new SequenceSetter( person, {firstName:passThroughData.lastName} ) );
				addStep( new SequenceBindingWaiter( person, 'lastName', SHORT_TIME, handlePropertyShouldFailTimeOut ) );

				addAssertHandler( handleShouldNotGetHere, passThroughData );
			
				run();
			}
	    }

		[Test(async)]
	    public function testLastNameTimeOut() : void {
	    	var passThroughData:Object = new Object();
	    	passThroughData.firstName = 'mike';
	    	passThroughData.lastName = 'labriola';

			//This time we set the firstName property but wait for the lastName
	    	var sequence:SequenceRunner = new SequenceRunner( this );

			with ( sequence ) {
				addStep( new SequenceSetter( person, {firstName:passThroughData.firstName} ) );
				addStep( new SequenceBindingWaiter( person, 'firstName', SHORT_TIME ) );

				//addStep( new SequenceSetter( person, {firstName:passThroughData.lastName} ) );
				addStep( new SequenceBindingWaiter( person, 'lastName', SHORT_TIME, handlePropertyShouldFailTimeOut ) );

				addAssertHandler( handleShouldNotGetHere, passThroughData );
			
				run();
			}
	    }

	    protected function handlePropertySetEvent( event:Event, passThroughData:Object ):void {
	    	//trace("Property Changed Event Occurred " + event.type );
	    	Assert.assertEquals( passThroughData.firstName, event.target.firstName );
	    }

	    protected function handleShouldNotGetHere( event:Event, passThroughData:Object ):void {
	    	Assert.fail( "Test should have timed out");
	    }
	    
	    protected function handlePropertyShouldFailTimeOut( passThroughData:Object ):void {
	    	//Property timed out correctly
	    }
	}
}