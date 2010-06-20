package org.flexunit.runner.manipulation.filters {
	import org.flexunit.runner.IDescription;

	/**
	 * 
	 * Filter that matches method names. A matching method name means the method will be executed
	 * 
	 * @author mlabriola
	 * 
	 */
	public class MethodNameFilter extends AbstractFilter {
		/**
		 * @private 
		 */
		private var methodNames:Array;

		/**
		 * 
		 * @inheritDoc
		 * 
		 */
		override public function shouldRun(description:IDescription) : Boolean {
			var methodName:String = "";
			
			if ( !description.isTest ) {
				//We are on;y interested in filtering out method names with this filter
				return true;
			}
			
			if ( description && description.displayName ) {
				var namePieces:Array = description.displayName.split( '.' );
				if ( namePieces && namePieces.length > 0 ) {
					methodName = namePieces[namePieces.length-1];
				}
			}
			
			return ( methodNames.indexOf( methodName ) != -1 );			
		}
		
		/**
		 * 
		 * @inheritDoc
		 * 
		 */
		override public function describe(description:IDescription) : String {
			return "Matching method list.";
		}
		
		/**
		 * 
		 * Constructor
		 * 
		 */
		public function MethodNameFilter( methodNames:Array ) {
			super();
			
			if ( methodNames == null ) {
				throw new TypeError( "You must provide an array of Method Names to the MethodNameFilter" );
			}
			this.methodNames = methodNames;
		}
	}
}