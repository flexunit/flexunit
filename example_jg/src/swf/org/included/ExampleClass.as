package org.included {

    public class ExampleClass {

        public var b:Boolean = false;

        public function function1():void {
            trace("function1 - line 1");
            trace("function1 - line 2");
            trace("function1 - line 3");
        }

        public function function2():void {
            if (b) {
                trace("function2 - line 1");
                trace("function2 - line 2");
            } else {
                trace("function2 - line 3");
            }
        }

        public function function3():void {
            trace("function3 - line 1");
            trace("function3 - line 2");
            trace("function3 - line 3");
        }


    }

}
