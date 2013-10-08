package {

    import org.flexunit.Assert;

    import org.included.ExampleMXMLClass;
    import org.excluded.ExcludedMXMLClass;


    public class ExampleMXMLUnitTest {

        [Test]
        public function exampleMXMLTest():void {
            var ec:ExampleMXMLClass = new ExampleMXMLClass();
            ec.function1();
            ec.function2();
            Assert.assertFalse(ec.b);


            //this guy should be excluded from the coverage report
            var ex:ExcludedMXMLClass = new ExcludedMXMLClass();
            ex.function1();
        }

    }
}