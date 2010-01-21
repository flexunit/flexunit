/**
 * A simple trace listener useful for running unit tests on the command line or within ant.
 *
 * Idea and concept is based on the DebugTestListener from the funit framework (http://funit.org/)
 *
 * @author Ryan Christiansen
 * @author Harald Radi
 */
package org.flexunit.listeners
{
	import flash.system.Capabilities;

	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;

	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.notification.Failure;

	public class TraceListener extends ReportListener {
		private var level:int = 0;
		private var testRunCount:int;
		private var testIgnoreCount:int;
		private var failureCount:int;

		private var messages:ArrayCollection;

		override public function testRunStarted(description:IDescription):void {
			super.testRunStarted(description);

			writeLine("------------------------------------------------------------------");
			writeLine("  {0} ({1})", Capabilities.manufacturer, Capabilities.playerType);
			writeLine("  Player Version: {0}", Capabilities.version);
			writeLine("------------------------------------------------------------------");
			writeLine();
		}

		override public function testStartedInternal(description:IDescription):void {
			writeLine("***** {0}", description.displayName);
		}

		override public function testFinished(description:IDescription):void {
			testRunCount++;
		}

		override public function testFailure(failure:Failure):void {
			testRunCount++;
			failureCount++;

			messages.addItem(StringUtil.substitute("{0}) {1} :", failureCount, failure.description.displayName));
			messages.addItem(failure.stackTrace);
		}

		override public function testIgnored(description:IDescription):void {
			testIgnoreCount++;
		}


		override public function suiteStarted(description:IDescription):void {
			if (level++ == 0) {
				messages = new ArrayCollection();
				testRunCount = 0;
				testIgnoreCount = 0;
				failureCount = 0;

				writeLine("################################ UNIT TESTS ################################");
				writeLine((description.displayName) ? "Running tests in '" + description.displayName + "'..." : "Running tests ...");
			}
		}

		override public function suiteFinished(description:IDescription):void {
			if (--level == 0) {
				writeLine("############################################################################");

				if (messages.length == 0) {
					writeLine("##############                 S U C C E S S               #################");
				} else {
					writeLine("##############                F A I L U R E S              #################");
					writeLine("############################################################################");

					for each (var message:String in messages) {
						writeLine(message);
					}
				}

				writeLine("############################################################################");
				writeLine("Executed tests       : " + testRunCount);
				writeLine("Ignored tests        : " + testIgnoreCount);
				writeLine("Failed tests         : " + failureCount);
				writeLine("############################################################################");
			}
		}
	}
}