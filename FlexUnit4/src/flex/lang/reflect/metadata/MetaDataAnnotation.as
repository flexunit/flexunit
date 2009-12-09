package flex.lang.reflect.metadata {
	public class MetaDataAnnotation {
		private var metaData:XML;
		private var _name:String;
		private var _arguments:Array;

		public function get name():String {
			return _name;
		}
		
		public function get arguments():Array {
			if ( !_arguments ) {
				_arguments = buildArguments();
			}

			return _arguments;
		}
		
		public function get defaultArgument():MetaDataArgument {
			var firstArg:MetaDataArgument;

			if ( arguments && arguments.length > 0 ) {
				firstArg = arguments[ 0 ];	
			}
			
			return firstArg;
		}
		
		public function hasArgument( key:String ):Boolean {
			return ( getArgument( key ) != null );
		}
		
		public function getArgument( key:String, caseInsensitive:Boolean = false ):MetaDataArgument {
			var argsLen:int = this.arguments.length;
			var needleKey:String = key;
			
			if ( caseInsensitive && key ) {
				needleKey = needleKey.toLowerCase();
			}

			for ( var i:int=0; i<argsLen; i++ ) {
				var hayStackKey:String = ( this.arguments[ i ] as MetaDataArgument ).key;
				
				if ( caseInsensitive && hayStackKey ) {
					hayStackKey = hayStackKey.toLowerCase();
				}

				if ( ( this.arguments[ i ] as MetaDataArgument ).key == key ) {
					return this.arguments[ i ];
				}
			}	
			
			return null;
		}

		protected function buildArguments():Array {
			var arguments:Array = new Array();
			var args:XMLList = metaData.arg;

			if ( args && args.length() ) {
				for ( var i:int=0; i<args.length(); i++ ) {
					arguments.push( new MetaDataArgument( args[ i ] ) );
				}
			}
			
			return arguments;
		}

		public function MetaDataAnnotation( metaDataXML:XML ) {
			this.metaData = metaDataXML;
			_name = metaDataXML.@name;
		}
	}
}