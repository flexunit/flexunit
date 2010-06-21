package org.flexunit.runner.notification {
	import org.flexunit.runner.IDescription;

	/**
	 * Interface to be implemented by a listener that needs information on a test
	 * methods total execution time.
	 * 
	 * @author mlabriola
	 * 
	 */
	public interface ITemporalRunListener extends IRunListener {
		/**
		 * Called by the notifier when a test run completed
		 *  
		 * @param description the test that completed
		 * @param runTime time in ms that the test took to execute
		 * 
		 */
		function testTimed( description:IDescription, runTime:Number ):void;
	}
}