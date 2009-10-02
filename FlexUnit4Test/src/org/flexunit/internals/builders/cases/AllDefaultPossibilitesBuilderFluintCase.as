package org.flexunit.internals.builders.cases
{
	import org.flexunit.internals.builders.AllDefaultPossibilitiesBuilder;
	import org.flexunit.internals.builders.FlexUnit1Builder;

	public class AllDefaultPossibilitiesBuilderFluintCase extends AllDefaultPossibilitiesBuilder
	{
		[Test(description="Ensure flexUnit1Builder returns a type of FlexUnit1Builder")]
		public function testFlexUnit1Builder() : void {
			Assert.assertTrue( flexUnit1Builder() is FlexUnit1Builder );
		}
		
		public function AllDefaultPossibilitiesBuilderFluintCase() {
			super( false );
		}
	}
}