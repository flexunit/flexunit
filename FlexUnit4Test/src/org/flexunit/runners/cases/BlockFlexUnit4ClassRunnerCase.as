package org.flexunit.runners.cases
{
	import org.flexunit.runners.BlockFlexUnit4ClassRunner;

	//TODO: This entire runner needs to have tests written for it
	
	public class BlockFlexUnit4ClassRunnerCase
	{
		protected var blockFlexUnit4ClassRunner:BlockFlexUnit4ClassRunner;
		
		[Before(description="Creates a BlockFlexUnit4ClassRunner")]
		public function createBlockFlexUnit4ClassRunner():void {
			//blockFlexUnit4ClassRunner = new BlockFlexUnit4ClassRunner();
		}
		
		[After(description="Destroys a BlockFlexUnit4ClassRunner")]
		public function destroyBlockFlexUnit4ClassRunner():void {
			blockFlexUnit4ClassRunner = null;
		}
		
		[Test]
		public function test():void {
			
		}
	}
}