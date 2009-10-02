package org.flexunit.experimental.runners.statements
{
	import org.flexunit.experimental.runners.statements.cases.AssignmentSequencerCase;
	import org.flexunit.experimental.runners.statements.cases.MethodCompleteWithParamStatementCase;
	import org.flexunit.experimental.runners.statements.cases.TheoryBlockRunnerStatementCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentalRunnersStatementsSuite
	{
		public var assignmentSequencerCase:AssignmentSequencerCase;
		public var methodCompleteWithParamStatementCase:MethodCompleteWithParamStatementCase;
		public var theoryBlockRunnerStatementCase:TheoryBlockRunnerStatementCase;
	}
}