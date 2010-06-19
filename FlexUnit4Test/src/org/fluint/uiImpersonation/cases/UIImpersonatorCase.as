package org.fluint.uiImpersonation.cases
{
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	import org.flexunit.asserts.assertEquals;
	import org.fluint.uiImpersonation.UIImpersonator;

	public class UIImpersonatorCase
	{
		//We need to figure out a way to support both Flex use cases.. 
		//UIComponents and lower level sprites gracefully... today it isn't graceful 
		private var uiComponent0:UIComponent;
		private var uiComponent1:UIComponent;
		private var uiComponent2:UIComponent;

		[Before]
		public function createSprites():void {
			uiComponent0 = new UIComponent();
			uiComponent1 = new UIComponent();
			uiComponent2 = new UIComponent();
		}
		
		[After]
		public function cleanupAndDestroy():void {
			UIImpersonator.removeAllChildren();

			uiComponent0 = null;
			uiComponent1 = null;
			uiComponent2 = null;

		}
		
		[Test(description="")]
		public function addChildTest():void {
			var numChildren:int = UIImpersonator.numChildren; 
			
			UIImpersonator.addChild( uiComponent0 );
			
			assertEquals( numChildren+1, UIImpersonator.numChildren );
		}
		
		[Test(description="")]
		public function addChildAtTest():void {

			UIImpersonator.addChild( uiComponent1 );
			
			//Add at the beginning
			UIImpersonator.addChildAt( uiComponent2, 0 );
			
			assertEquals( 0, UIImpersonator.getChildIndex( uiComponent2 ) );
			assertEquals( 1, UIImpersonator.getChildIndex( uiComponent1 ) );
			
			//Add in the middle
			UIImpersonator.addChildAt( uiComponent0, 1 );
			assertEquals( 1, UIImpersonator.getChildIndex( uiComponent0 ) );
			assertEquals( 0, UIImpersonator.getChildIndex( uiComponent2 ) );
			assertEquals( 2, UIImpersonator.getChildIndex( uiComponent1 ) );
		}
		
		[Test(description="")]
		public function removeChildTest():void {

			assertEquals( 0, UIImpersonator.numChildren );

			UIImpersonator.addChild( uiComponent0 );
			assertEquals( 1, UIImpersonator.numChildren );

			UIImpersonator.removeChild( uiComponent0 );
			assertEquals( 0, UIImpersonator.numChildren );
		}
		
		[Test(description="")]
		public function removeChildAtTest():void {
			UIImpersonator.addChild( uiComponent0 );
			UIImpersonator.addChild( uiComponent1 );
			UIImpersonator.addChild( uiComponent2 );
			
			assertEquals( 3, UIImpersonator.numChildren );
			assertEquals( uiComponent1, UIImpersonator.removeChildAt( 1 ) );

			assertEquals( 2, UIImpersonator.numChildren );
			assertEquals( uiComponent0, UIImpersonator.removeChildAt( 0 ) );

			assertEquals( 1, UIImpersonator.numChildren );
			assertEquals( uiComponent2, UIImpersonator.removeChildAt( 0 ) );
		}
		
		[Test(description="")]
		public function removeAllChildrenTest():void {
			
			UIImpersonator.addChild( uiComponent0 );
			UIImpersonator.removeAllChildren();
			assertEquals( 0, UIImpersonator.numChildren );

			UIImpersonator.addChild( uiComponent1 );
			UIImpersonator.addChild( uiComponent2 );
			UIImpersonator.removeAllChildren();
			assertEquals( 0, UIImpersonator.numChildren );
		}
		
		[Test(description="")]
		public function getChildAtTest():void {
			UIImpersonator.addChild( uiComponent0 );
			UIImpersonator.addChild( uiComponent1 );
			UIImpersonator.addChild( uiComponent2 );

			assertEquals( uiComponent0, UIImpersonator.getChildAt( 0 ) );
			assertEquals( uiComponent1, UIImpersonator.getChildAt( 1 ) );
			assertEquals( uiComponent2, UIImpersonator.getChildAt( 2 ) );
		}
		
		[Test(description="")]
		public function getChildByNameTest():void {
			
		}
		
		[Test(description="")]
		public function getChildIndexTest():void {
			UIImpersonator.addChild( uiComponent0 );
			UIImpersonator.addChild( uiComponent1 );
			UIImpersonator.addChild( uiComponent2 );
			
			assertEquals( 0, UIImpersonator.getChildIndex( uiComponent0 ) );
			assertEquals( 1, UIImpersonator.getChildIndex( uiComponent1 ) );
			assertEquals( 2, UIImpersonator.getChildIndex( uiComponent2 ) );
		}
		
		[Test(description="")]
		public function setChildIndexTest():void {
			UIImpersonator.addChild( uiComponent0 );
			UIImpersonator.addChild( uiComponent1 );
			UIImpersonator.addChild( uiComponent2 );
			
			UIImpersonator.setChildIndex( uiComponent0, 1 );
			
			assertEquals( 1, UIImpersonator.getChildIndex( uiComponent0 ) );
			assertEquals( 0, UIImpersonator.getChildIndex( uiComponent1 ) );
			assertEquals( 2, UIImpersonator.getChildIndex( uiComponent2 ) );
		}
		
		[Test(description="")]
		public function getNumChildrenTest():void {

			assertEquals( 0, UIImpersonator.numChildren );

			UIImpersonator.addChild( uiComponent0 );
			assertEquals( 1, UIImpersonator.numChildren );
			
			UIImpersonator.addChild( uiComponent1 );
			assertEquals( 2, UIImpersonator.numChildren );

			UIImpersonator.addChild( uiComponent2 );
			assertEquals( 3, UIImpersonator.numChildren );
		}
	}
}