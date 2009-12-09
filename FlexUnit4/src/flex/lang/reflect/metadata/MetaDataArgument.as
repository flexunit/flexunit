package flex.lang.reflect.metadata {
	public class MetaDataArgument {
		private var argument:XML;
		private var _key:String;
		private var _value:String;

		public function get key():String {
			return _key;
		}
		
		public function get value():String {
			return _value;
		}

		public function MetaDataArgument( argument:XML ) {
			this.argument = argument;
			
			var potentialKey:String = argument.@key;
			_value = argument.@value;

			if ( potentialKey && potentialKey.length>0 ) {
				_key = potentialKey;
				_value = argument.@value; 
			} else {
				_key = _value;
				_value = "true";
			}
		}
	}
}
