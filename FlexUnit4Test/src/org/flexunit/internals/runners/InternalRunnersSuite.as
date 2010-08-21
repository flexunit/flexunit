package org.flexunit.internals.runners
{
	import org.flexunit.internals.runners.cases.ChildRunnerSequencerCase;
	import org.flexunit.internals.runners.cases.ErrorReportingRunnerCase;
	import org.flexunit.internals.runners.cases.InitializationErrorCase;
	import org.flexunit.internals.runners.model.InternalRunnersModelSuite;
	import org.flexunit.internals.runners.statements.InternalRunnersStatmentsSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalRunnersSuite
	{
		//Cases
		public var childRunnerSequencerCase:ChildRunnerSequencerCase;
		public var errorReportingRunnerCase:ErrorReportingRunnerCase;
		public var initializationErrorCase:InitializationErrorCase;
		
		//Suites
		public var internalRunnersModelSuite:InternalRunnersModelSuite;
		public var internalRunnersStatementSuite:InternalRunnersStatmentsSuite;
		
	}
}