package org.flexunit.runner.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.internals.requests.ClassRequest;
	import org.flexunit.internals.requests.FilterRequest;
	import org.flexunit.internals.requests.SortingRequest;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Request;
	import org.flexunit.runner.manipulation.mocks.FilterMock;
	import org.flexunit.runner.manipulation.mocks.SortMock;
	import org.flexunit.runner.manipulation.mocks.SortableMock;
	import org.flexunit.runner.mocks.DescriptionMock;
	import org.flexunit.runner.mocks.RunnerMock;
	import org.flexunit.runners.Suite;
	
	use namespace classInternal;

	public class RequestCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		protected var request:Request;
		
		[Before(description="Create an instance of Request")]
		public function createRequest():void {
			request = new Request();
		}
		
		[After(description="Destroy the reference to the Request instance")]
		public function destroyRequest():void {
			request = null;
		}
		
		[Test(description="Ensure that the setter / getter correctly sets and retrieves the sort value")]
		public function setGetSortTest():void {
			var sortMock:SortMock = new SortMock();
			
			request.sort = sortMock;
			
			Assert.assertEquals( sortMock, request.sort);
		}
		
		[Test(description="Ensure that the getter for iRunner returns an instance of an IRunner")]
		public function getIRunnerTest():void {
			//Call the static function runner in order to get an instance of a request with a runner
			var runnerMock:RunnerMock = new RunnerMock();
			request._runner = runnerMock;
			
			Assert.assertEquals( runnerMock, request.iRunner );
		}
		
		//Tests the deprecated function
		[Test(description="Ensure that the getRunner function returns the same IRunner that the get iRunner function does")]
		public function getRunnerTest():void {
			//Call the static function runner in order to get an instance of a request with a runner
			var runnerMock:RunnerMock = new RunnerMock();
			request._runner = runnerMock;
			
			Assert.assertEquals( runnerMock, request.iRunner );
		}
		
		// TODO : not sure how to test
		[Test(description="Ensure that the filerWith function generates the correct filter when the parameter implements IDescription")]
		public function filterWithIDescriptionTest():void {
			var desc:DescriptionMock = new DescriptionMock();
			
			var newRequest:Request = request.filterWith( desc );
			
			Assert.assertTrue( newRequest is FilterRequest );
		}
		
		// TODO : not sure how to test
		[Test(description="Ensure that the filerWith function generates the correct filter when the parameter is a Filter")]
		public function filterWithFilterTest():void {
			var filter:FilterMock = new FilterMock( shouldRunTest, describeTest ) ;
			
			var newRequest:Request = request.filterWith( filter );
			
			Assert.assertTrue( newRequest is FilterRequest );
		}
		
		[Test(description="Ensure that the filterWith function returns the current request if the parameter is not a Filter or does not implement IDescription")]
		public function filterWithNoIDescriptoinOrFilterTest():void {
			var newRequest:Request = request.filterWith( new Object() );
			
			Assert.assertEquals( request, newRequest );
		}
		
		[Test(description="Ensure that the sortWith function returns an instance of a SortRequest")]
		public function sortWithTest():void {
			var comparator:Function = new Function();
			
			var newRequest:Request = request.sortWith(comparator);
			
			Assert.assertTrue( newRequest is SortingRequest );
		}
		
		[Test(description="Ensure that the aClass function returns an instance of a ClassRequest")]
		public function aClassTest():void {
			Assert.assertTrue( Request.aClass(Object) is ClassRequest );
		}
		
		//TODO: Ensure that this test is testing this function in the proper manner
		[Test(description="Ensure that the classes function returns a Request that has a Suite as its runner")]
		public function classesTest():void {
			var newRequest:Request = Request.classes(new Array());
			
			Assert.assertTrue( newRequest.iRunner is Suite );
		}
		
		//TODO: Ensure that this test is testing this function in the proper manner
		[Test(description="Ensure that the runner function returns a Request that contains the passed IRunner parameter")]
		public function runnerTest():void {
			var runnerMock:RunnerMock = new RunnerMock();
			var newRequest:Request = Request.runner(runnerMock);
			
			Assert.assertEquals( runnerMock, newRequest.iRunner );
		}
		
		//TODO: How can this static function be correctly tested
		[Test(description="Ensure that the method function returns an instance of a ClassRequest that is filtered")]
		public function methodTest():void {
			var newRequest:Request = Request.method(Object, "toString");
			
			Assert.assertTrue( newRequest is FilterRequest );
		}

		public function shouldRunTest( description:IDescription ):Boolean {
			// do something
			return true;
		}
		
		public function describeTest( description:IDescription ):String {
			// do something
			return "any";
		}
		
	}
}