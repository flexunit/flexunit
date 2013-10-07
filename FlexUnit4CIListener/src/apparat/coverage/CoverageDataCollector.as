/*
 *  This class was borrowed from the flexmojos -> flexmojos-testing project
 *  and is assuming that software license - Jason Gardner

 *  Copyright 2008 Marvin Herman Froeder
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/
package apparat.coverage {

    import apparat.coverage.TestCoverageReport;

    public class CoverageDataCollector {
        public function CoverageDataCollector() {

        }

        private static var map:Object = new Object();

        public static function collect(classname:String, lineNumber:int):void {
            var data:TestCoverageReport;
            if ((data = map[classname]) == null) {
                data = new TestCoverageReport(classname);
                map[classname] = data;
            }

            data.touch(lineNumber);
        }

        public static function extractCoverageResult():Object {
            var result:Object = map;
            map = new Object();
            return result;
        }

    }
}