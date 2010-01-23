/**
 * Base class for non-interactive listeners
 *
 * @author Ryan Christiansen
 * @author Harald Radi
 */
package org.flexunit.listeners
{
	import flash.system.fscommand;
	import flash.utils.Dictionary;

	import mx.utils.StringUtil;

	import org.flexunit.runner.IDescription;
	import org.flexunit.runner.Result;
	import org.flexunit.runner.notification.Failure;
	import org.flexunit.runner.notification.RunListener;

	public class ReportListener extends RunListener
	{
		private var suites:Dictionary = new Dictionary();
		private var lastsuite:IDescription;

		protected function writeLine(message:String = "", ... messageParameters):void {
			if (messageParameters.length > 0) {
				trace(StringUtil.substitute(message, messageParameters));
			} else {
				trace(message);
			}
		}

		public function suiteStarted(description:IDescription):void {
		}

		public function suiteFinished(description:IDescription):void {
		}

		override final public function testStarted(description:IDescription):void {
			var suite:IDescription = suites[description.displayName];
			if (suite != lastsuite) {
				if (lastsuite != null) suiteFinished(lastsuite);
				suiteStarted(suite);
				lastsuite = suite;
			}

			testStartedInternal(description);
		}

		public function testStartedInternal(description:IDescription):void {
		}

		override public function testAssumptionFailure(failure:Failure):void {
			testFailure(failure);
		}

		override public function testRunStarted(description:IDescription):void {
			var parents:Dictionary = new Dictionary();
			resolveParents(description, parents);
		}

		override public function testRunFinished(result:Result):void {
			if (lastsuite != null) suiteFinished(lastsuite);
			fscommand("quit");
		}

		private function resolveParents(description:IDescription, parents:Dictionary):void {
			for each (var child:IDescription in description.children) {
				parents[child] = description;

				if (child.isSuite) {
					resolveParents(child, parents);
				}
				if (child.isTest) {
					resolveSuitename(child, parents);
				}
			}
		}

		private function resolveSuitename(description:IDescription, parents:Dictionary):void {
			var suite:IDescription = description;
			while (parents[suite] != null && IDescription(parents[suite]).displayName.length > 0) suite = parents[suite];
			suites[description.displayName] = suite;
		}
	}
}