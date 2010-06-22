package org.flexunit.rules {
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.model.FrameworkMethod;

	public interface IMethodRule extends IAsyncStatement {
		/**
		 * Called when this rule is added to the wrapping set of statements before a test method
		 * exectuion
		 *  
		 * @param base the next statement in the descending stack
		 * @param method the method that will be tested
		 * @param test instance where that method is declared
		 * @return an IAsyncStatement
		 * 
		 */		
		function apply( base:IAsyncStatement, method:FrameworkMethod, test:Object ):IAsyncStatement; 
	}
}