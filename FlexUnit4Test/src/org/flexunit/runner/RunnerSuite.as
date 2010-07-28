package org.flexunit.runner
{
	import org.flexunit.runner.cases.DescriptionCase;
	import org.flexunit.runner.cases.DescriptorCase;
	import org.flexunit.runner.cases.RequestCase;
	import org.flexunit.runner.cases.ResultCase;
	import org.flexunit.runner.manipulation.ManipulationSuite;
	import org.flexunit.runner.notification.NotificationSuite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class RunnerSuite
	{
		// Suites
		public var manipulationSuite:ManipulationSuite;
		public var notificationSuite:NotificationSuite;
		
		// Cases
		public var descriptionCase:DescriptionCase;
		public var descriptorCase:DescriptorCase;
		public var requestCase:RequestCase;
		public var resultCase:ResultCase;
	}
}