package org.flexunit.runner.manipulation.cases
{
	import org.flexunit.Assert;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.manipulation.MetadataSorter;

	public class MetadataSorterCase
	{
		//TODO: Are these test correctly testing the MetadataSorter class
		
		protected var lowerXML:XML = new XML(
			<method>
				<metadata name="Test">
					<arg key="order" value="42"/>
					<arg key="description" value="Description A"/>
				</metadata>
				<metadata name="__go_to_definition_help">
				  <arg key="pos" value="719"/>
				</metadata>
			</method>);
		
		protected var higherXML:XML = new XML(
			<method>
				<metadata name="Test">
					<arg key="order" value="1729"/>
					<arg key="description" value="Description B"/>
				</metadata>
				<metadata name="__go_to_definition_help">
				  <arg key="pos" value="720"/>
				</metadata>
			</method>);
		
		protected var lowerXMLList:XMLList = lowerXML.metadata as XMLList;
			
		protected var higherXMLList:XMLList = higherXML.metadata as XMLList;
		
		[Test(description="Ensure the MetadataSorter returns a 0 when both IDescriptions contain a null XMLList")]
		public function bothDescNullMetadataTest():void {
			var o1:Description = new Description("a", null);
			var o2:Description = new Description("b", null);
			
			Assert.assertEquals(MetadataSorter.defaultSortFunction(o1, o2), 0 );
		}
		
		[Test(description="Ensure the MetadataSorter returns a -1 when only the second IDescription contains a XMLList")]
		public function firstDescNullMetadataTest():void {
			var o1:Description = new Description("a", null);
			var o2:Description = new Description("b", higherXMLList);
			
			Assert.assertEquals(MetadataSorter.defaultSortFunction(o1, o2), -1 );
		}
		
		[Test(description="Ensure the MetadataSorter returns a 1 when only the first IDescription contains a XMLList")]
		public function secondDescNullMetadataTest():void {
			var o1:Description = new Description("a", higherXMLList);
			var o2:Description = new Description("b", null);
			
			Assert.assertEquals(MetadataSorter.defaultSortFunction(o1, o2), 1 );
		}
		
		[Test(description="Ensure the MetadataSorter returns a 0 when both IDescription contains an XMLList with equal ordering")]
		public function bothDescMetadataEqualTest():void {
			var o1:Description = new Description("a", lowerXMLList);
			var o2:Description = new Description("b", lowerXMLList);
			
			Assert.assertEquals(MetadataSorter.defaultSortFunction(o1, o2), 0 );
		}
		
		[Test(description="Ensure the MetadataSorter returns a 1 when the first IDescription contains an XMLList with a greater order")]
		public function firstDescMetadataGreaterTest():void {
			var o1:Description = new Description("a", higherXMLList);
			var o2:Description = new Description("b", lowerXMLList);
			
			Assert.assertEquals(MetadataSorter.defaultSortFunction(o1, o2), 1 );
		}
		
		[Test(description="Ensure the MetadataSorter returns a -1 when the second IDescription contains an XMLList with a greater order")]
		public function secondDescMetadataGreaterTest():void {
			var o1:Description = new Description("a", lowerXMLList);
			var o2:Description = new Description("b", higherXMLList);
			
			Assert.assertEquals(MetadataSorter.defaultSortFunction(o1, o2), -1 );
		}
	}
}