package org.flexunit.constants {
	public class AnnotationArgumentConstants {
		/**
		 * Argument constant used in the Test metadata when specifying a TestNG Style parameterized test
		 */
		public static const DATAPROVIDER:String = "dataProvider";

		/**
		 * Argument constant used in the Test, Before, After, BeforeClass and AfterClass metadata 
		 * to specify that Asynchronous functionality should be enabled for this method.
		 */
		public static const ASYNC:String = "async";
		
		/**
		 * Argument constant used in the Test metadata to indicate that this test is expected to
		 * throw an error.
		 * 
		 * This is a synonym for expected
		 */
		public static const EXPECTS:String = "expects";

		/**
		 * Argument constant used in the Test metadata to indicate that this test is expected to
		 * throw an error.
		 * 
		 * This is a synonym for expects
		 */
		public static const EXPECTED:String = "expected";
		
		/**
		 * Argument constant used in the Test metadata to indicate that this test is expected to
		 * complete within the specified timeout. 
		 * 
		 */
		public static const TIMEOUT:String = "timeout";

		/**
		 * Argument constant used in the DataPoints or Parameters metadata to indicate that 
		 * data for this parameter will be loaded asynchronously. This constant references
		 * an implementation of IExternalDataLoader as a static in the same class
		 * 
		 */
		public static const LOADER:String = "loader";
		
		/**
		 * Argument constant usable in all metadata to indicate an order of operation as
		 * compared to other metadata of the same type.
		 * 
		 */
		public static const ORDER:String = "order";
	}
}