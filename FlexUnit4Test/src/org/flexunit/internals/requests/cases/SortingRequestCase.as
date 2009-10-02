package org.flexunit.internals.requests.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.requests.SortingRequest;
	import org.flexunit.runner.mocks.RequestMock;
	import org.flexunit.runner.mocks.RunnerMock;

	public class SortingRequestCase
	{
		//TODO: Ensure that this test and this test case are being implemented correctly
		
		protected var sortingRequest:SortingRequest;
		protected var requestMock:RequestMock;
		protected var comparator:Function;
		
		[Before(description="Create an instance of SortingRequest")]
		public function createSortingRequest():void {
			requestMock = new RequestMock();
			comparator = new Function();
			sortingRequest = new SortingRequest(requestMock, comparator);
		}
		
		[After(description="Remove the reference to the instance of the SortingRequest")]
		public function destroySortingRequest():void {
			sortingRequest = null;
			requestMock = null;
			comparator = null
		}
		
		[Test(description="Ensure that the get iRunner function returns an iRunner")]
		public function getIRunnerTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			requestMock.mock.property("iRunner").returns(runnerMock);
			
			Assert.assertEquals( runnerMock, sortingRequest.iRunner );
		}
	}
}