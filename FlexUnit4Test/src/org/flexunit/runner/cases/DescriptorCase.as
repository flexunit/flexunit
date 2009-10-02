package org.flexunit.runner.cases
{
	
	import org.flexunit.Assert;
	import org.flexunit.runner.Descriptor;

	public class DescriptorCase
	{
		//TODO: Ensure that these tests and this test case are being implemented correctly
		
		[Test(description="Ensure the Descriptor is successfully created with no parameters being passed")]
		public function createDescriptorNoParamsTest():void {
			var descriptor:Descriptor = new Descriptor();
			
			Assert.assertEquals("", descriptor.path);
			Assert.assertEquals("", descriptor.suite);
			Assert.assertEquals("", descriptor.method);
		}
		
		[Test(description="Ensure the Descriptor is successfully created with one parameter being passed")]
		public function createDescriptorOneParamTest():void {
			var descriptor:Descriptor = new Descriptor("a");
			
			Assert.assertEquals("a", descriptor.path);
			Assert.assertEquals("", descriptor.suite);
			Assert.assertEquals("", descriptor.method);
		}
		
		[Test(description="Ensure the Descriptor is successfully created with two parameters being passed")]
		public function createDescriptorTwoParamsTest():void {
			var descriptor:Descriptor = new Descriptor("a", "b");
			
			Assert.assertEquals("a", descriptor.path);
			Assert.assertEquals("b", descriptor.suite);
			Assert.assertEquals("", descriptor.method);
		}
		
		[Test(description="Ensure the Descriptor is successfully created with all parameters being passed")]
		public function createDescriptorAllParamsTest():void {
			var descriptor:Descriptor = new Descriptor("a", "b", "c");
			
			Assert.assertEquals("a", descriptor.path);
			Assert.assertEquals("b", descriptor.suite);
			Assert.assertEquals("c", descriptor.method);
		}
	}
}