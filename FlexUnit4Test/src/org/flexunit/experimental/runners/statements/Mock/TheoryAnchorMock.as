package org.flexunit.experimental.runners.statements.Mock
{
	import com.anywebcam.mock.Mock;
	
	import org.flexunit.experimental.runners.statements.TheoryAnchor;
	import org.flexunit.internals.AssumptionViolatedException;
	import org.flexunit.internals.namespaces.classInternal;
	import org.flexunit.runners.model.FrameworkMethod;
	import org.flexunit.runners.model.TestClass;
	import org.flexunit.token.AsyncTestToken;
	
	use namespace classInternal;
	
	public class TheoryAnchorMock extends TheoryAnchor
	{
		public var mock:Mock;
		
		override public function evaluate(parentToken:AsyncTestToken):void {
			mock.evaluate(parentToken);
		}
		
		override classInternal function handleAssumptionViolation(e:AssumptionViolatedException):void {
			mock.handleAssumptionViolation(e);
		}
		
		override classInternal function reportParameterizedError(e:Error, ...params):Error {
			return mock.invokeMethod("reportParameterizedError", [e].concat(params));
		}
			
		override classInternal function nullsOk():Boolean {
			return mock.nullsOk();
		}
		
		override classInternal function handleDataPointSuccess():void {
			mock.handleDataPointSuccess();
		}
		
		public function TheoryAnchorMock(method:FrameworkMethod = null, testClass:TestClass = null)
		{
			mock = new Mock(this);
			
			super(method, testClass);
		}
	}
}