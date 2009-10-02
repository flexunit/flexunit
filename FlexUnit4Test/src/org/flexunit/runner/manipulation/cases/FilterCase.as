package org.flexunit.runner.manipulation.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.manipulation.mocks.FilterableMock;
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;
	import org.flexunit.runner.manipulation.Filter;

	public class FilterCase
	{	
		//TODO: Ensure that these tests and this class are being implemented correctly
		
		[Test(description="Ensure that the filter is correctly instantiated with no parameters")]
		public function createFilterNoParamsTest():void {
			var filter:Filter = new Filter();
			
			Assert.assertNull(filter.shouldRun);
			Assert.assertNull(filter.describe);
		}
		
		[Test(description="Ensure that the filter is correctly instantiated with a shouldRun function")]
		public function createFilterShouldRunTest():void {
			var filter:Filter = new Filter(shouldRunTest);
			
			Assert.assertEquals( shouldRunTest, filter.shouldRun);
			Assert.assertNull(filter.describe);
		}
		
		[Test(description="Ensure that the filter is correctly instantiated with a shouldRun and describe function")]
		public function createFilterShouldRunAndDescribeTest():void {
			var filter:Filter = new Filter(shouldRunTest, describeTest);
			
			Assert.assertEquals( shouldRunTest, filter.shouldRun);
			Assert.assertEquals( describeTest, filter.describe);
		}
		
		//TODO: How would a negative case be created for an object that does not implement IFilterable?
		[Test(description="Ensure that the filter function is called on an object that implements IFilterable")]
		public function applyTest():void {
			var filter:Filter = new Filter();
			var filterableMock:FilterableMock = new FilterableMock();
			filterableMock.mock.method("filter").withArgs(filter).once;
			
			filter.apply(filterableMock);
			
			filterableMock.mock.verify();
		}
		
		//TODO: How can it be ensured that the default functions are correctly created?
		[Ignore("How can it be ensured that the default functions are correctly created?")]
		[Test(description="Ensure that the the default filter is being correctly created")]
		public function buildAllFilterTest():void {
			var filter:Filter = Filter.ALL;
			
			Assert.assertEquals(function( description:IDescription ):Boolean { return true; }, filter.shouldRun);
			Assert.assertEquals(function():String { return "all tests"; }, filter.describe);
		}

		
		public function shouldRunTest():void {
			// do something
		}
		
		public function describeTest():void {
			// do something
		}
	}
}