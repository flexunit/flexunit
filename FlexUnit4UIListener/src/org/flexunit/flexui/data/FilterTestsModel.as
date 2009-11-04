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
package org.flexunit.flexui.data
{
   import flash.events.EventDispatcher;
   
   import org.flexunit.flexui.data.filter.ITestFunctionStatus;
   import org.flexunit.flexui.event.TestRunnerBasePresentationModelProperyChangedEvent;
   
   import mx.collections.IList;

   [Event( 
      name="filterChanged", 
      type="flash.events.Event")]
   
   public class FilterTestsModel extends EventDispatcher
   {
      public var filter : String;
      
      private var _selectedTestFunctionStatus : ITestFunctionStatus;

      public function searchFilterFunc( item : Object ) : Boolean
      {
         if ( item is TestCaseData )
         {
            var testClassSum : TestCaseData = item as TestCaseData;

            testClassSum.filterText = filter;
            testClassSum.selectedTestFunctionStatus = _selectedTestFunctionStatus;
            testClassSum.refresh();

            var testCaseChildren : IList = testClassSum.children;

            if ( testCaseChildren && testCaseChildren.length > 0 )
            {
               return true;
            }
         }

         return false;
      }
      
      public function set selectedTestFunctionStatus( value : ITestFunctionStatus ) : void
      {
         _selectedTestFunctionStatus = value;
         
         dispatchEvent(
               new TestRunnerBasePresentationModelProperyChangedEvent( 
                     TestRunnerBasePresentationModelProperyChangedEvent.FILTER_CHANGED, 
                     true ) );
      }

      public function get selectedTestFunctionStatus() : ITestFunctionStatus
      {
         return _selectedTestFunctionStatus;
      }
   }
}