/**
 * A listener that reports test results directly to TeamCity
 *
 * Idea and concept is based on the TeamcityTestListener from the funit framework (http://funit.org/)
 *
 * @author Ryan Christiansen
 * @author Harald Radi
 */
package org.flexunit.listeners
{
	import flash.utils.getTimer;

	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;

	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.notification.Failure;

	public class TeamCityListener extends ReportListener
	{
		private var timer:int;

		override protected function writeLine(message:String = "", ... messageParameters):void {
			for (var i:int = 0; i < messageParameters.length; i++) {
				messageParameters[i] = escapeSpecial(messageParameters[i]);
			}

			messageParameters.unshift(message);

			super.writeLine.apply(this, messageParameters);
		}

		private function escapeSpecial(value:String):String {
			return value.replace(/[\|\]\r\n\']/g, replaceMethod);
		}

		private function replaceMethod(c:String, ... parameters):String {
			switch (c) {
				case "\r":
					return "|r";
				case "\n":
					return "|n";
				case "'":
					return "|'";
				case "|":
					return "||";
				case "]":
					return "|]";
				default:
					return c;
			}
		}

		private function formatTestName(name:String):String {
			return name.replace("::", ".");
		}

		override public function suiteStarted(description:IDescription):void {
			writeLine("##teamcity[testSuiteStarted name='{0}']", formatTestName(description.displayName));
		}

		override public function suiteFinished(description:IDescription):void {
			writeLine("##teamcity[testSuiteFinished name='{0}']", formatTestName(description.displayName));
		}

		override public function testStartedInternal(description:IDescription):void {
			writeLine("##teamcity[testStarted name='{0}']", formatTestName(description.displayName));
			timer = getTimer();
		}

		override public function testFinished(description:IDescription):void {
			var duration:int = getTimer() - timer;
			writeLine("##teamcity[testFinished name='{0}' duration='{1}']", formatTestName(description.displayName), duration);
		}

		override public function testFailure(failure:Failure):void {
			var duration:int = getTimer() - timer;
			var testname:String = formatTestName(failure.description.displayName);

			writeLine("##teamcity[testFailed name='{0}' message='{1}' details='{2}']", testname, failure.message, failure.stackTrace);
			writeLine("##teamcity[testFinished name='{0}' duration='{1}']", testname, duration);
		}

		override public function testIgnored(description:IDescription):void {
			var message:String = null;
			for each (var metadata:MetaDataAnnotation in description.getAllMetadata()) {
				if (metadata.name == "Ignore") {
					var argument:MetaDataArgument = metadata.getArgument("description");
					if (argument != null) message = argument.value;
				}
			}

			if (message != null) {
				writeLine("##teamcity[testIgnored name='{0}' message='{1}']", formatTestName(description.displayName), message);
			} else {
				writeLine("##teamcity[testIgnored name='{0}']", formatTestName(description.displayName));
			}
		}
	}
}