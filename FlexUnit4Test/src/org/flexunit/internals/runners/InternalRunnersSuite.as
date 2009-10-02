package org.flexunit.internals.runners
{
	import org.flexunit.internals.runners.cases.ChildRunnerSequencerCase;
	import org.flexunit.internals.runners.cases.ClassRoadieCase;
	import org.flexunit.internals.runners.cases.ErrorReportingRunnerCase;
	import org.flexunit.internals.runners.cases.FailedBeforeCase;	import org.flexunit.internals.runners.cases.InitializationErrorCase;
	import org.flexunit.internals.runners.cases.MethodRoadieCase;
	import org.flexunit.internals.runners.cases.MethodValidatorCase;
	import org.flexunit.internals.runners.cases.TestMethodCase;
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
		
		//Not yet Implemented		
		public var failedBeforeCase:FailedBeforeCase;		
		public var classRoadieCase:ClassRoadieCase;		
		public var methodRoadieCase:MethodRoadieCase;		
		public var methodValidatorCase:MethodValidatorCase;		
		public var testMethodCase:TestMethodCase;	
	}
}