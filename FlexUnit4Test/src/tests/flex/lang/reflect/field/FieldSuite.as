package tests.flex.lang.reflect.field {

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class FieldSuite {
		public var validFieldCase:FieldWithValidData;
		public var variableFieldCase:FieldAsAVariable;
		public var propertyFieldCase:FieldAsAProperty;
		public var invalidFieldCase:FieldWithInvalidData;
	}
}