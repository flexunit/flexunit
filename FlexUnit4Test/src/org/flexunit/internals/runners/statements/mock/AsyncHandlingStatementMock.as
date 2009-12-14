package org.flexunit.internals.runners.statements.mock
{
	import com.anywebcam.mock.Mock;
	
	import flash.events.Event;
	
	import mx.rpc.IResponder;
	
	import org.flexunit.internals.runners.statements.IAsyncHandlingStatement;
	import org.fluint.sequence.SequenceRunner;
	
	public class AsyncHandlingStatementMock implements IAsyncHandlingStatement
	{
		public var mock:Mock;
		
		public function get bodyExecuting():Boolean
		{
			return mock.bodyExecuting;
		}
		
		public function asyncHandler(eventHandler:Function, timeout:int, passThroughData:Object=null, timeoutHandler:Function=null):Function
		{
			return mock.asyncHandler(eventHandler, timeout, passThroughData, timeoutHandler);
		}
		
		public function asyncErrorConditionHandler(eventHandler:Function):Function
		{
			return mock.asyncErrorConditionHandler(eventHandler);
		} 
		
		CONFIG::useFlexClasses
		public function asyncResponder(responder:*, timeout:int, passThroughData:Object=null, timeoutHandler:Function=null):IResponder
		{
			return mock.asyncResponder(responder, timeout, passThroughData, timeoutHandler);
		}
		
		CONFIG::useFlexClasses
		public function handleBindableNextSequence(event:Event, sequenceRunner:SequenceRunner):void
		{
			mock.handleBindableNextSequence(event, sequenceRunner);
		}
		
		public function failOnComplete(event:Event, passThroughData:Object):void
		{
			mock.failOnComplete(event, passThroughData);
		}
		
		public function pendUntilComplete(event:Event, passThroughData:Object=null):void
		{
			mock.pendUntilComplete(event, passThroughData);
		}
		
		public function handleNextSequence(event:Event, sequenceRunner:SequenceRunner):void
		{
			mock.handleNextSequence(event, sequenceRunner);
		}
		
		public function AsyncHandlingStatementMock()
		{
			mock = new Mock(this);
		}
	}
}