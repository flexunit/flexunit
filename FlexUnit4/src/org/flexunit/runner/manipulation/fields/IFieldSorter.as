package org.flexunit.runner.manipulation.fields {
	import flex.lang.reflect.Field;

	public interface IFieldSorter {
		function compare( field1:Field, field2:Field ):int;
	}
}