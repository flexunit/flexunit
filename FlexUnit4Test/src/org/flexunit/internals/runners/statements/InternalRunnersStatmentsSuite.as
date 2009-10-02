package org.flexunit.internals.runners.statements
{
	import org.flexunit.internals.runners.statements.cases.AsyncStatementBaseCase;
	import org.flexunit.internals.runners.statements.cases.ExpectAsyncASCase;
	import org.flexunit.internals.runners.statements.cases.ExpectExceptionCase;
	import org.flexunit.internals.runners.statements.cases.FailCase;
	import org.flexunit.internals.runners.statements.cases.FailOnTimeoutCase;
	import org.flexunit.internals.runners.statements.cases.InvokeMethodCase;
	import org.flexunit.internals.runners.statements.cases.RunAftersCase;
	import org.flexunit.internals.runners.statements.cases.RunAftersClassCase;
	import org.flexunit.internals.runners.statements.cases.RunBeforesCase;
	import org.flexunit.internals.runners.statements.cases.RunBeforesClassCase;
	import org.flexunit.internals.runners.statements.cases.SequencerWithDecorationCase;
	import org.flexunit.internals.runners.statements.cases.StackAndFrameManagementCase;
	import org.flexunit.internals.runners.statements.cases.StatementSequencerCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class InternalRunnersStatmentsSuite
	{
		public var asyncStatementBaseCase:AsyncStatementBaseCase;
		public var expectAsyncCase:ExpectAsyncASCase;
		public var expectExceptionCase:ExpectExceptionCase;
		public var failCase:FailCase;
		public var failOnTimeoutCase:FailOnTimeoutCase;
		public var invokeMethodCase:InvokeMethodCase;
		public var runAftersCase:RunAftersCase;
		public var runAftersClassCase:RunAftersClassCase;
		public var runBeforesCase:RunBeforesCase;
		public var runBeforesClassCase:RunBeforesClassCase;
		public var sequencerWithDecorationCase:SequencerWithDecorationCase;
		public var statckAndFrameManagmentCase:StackAndFrameManagementCase;
		public var statementSequencerCase:StatementSequencerCase;
	}
}