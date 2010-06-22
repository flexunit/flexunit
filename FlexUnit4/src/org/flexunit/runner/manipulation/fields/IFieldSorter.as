package org.flexunit.runner.manipulation.fields {
	import flex.lang.reflect.Field;

	/**
	 * Interface for all instances to be considered field sorters
	 * @author mlabriola
	 * 
	 */
	public interface IFieldSorter {
		/**
		 * Compares two objects to determine their relative order
		 * @param field1
		 * @param field2
		 * @return 
		 * 
		 */
		function compare( field1:Field, field2:Field ):int;
	}
}