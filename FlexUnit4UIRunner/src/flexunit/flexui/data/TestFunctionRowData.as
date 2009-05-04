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
package flexunit.flexui.data
{
   import flexunit.flexui.patterns.*;
   
   import mx.formatters.NumberFormatter;
   
   import org.flexunit.runner.notification.Failure;

   public class TestFunctionRowData extends AbstractRowData
   {
      public static const EMPTY_STRING : String = "-";

      private const patterns : Array =
          [
             new AssertNotContainedPattern(),
             new AssertNoMatchPattern(),
             new AssertMatchPattern(),
             new AssertContainedPattern(),
             new AssertEventOcurredPattern(),
             new AssertEqualsPattern(),
             new AssertNotNullPattern(),
             new AssertNotUndefinedPattern(),
             new AssertNullPattern(),
             new AssertUndefinedPattern(),
             new FailAsyncCallPattern()
          ];

      public var testMethodName : String;
      public var parentTestCaseSummary : TestCaseData;
      public var expectedResult : String;
      public var actualResult : String;

      private var _errorMessage : String;
      private var _stackTrace : String;
      private var _error : Failure;
      private var _location : String;
      private var _line : Number;

      [Embed(source="/assets/pass_mini.png")]
      private static var passImgMini : Class;

      [Embed(source="/assets/fail_mini.png")]
      private static var failImgMini : Class;

      override public function get failIcon() : Class
      {
         return failImgMini;
      }

      override public function get passIcon() : Class
      {
         return passImgMini;
      }
      
      // TODO: [XB] implement this
      override public function get assertionsMade() : Number
      {
         return 0;
      }

      override public function get formattedAssertionsMade() : String
      {
         var f : NumberFormatter = new NumberFormatter();
         
         f.precision = 0;
         f.rounding = "nearest";
         
         return f.format( assertionsMade );
      }
      
      override public function get isAverage() : Boolean
      {
         return false;
      }

      public function set error( value : Failure ) : void
      {
         _error = value;

         _errorMessage = error ? error.message : EMPTY_STRING;
         expectedResult = EMPTY_STRING;
         actualResult = EMPTY_STRING;

         if ( error != null )
         {
            _stackTrace = formatStack( error.stackTrace.replace( "<", "&lt;" ).replace( ">", "&gt;" ) );

            for ( var i : int = 0 ; i < patterns.length; i++ )
            {
               var pattern : AbstractPattern = AbstractPattern( patterns[ i ] );

               if( pattern.match( error.message ) )
               {
                  pattern.apply( this );
                  break;
               }
            }
         }
      }

      public function get error() : Failure
      {
         return _error;
      }

      public function get errorMessage() : String
      {
         return _errorMessage;
      }

      public function get location() : String
      {
         if( _location )
         {
            return _location + " (l." + _line + ")";
         }
         return EMPTY_STRING;
      }

      public function get stackTrace() : String
      {
         return _stackTrace;
      }
      
      public function get stackTraceToolTip() : String
      {
         var regexp : RegExp = /\(\)\[.*\\.*\:(\d*)\]/gm;
         var array : Array = _stackTrace.split( "<br/>" );
         var stackTraceToolTip : String = "";
         
         for ( var i : int = 0; i < array.length; i++ )
         {
            stackTraceToolTip += array[ i ].toString().replace( regexp, "() at l.$1" ) + "<br/>";
         }
         return stackTraceToolTip;
      }
      
      public function isVisibleOnFilterText( filter : String ) : Boolean
      {
         return testMethodName.toLowerCase().indexOf( filter ) > -1 ||
                actualResult.toLowerCase().indexOf( filter ) > -1 ||
                expectedResult.toLowerCase().indexOf( filter ) > -1
      }

      private function extractLocation( line : String ) : Boolean
      {

         var location : RegExp = /(.*):(\d+)\]$/
         var splittedLine : Array = line.split( "\\" );
         var results : Array = location.exec( splittedLine[ splittedLine.length - 1 ] ) as Array;

         if( results && results.length == 3 )
         {
            _location = results[ 1 ];
            _line = results [ 2 ];

            return true;
         }

        return false;
      }

      private function formatStack( stackTrace : String ) : String
      {
         var replaceNewLine : RegExp = /\n/mg;
         var html : String = stackTrace.replace( replaceNewLine, "<br/>" );
         var formattedStack : String = "";
         var isFirst : Boolean = true;

         for ( var i : int = 1; i < html.split( "<br/>" ).length; i++ )
         {
            var currentLine : String = html.split( "<br/>" )[ i ];
            var matchingFlexunit : RegExp = /(at flexunit.*)$/g;
            var matchingFlash : RegExp = /(at flash.*)$/g;
            var matchingFlex : RegExp = /(at mx.*)$/g;
            var matchingFunction : RegExp = /at Function\/http:\/\/adobe\.com\/AS3\//

            if( ! matchingFlex.test( currentLine ) &&
                ! matchingFlexunit.test( currentLine ) &&
                ! matchingFlash.test( currentLine ) &&
                ! matchingFunction.test( currentLine ) )
            {
               if( isFirst && extractLocation( currentLine ) )
               {
                  isFirst = false;
               }
               formattedStack += "<b>" + currentLine + "</b><br/>";
            }
            else
            {
               formattedStack += currentLine + "<br/>";
            }
         }
         return formattedStack;
      }
   }
}
