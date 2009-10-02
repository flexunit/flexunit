package org.flexunit.experimental.runners
{
	import org.flexunit.experimental.runners.cases.EnclosedCase;
	import org.flexunit.experimental.runners.statements.ExperimentalRunnersStatementsSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ExperimentalRunnersSuite
	{
		public var experimentalRunnersStatementSuite : ExperimentalRunnersStatementsSuite;
		
		//Cases
		//Not yet implemented
		public var enclosedCase : EnclosedCase;
	}
}
