/**
 * Copyright (c) 2010 Digital Primates
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package flex.lang.reflect.builders {
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.utils.MetadataTools;

	public class MetaDataAnnotationBuilder {
		/**
		 * @private
		 */
		private var classXML:XML;
		
		/**
		 * Builds an array of annotation contained on the provided class xml 
		 * @return 
		 * 
		 */		
		public function buildAllAnnotations():Array {
			var metaDataAr:Array = new Array();
			var metaDataList:XMLList;			
			
			if ( classXML.factory && classXML.factory[ 0 ] ) {
				metaDataList = MetadataTools.nodeMetaData( classXML.factory[ 0 ] );
				if ( metaDataList ) {
					for ( var i:int=0; i<metaDataList.length(); i++ ) {
						metaDataAr.push( new MetaDataAnnotation( metaDataList[ i ] ) );
					}
				}
			}			
			
			return metaDataAr;			
		}

		/**
		 * 
		 * @param classXML
		 * 
		 */		
		public function MetaDataAnnotationBuilder( classXML:XML ) {
			this.classXML = classXML;
		}
	}
}