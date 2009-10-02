package org.flexunit.runner.manipulation.cases
{
	import org.flexunit.Assert;
	import org.flexunit.internals.builders.FlexUnit4Builder;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.manipulation.mocks.SortableMock;
	import org.flexunit.runner.mocks.DescriptionMock;
	import org.flexunit.runners.Suite;
	import org.flexunit.runner.manipulation.Sorter;

	public class SorterCase
	{
		//TODO: Ensure that this test case is being implemented correctly
		
		protected var sorter:Sorter;
		protected var comparatorCalled:int = 0;
		
		[Before(description="Create an instance of the Sorter Class")]
		public function createSorter():void {
			comparatorCalled = 0;
			sorter = new Sorter( compareFunction );
		}
		
		[After(description="Destroy the reference to the Sorter Class")]
		public function destroySorter():void {
			sorter = null;
		}
		
		//TODO: How would a test be created for a non-sortable object?  A mock with a sort method that is tested to see that it
		//is never called?
		[Test(description="Ensure that the apply method will attempt to sort a class that implements ISorable")]
		public function applyTest():void {
			var sortableMock:SortableMock = new SortableMock();
			sortableMock.mock.method("sort").withArgs(sorter).once;
			
			sorter.apply(sortableMock);
			
			sortableMock.mock.verify();
		}
		
		[Test(description="Ensure that the comparator function is called")]
		public function compareTest():void  {
			var d1:DescriptionMock = new DescriptionMock();
			var d2:DescriptionMock = new DescriptionMock();
			
			sorter.compare(d1, d2);
			Assert.assertEquals( 1, comparatorCalled );
		}
		
		protected function compareFunction( d1:IDescription, d2:IDescription ):int {
			comparatorCalled++;
			return 0;
		}
	}
}