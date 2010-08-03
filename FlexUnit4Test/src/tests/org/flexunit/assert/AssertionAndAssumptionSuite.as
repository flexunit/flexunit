package tests.org.flexunit.assert
{
	import tests.org.flexunit.assert.absolute.FailCase;
	import tests.org.flexunit.assert.assertionsMade.AssertionsMadeCase;
	import tests.org.flexunit.assert.assumption.AssumeCase;
	import tests.org.flexunit.assert.assumption.AssumeThatCase;
	import tests.org.flexunit.assert.bool.AssertFailNotTrue;
	import tests.org.flexunit.assert.bool.AssertFailTrue;
	import tests.org.flexunit.assert.bool.AssertFalseClassCase;
	import tests.org.flexunit.assert.bool.AssertFalseFunctionCase;
	import tests.org.flexunit.assert.bool.AssertTrueClassCase;
	import tests.org.flexunit.assert.bool.AssertTrueFunctionCase;
	import tests.org.flexunit.assert.dynamicApp.DynamicAsserterCase;
	import tests.org.flexunit.assert.equals.AssertEqualsClassCase;
	import tests.org.flexunit.assert.equals.AssertEqualsFunctionCase;
	import tests.org.flexunit.assert.equals.AssertFailNotEquals;
	import tests.org.flexunit.assert.equals.AssertFailNotStrictlyEqual;
	import tests.org.flexunit.assert.equals.AssertStrictlyEqualsClassCase;
	import tests.org.flexunit.assert.equals.AssertStrictlyEqualsFunctionCase;
	import tests.org.flexunit.assert.error.AssertionErrorCase;
	import tests.org.flexunit.assert.nullHandling.AssertFailNotNull;
	import tests.org.flexunit.assert.nullHandling.AssertFailNull;
	import tests.org.flexunit.assert.nullHandling.AssertNotNullCase;
	import tests.org.flexunit.assert.nullHandling.AssertNullClassCase;
	import tests.org.flexunit.assert.nullHandling.AssertNullFunctionCase;
	import tests.org.flexunit.assert.that.AssertThatCase;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AssertionAndAssumptionSuite
	{
		public var test1:tests.org.flexunit.assert.assertionsMade.AssertionsMadeCase;
		public var test2:tests.org.flexunit.assert.that.AssertThatCase;
		public var test3:tests.org.flexunit.assert.bool.AssertFailNotTrue;
		public var test4:tests.org.flexunit.assert.bool.AssertFailTrue;
		public var test5:tests.org.flexunit.assert.bool.AssertFalseClassCase;
		public var test6:tests.org.flexunit.assert.bool.AssertFalseFunctionCase;
		public var test7:tests.org.flexunit.assert.bool.AssertTrueClassCase;
		public var test8:tests.org.flexunit.assert.bool.AssertTrueFunctionCase;
		public var test9:tests.org.flexunit.assert.assumption.AssumeCase;
		public var test10:tests.org.flexunit.assert.assumption.AssumeThatCase;
		public var test11:tests.org.flexunit.assert.nullHandling.AssertNullClassCase;
		public var test12:tests.org.flexunit.assert.nullHandling.AssertFailNotNull;
		public var test13:tests.org.flexunit.assert.nullHandling.AssertFailNull;
		public var test14:tests.org.flexunit.assert.nullHandling.AssertNotNullCase;
		public var test15:tests.org.flexunit.assert.nullHandling.AssertNullFunctionCase;
		public var test16:tests.org.flexunit.assert.error.AssertionErrorCase;
		public var test17:tests.org.flexunit.assert.absolute.FailCase;
		public var test18:tests.org.flexunit.assert.dynamicApp.DynamicAsserterCase;
		public var test19:tests.org.flexunit.assert.equals.AssertEqualsClassCase;
		public var test20:tests.org.flexunit.assert.equals.AssertEqualsFunctionCase;
		public var test21:tests.org.flexunit.assert.equals.AssertFailNotEquals;
		public var test22:tests.org.flexunit.assert.equals.AssertFailNotStrictlyEqual;
		public var test23:tests.org.flexunit.assert.equals.AssertStrictlyEqualsClassCase;
		public var test24:tests.org.flexunit.assert.equals.AssertStrictlyEqualsFunctionCase;
		
	}
}