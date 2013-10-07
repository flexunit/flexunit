package {

    import org.flexunit.Assert;

    import org.included.ExampleClass;
    import org.excluded.ExcludedClass;


    public class ExampleUnitTest {

        [Test]
        public function exampleTest():void {
            var ec:ExampleClass = new ExampleClass();
            ec.function1();
            ec.function2();
            Assert.assertFalse(ec.b);


            //this guy should be excluded from the coverage report
            var ex:ExcludedClass = new ExcludedClass();
            ex.function1();
        }

    }
}