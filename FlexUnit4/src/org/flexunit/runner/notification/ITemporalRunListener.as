package org.flexunit.runner.notification {
	import org.flexunit.runner.IDescription;

	public interface ITemporalRunListener extends IRunListener {
		function testTimed( description:IDescription, runTime:Number ):void;
	}
}