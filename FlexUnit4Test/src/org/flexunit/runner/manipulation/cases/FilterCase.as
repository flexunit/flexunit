package org.flexunit.runner.manipulation.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.manipulation.filters.DynamicFilter;
	import org.flexunit.runner.manipulation.filters.IncludeAllFilter;
	import org.flexunit.runner.manipulation.mocks.BasicFilterMock;

	public class FilterCase
	{	
		//import org.flexunit.runner.Description;
		//TODO: Ensure that these tests and this class are being implemented correctly
		[Test(expects="TypeError",description="Ensure that the filter fails to be instantiated with no parameters")]
		public function createFilterNoParamsTest():void {
			var filter:DynamicFilter = new DynamicFilter( null, null );
			
			Assert.assertNull(filter.shouldRun);
			Assert.assertNull(filter.describe);
		}
		
		[Test(description="Ensure that the filter is correctly instantiated with a shouldRun and describe function")]
		public function createFilterShouldRunTest():void {
			var description:IDescription = new Description( "test", new Array() );
			var basicFilterMock:BasicFilterMock = new BasicFilterMock();
			
			basicFilterMock.mock.method( "shouldRun" ).withArgs( description ).returns( true );
			basicFilterMock.mock.method( "describe" ).withArgs( description ).returns( "all" );

			var filter:DynamicFilter = new DynamicFilter( basicFilterMock.shouldRun, basicFilterMock.describe );
			
			Assert.assertEquals( true, filter.shouldRun( description ) );
			Assert.assertEquals( "all", filter.describe( description ) );
			
			basicFilterMock.mock.verify();
		}
		
/*		[Test(description="Ensure that the filter is correctly instantiated with a shouldRun and describe function")]
		public function createFilterShouldRunAndDescribeTest():void {
			var filter:Filter = new Filter(shouldRunTest, describeTest);
			
			Assert.assertEquals( shouldRunTest, filter.shouldRun);
			Assert.assertEquals( describeTest, filter.describe);
		}*/
		
		//TODO: How would a negative case be created for an object that does not implement IFilterable?
		[Ignore("This test needs to be revisited")]
		[Test(description="Ensure that the filter function is called on an object that implements IFilterable")]
		public function applyTest():void {
/*			var filter:Filter = new Filter();
			var filterableMock:FilterableMock = new FilterableMock();
			filterableMock.mock.method("filter").withArgs(filter).once;
			
			filter.apply(filterableMock);
			
			filterableMock.mock.verify();
*/		}
		
		//TODO: How can it be ensured that the default functions are correctly created?
/*		[Ignore("How can it be ensured that the default functions are correctly created?")]
		[Test(description="Ensure that the the default filter is being correctly created")]
		public function buildAllFilterTest():void {
			var filter:DynamicFilter = new IncludeAllFilter();
			
			Assert.assertEquals(function( description:IDescription ):Boolean { return true; }, filter.shouldRun);
			Assert.assertEquals(function():String { return "all tests"; }, filter.describe);
		}*/

		
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