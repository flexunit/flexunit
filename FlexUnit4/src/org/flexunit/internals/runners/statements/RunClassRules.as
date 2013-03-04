package org.flexunit.internals.runners.statements {

	import flash.utils.getQualifiedClassName;
	
	import flex.lang.reflect.Field;
	
	import org.flexunit.internals.runners.InitializationError;
	import org.flexunit.rules.IMethodRule;
	import org.flexunit.runners.model.TestClass;
	
	/**
	 * The <code>RunClassRules</code> is a <code>StatementSequencer</code> for potential static fields 
	 * that have <code>Rule</code> metadata and should be run before the test class has been created.
	 */
	public class RunClassRules extends StatementSequencer implements IAsyncStatement {
		
		/**
		 * @private
		 */
		private var target:Object;
		
		/**
		 * @private
		 */
		override public function toString():String {
			return "RunClassRules";
		}
		
		/**
		 * @private
		 */
		override protected function executeStep( child:* ):void {
			super.executeStep( child );
			
			var statement:IAsyncStatement = withPotentialRule( child as Field, target, new StatementSequencer() );
			try {
				if ( statement is IMethodRule ) {
					statement.evaluate( myToken );
				}
			} catch ( error:Error ) {
				errors.push( error );
			}
		}
		
		/**
		 * Constructor.
		 * 
		 * @param rules An array containing all rules that need to be executed before the class is created.
		 * @param target The test class.
		 */
		public function RunClassRules( classRules:Array, target:Object ) {
			super( classRules );
			
			this.target = target;
		}
		
		/**
		 * Potentially returns a new <code>IAsyncStatement</code> defined by the user on the testcase via the Rule metadata.
		 */
		protected function withPotentialRule( ruleField:Field, test:Object, statement:IAsyncStatement ):IAsyncStatement {
			var testClass:Class = TestClass( test ).asClass;
			var rule:IMethodRule;
			
			if (testClass[ ruleField.name ] is IMethodRule ) {
				rule = testClass[ ruleField.name ] as IMethodRule;
				
				//build statement wrapper
				statement = rule.apply( statement, null, testClass );
			} else {
				var ruleVal:* = testClass[ ruleField.name ];
				var typeOfRule:String = ruleVal ? getQualifiedClassName( ruleVal ) : "null";
				throw new InitializationError( ruleField.name + " is marked as [Rule] but does not implement IMethodRule. It appears to be " + typeOfRule );
			}
			
			return statement;
		}
	}	
}