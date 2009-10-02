package org.fluint.sequence
{
	import org.fluint.sequence.cases.SequenceBindingWaiterCase;
	import org.fluint.sequence.cases.SequenceCallerCase;
	import org.fluint.sequence.cases.SequenceDelayCase;
	import org.fluint.sequence.cases.SequenceEventDispatcherCase;
	import org.fluint.sequence.cases.SequenceSetterCase;
	import org.fluint.sequence.cases.SequenceWaiterCase;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class SequenceSuite
	{
		public var sequenceBindingWaiterCase:SequenceBindingWaiterCase;
		public var sequenceCallerCase:SequenceCallerCase;
		public var sequenceDelayCase:SequenceDelayCase;
		public var sequenceEventDispatcherCase:SequenceEventDispatcherCase;
		public var sequenceSetterCase:SequenceSetterCase;
		public var sequenceWaiterCase:SequenceWaiterCase;
	}
}