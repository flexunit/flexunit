package org.flexunit.runner.manipulation.cases
{
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	
	import org.flexunit.Assert;
	import org.flexunit.runner.Description;
	import org.flexunit.runner.manipulation.OrderArgumentPlusAlphaSorter;

	public class MetadataAlphabeticalSorterCase
	{		
		//TODO: Are these test correctly testing the MetadataAlphabeticalSorterCase class
		private var metaDataAlphaSorter : OrderArgumentPlusAlphaSorter;
		
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
		
		protected var noOrderXML:XML = new XML(
			<method>
				<metadata name="Test">
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
		
		private static function convertToMetaDataAnnotations( metaXML:XMLList ):Array {
			var ar:Array = new Array();
			for ( var i:int=0; i<metaXML.length(); i++ )  {
				ar.push( new MetaDataAnnotation( metaXML[ i ] ) );
			}
			
			return ar;
		} 
		
		[Before]
		public function setupSorter():void {
			metaDataAlphaSorter = new OrderArgumentPlusAlphaSorter();
		}
		
		protected var noOrderArray:Array = convertToMetaDataAnnotations( noOrderXML.metadata );
		
		protected var lowerArray:Array = convertToMetaDataAnnotations( lowerXML.metadata );
		
		protected var higherArray:Array = convertToMetaDataAnnotations( higherXML.metadata );
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a 0 when both IDescriptions contain a null XMLList")]
		public function bothDescNullMetadataLessTest():void {
			var o1:Description = new Description("a", null);
			var o2:Description = new Description("b", null);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), -1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a -1 when only the second IDescription contains a XMLList")]
		public function firstDescNullMetadataTest():void {
			var o1:Description = new Description("a", null);
			var o2:Description = new Description("b", higherArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), -1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a 1 when only the first IDescription contains a XMLList")]
		public function secondDescNullMetadataTest():void {
			var o1:Description = new Description("a", higherArray);
			var o2:Description = new Description("b", null);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), 1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a 0 when both IDescription contains an XMLList with equal ordering")]
		public function bothDescMetadataLessTest():void {
			var o1:Description = new Description("a", lowerArray);
			var o2:Description = new Description("b", lowerArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), -1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a 1 when the first IDescription contains an XMLList with a greater order")]
		public function firstDescMetadataGreaterTest():void {
			var o1:Description = new Description("a", higherArray);
			var o2:Description = new Description("b", lowerArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), 1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a -1 when the second IDescription contains an XMLList with a greater order")]
		public function secondDescMetadataGreaterTest():void {
			var o1:Description = new Description("a", lowerArray);
			var o2:Description = new Description("b", higherArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), -1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a -1 when the second IDescription contains an XMLList with a greater order")]
		public function firstNoOrderMetadataGreaterTest():void {
			var o1:Description = new Description("a", noOrderArray);
			var o2:Description = new Description("b", lowerArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), -1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns a 1 when the first IDescription contains an XMLList with a greater order")]
		public function firstNoOrderMetadataLessTest():void {
			var o1:Description = new Description("a", lowerArray);
			var o2:Description = new Description("b", noOrderArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), 1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns -1 when both IDescription contains an XMLList with no order, but first is alphabetically higher")]
		public function bothNoOrderMetadataLessTest():void {
			var o1:Description = new Description("a", noOrderArray);
			var o2:Description = new Description("b", noOrderArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), -1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns 1 when both IDescription contains an XMLList with a no order, but second is alphabetically higher")]
		public function bothNoOrderMetadataGreaterTest():void {
			
			var o1:Description = new Description("d", noOrderArray);
			var o2:Description = new Description("c", noOrderArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), 1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns 1 when both IDescription contains an XMLList with a same order, but second is alphabetically higher")]
		public function bothSameOrderMetadataGreaterTest():void {
			
			var o1:Description = new Description("f", lowerArray);
			var o2:Description = new Description("e", lowerArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), 1 );
		}
		
		[Test(description="Ensure the MetadataAlphabeticalSorterCase returns -1 when both IDescription contains an XMLList with a same order, but first is alphabetically higher")]
		public function bothSameOrderMetadataLessTest():void {
			
			var o1:Description = new Description("g", lowerArray);
			var o2:Description = new Description("h", lowerArray);
			
			Assert.assertEquals(metaDataAlphaSorter.compare(o1, o2), -1 );
		}
		
		
		
		
	}
}