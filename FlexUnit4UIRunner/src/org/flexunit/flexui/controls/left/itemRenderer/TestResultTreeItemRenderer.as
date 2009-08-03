/*
   Copyright (c) 2008. Adobe Systems Incorporated.
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

     * Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
     * Neither the name of Adobe Systems Incorporated nor the names of its
       contributors may be used to endorse or promote products derived from this
       software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.
*/
package org.flexunit.flexui.controls.left.itemRenderer
{
   import flash.display.DisplayObject;
   
   import org.flexunit.flexui.data.TestFunctionRowData;
   import org.flexunit.flexui.data.AbstractRowData;
   
   import mx.controls.Image;
   import mx.controls.Tree;
   import mx.controls.treeClasses.TreeItemRenderer;
   import mx.core.UITextField;

   public class TestResultTreeItemRenderer extends TreeItemRenderer
   {
      private static var WIDTH_STATUS_ICON : Number = 45;
      private static var WIDTH_EXPECTED_RESULT : Number = 130;
      private static var WIDTH_ACTUAL_RESULT : Number = 130;

      protected var img : Image;
      protected var assertionsLabel : UITextField;
      protected var expectedResultLabel : UITextField;
      protected var actualResultLabel : UITextField;

      override public function set data( value : Object ) : void
      {
         super.data = value;

         if ( data is AbstractRowData )
         {
            img.source = getStatusImage( AbstractRowData( data ) );
            assertionsLabel.text = AbstractRowData( data ).formattedAssertionsMade;
            assertionsLabel.toolTip = AbstractRowData( data ).assertionsMadeLegend;
            
            if ( data is TestFunctionRowData )
            {
               expectedResultLabel.text = TestFunctionRowData( data ).expectedResult;
               actualResultLabel.text = TestFunctionRowData( data ).actualResult;               
            }
            else
            {
               expectedResultLabel.text = "";
               actualResultLabel.text = "";
            }
         }
      }

      public function TestResultTreeItemRenderer()
      {
         super();
      }

      //--------------------------------------------------------------------------
      //
      //  Overridden methods
      //
      //--------------------------------------------------------------------------

      /**
       *  @private
       */
      override protected function createChildren():void
      {
          super.createChildren();
          
          if ( ! expectedResultLabel )
          {
             expectedResultLabel = new UITextField();
             expectedResultLabel.styleName = this;
             addChild( expectedResultLabel );
          }
          
          if ( ! actualResultLabel )
          {
             actualResultLabel = new UITextField();
             actualResultLabel.styleName = this;
             addChild( actualResultLabel );
          }
          
          if ( ! assertionsLabel )
          {
             assertionsLabel = new UITextField();
             assertionsLabel.styleName = this;
             //made invisible to avoid confusion until we can make this work across the board
             //assertionsLabel.visible = false;
             addChild( assertionsLabel );
          }
          
          if ( ! img)
          {
             img = new Image();
             addChild( DisplayObject( img ) );
          }
      }
      
      override protected function updateDisplayList(
             unscaledWidth : Number,
             unscaledHeight : Number ) : void
      {
         super.updateDisplayList( unscaledWidth, unscaledHeight );

         var labelColor:Number;
         
         if ( data && parent )
   		{
   			if ( ! enabled )
   				labelColor = getStyle( "disabledColor" );
   			else if ( Tree( listData.owner ).isItemHighlighted( listData.uid ) )
           		labelColor = getStyle( "textRollOverColor" );
   			else if ( Tree( listData.owner ).isItemSelected( listData.uid ) )
           		labelColor = getStyle( "textSelectedColor" );
   			else
           		labelColor = getStyle( "color" );   
   		}
   		
         var offsetFromRightSide : Number = 0;
         
         if ( actualResultLabel )
         {
            offsetFromRightSide += WIDTH_ACTUAL_RESULT;
            actualResultLabel.x = unscaledWidth - offsetFromRightSide;
            actualResultLabel.setActualSize(
                    WIDTH_ACTUAL_RESULT,
                    measuredHeight );

            if ( actualResultLabel.truncateToFit() && data as TestFunctionRowData )
            {
               actualResultLabel.toolTip = TestFunctionRowData( data ).actualResult;
            }
            actualResultLabel.setColor( labelColor );
         }

         if ( expectedResultLabel )
         {
            offsetFromRightSide += WIDTH_EXPECTED_RESULT;
            expectedResultLabel.x = unscaledWidth - offsetFromRightSide;
            expectedResultLabel.setActualSize(
                    WIDTH_EXPECTED_RESULT,
                    measuredHeight );

            if ( expectedResultLabel.truncateToFit() && data as TestFunctionRowData )
            {
               expectedResultLabel.toolTip = TestFunctionRowData( data ).expectedResult;
            }
            expectedResultLabel.setColor( labelColor );
         }

         if ( assertionsLabel )
         {
            offsetFromRightSide += WIDTH_STATUS_ICON;
            assertionsLabel.y = 2;
            assertionsLabel.x = unscaledWidth - offsetFromRightSide;
            assertionsLabel.setActualSize(
                    WIDTH_STATUS_ICON,
                    measuredHeight );
            
            assertionsLabel.setColor( labelColor );
         }

         if ( img )
         {
            var imgPosStart : Number;

            offsetFromRightSide += WIDTH_STATUS_ICON;
            imgPosStart = unscaledWidth - offsetFromRightSide;

            if ( data is TestFunctionRowData )
            {
               img.x = imgPosStart + 3;
            }
            else
            {
               img.x = imgPosStart;
            }

            img.setActualSize( img.measuredWidth, img.measuredHeight );
         }

         if ( label )
         {
            label.setActualSize( imgPosStart - label.x - 10, measuredHeight );

            if( label.truncateToFit() && data as AbstractRowData )
            {
               label.toolTip = AbstractRowData( data ).label;
            }
         }

         alignComponentVertically( unscaledWidth, unscaledHeight );
      }

      protected function alignComponentVertically(
                   unscaledWidth : Number,
                   unscaledHeight : Number ) : void
      {
         var verticalAlign : String = getStyle( "verticalAlign" );

         if ( verticalAlign == "top" )
         {
            if ( img )
            {
               img.y = 0;
            }
            if ( expectedResultLabel )
            {
               expectedResultLabel.y = 0;
            }
            if ( actualResultLabel )
            {
               actualResultLabel.y = 0;
            }
         }
         else if ( verticalAlign == "bottom" )
         {
            expectedResultLabel.y = unscaledHeight - expectedResultLabel.height + 2; // 2 for gutter
            actualResultLabel.y = unscaledHeight - actualResultLabel.height + 2; // 2 for gutter
            if ( img )
            {
               img.y = unscaledHeight - img.height;
            }
         }
         else
         {
            expectedResultLabel.y = ( unscaledHeight - expectedResultLabel.height ) / 2;
            actualResultLabel.y = ( unscaledHeight - actualResultLabel.height ) / 2;
            if ( img )
            {
               img.y = ( unscaledHeight - img.height ) / 2;
            }
         }
      }

      private function createTextField( control : UITextField ) : void
      {
         if ( ! control )
         {
            control = new UITextField();
            control.styleName = this;
            addChild( control );
         }
      }


      private function getStatusImage( testRow : AbstractRowData ) : Class
      {
		if ( testRow.testIgnored ) {
			return null;	  
		}

		if ( testRow.testSuccessful )
		{
			return testRow.passIcon;
		}
		else
		{
			return testRow.failIcon;
		}
      }
   }
}
