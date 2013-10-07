/*
 *  This class was borrowed from the flexmojos -> flexmojos-testing project
 *  and is assuming that software license - Jason Gardner

 *  Copyright 2008 Marvin Herman Froeder
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/
package apparat.coverage {

    public class TestCoverageReport {

        public var classname:String;
        public var touchs:Array;

        public function TestCoverageReport(classname:String) {
            this.classname = classname;
            this.touchs = new Array();
        }

        public function touch(lineNumber:int):void {
            touchs.splice(touchs.length, 0, lineNumber);
        }

        public function toXml():String {
            var genxml:String = "<coverage classname=\""+ classname + "\">";
            for each (var line:int in touchs) {
                genxml = genxml.concat("<touch>", line, "</touch>");
            }
            genxml += "</coverage>";
            return genxml;
        }

    }
}
