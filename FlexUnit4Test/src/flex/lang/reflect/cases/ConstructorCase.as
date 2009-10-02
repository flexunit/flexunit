package flex.lang.reflect.cases
{
	import flex.lang.reflect.Constructor;
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.mocks.FieldMock;
	
	import org.flexunit.Assert;
	import org.flexunit.runners.mocks.RunnerLocatorMock;
	
	public class ConstructorCase
	{
		protected var constructor:Constructor;
		
		[Before]
		public function setup():void {
			var k:Klass = new Klass( null );
			constructor = new Constructor( null, k ); 
		}
		
		[After]
		public function tearDown():void {
			constructor = null;
		}	
		
		[Test(description="check newInstance when invalid number of aguments is supplied")]
		public function check_newInstance_invalid_number_arguments():void {
			var k:Klass = new Klass( null );
			// according to the xml there is one required constructor argument
			var xml:XML = 	<constructor>
  								<parameter index="1" type="String" optional="false"/>
							</constructor>;
			constructor = new Constructor( xml, k ); 
			try {
				// create new instance with no arguments, to cause error to be thrown
				var obj:Object = constructor.newInstance();	
			} catch( e:Error ) {
				var expectedErrorMessage:String = "Invalid number or type of arguments to contructor"; 
				Assert.assertTrue( expectedErrorMessage, e.message );
				//Assert.fail( "Expected 'Invalid number or type of arguments to constructor', but instead got " + e.name + ": " + e.message );
			}
		}
		
		[Test(description="check newInstance when valid number of aguments is supplied")]
		public function check_newInstance_valid_number_of_agruments():void {
			var k:Klass = new Klass( RunnerLocatorMock );
			// according to the xml there is one required constructor argument
			var xml:XML = 	<constructor>
  								<parameter index="1" type="String" optional="false"/>
							</constructor>;
			constructor = new Constructor( xml, k ); 
			try {
				// create new instance with no arguments, to cause error to be thrown
				var obj:Object = constructor.newInstance( "myArg" );	
			} catch( e:Error ) {
				Assert.fail( e.name + ": " + e.message );
			}
		}
		
		[Test(description="check newInstance when too many aguments are supplied in the constructor")]
		public function check_newInstance_too_many_agruments():void {
			var k:Klass = new Klass( RunnerLocatorMock );
			// according to the xml there is one required constructor argument
			var xml:XML = 	<constructor>
  								<parameter index="1" type="String" optional="true"/>
  								<parameter index="2" type="String" optional="true"/>
  								<parameter index="3" type="String" optional="true"/>
  								<parameter index="4" type="String" optional="true"/>
  								<parameter index="5" type="String" optional="true"/>
  								<parameter index="6" type="String" optional="true"/>
  								<parameter index="7" type="String" optional="true"/>
							</constructor>;
			constructor = new Constructor( xml, k ); 
			try {
				// create new instance with no arguments, to cause error to be thrown
				var obj:Object = constructor.newInstance( "arg1","arg2","arg3","arg4","arg5","arg6","arg7" );	
			} catch( e:Error ) {
				var expectedErrorMessage:String = "Sorry, we can't support constructors with more than 6 args out of the box... yes, its dumb, take a look at Constructor.as to modify on your own";
				Assert.assertTrue( expectedErrorMessage, e.message );
			}
		}
		
		/**
		 * Constructor 
		 */
		public function ConstructorCase()
		{
		}

	}
}