package org.flexunit.rules {
	import org.flexunit.internals.runners.statements.IAsyncStatement;
	import org.flexunit.runners.model.FrameworkMethod;

	public interface IMethodRule extends IAsyncStatement {
		function apply( base:IAsyncStatement, method:FrameworkMethod, test:Object ):IAsyncStatement; 
	}
}