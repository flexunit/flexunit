/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package flex.lang.reflect {
	import flash.utils.describeType;
	
	/**
	 * Parses &lt;constructor/&gt; node returned from a call to <code>describeType</code> to provide an
	 * object wrapper for the Constructor
	 * 
	 * @see Klass
	 * @see Method
	 * @see Field
	 */
	public class Constructor {
		/**
		 * @private
		 */
		private var _constructorXML:XML;
		/**
		 * @private
		 */
		private var _klass:Klass;
		/**
		 * @private
		 */
		private var requiredArgNum:int = 0;
		/**
		 * @private
		 */
		private var triedToRegetConstructorParams:Boolean = false;
		
		/**
		 * @private
		 */
		private var _parameterTypes:Array;
		
		/**
		 *  Builds and returns an Array containing the types of 
		 *  of parameters used by the Constructor
		 * 
		 *  @return _parameterTypes
		 */
		public function get parameterTypes():Array {
			if ( !_parameterTypes ) {
				_parameterTypes = buildParamTypeArray();
			}

			return _parameterTypes;
		}

		/**
		 * @private
		 */
		private function buildParamTypeArray():Array {
			//We have been asked for our params, this can actually suck quite a bit due to a bug
			//if we have not attempted to instantiate the class before the describeType call that run in the flex.lang.reflect.Klass instance
			//then we may not get valid param types, so we need to handle this... let's call it carefully 
			var typesList:XMLList = _constructorXML.parameter;
			var typeName:String;
			var type:Class;
			var ar:Array = new Array();
			var lastRequiredFound:Boolean = false;
			
			for ( var i:int=0; i<typesList.length(); i++ ) {
				typeName = typesList[ i ].@type;
				
				if ( typeName != "*" ) {
					type = Klass.getClassFromName( typesList[ i ].@type );	
				} else {
					type = null;
				}
				
				ar.push( type );
				
				if ( !lastRequiredFound ) {
					if ( typesList[ i ].@optional == "false" ) {
						requiredArgNum++;
					} else {
						lastRequiredFound = true;
					}
				}
			}
			
			if ( !triedToRegetConstructorParams ) {
				if ( ar.length > 0 ) {
					//we have params, but are any of null type
					var missingParamType:Boolean = false;
					for ( var j:int=0; j<ar.length; j++ ) {
						if ( ar[ j ] == null ) {
							missingParamType = true;
							break;	
						} 
					}
					
					if ( missingParamType ) {
						//we might have a missing param... we have to say migt because it could also be that the developer really
						//did declare this particular field of type "*", in which case, we have no idea if all is well, or if we need the data
						//so, we have to go through the longer loop here
						_parameterTypes = ar;
						//reset the number of required arguments as we are about to recompute this
						requiredArgNum = 0;
						ar = instantiateAndRegetParamTypes( typesList.length() );
					}
				}
			}
			
			return ar;
		}
		
		/**
		 * @private
		 */
		private function instantiateAndRegetParamTypes( numArgs:int ):Array {
			triedToRegetConstructorParams = true;

			try {
				//this is crucial. this is some weirdness if you don't pass all args .. not just required, but for anything you might want to know the type of later
				var params:Array = new Array( numArgs );
				newInstanceApply( params );
			} catch ( e:Error ) {
				//blow this off, it is okay, we just may have had an error during construction because we are passing nulls
			}
			
			//Ask the Klass to recache its XML based on the actionscript class definition 
			_klass.refreshClassXML( _klass.asClass );
			
			//I don't think this should be here
			//var x:XML = describeType( _klass.asClass );
			
			//Recache our internal XML structure 
			_constructorXML = _klass.constructorXML;

			//return newly queried array params
			return buildParamTypeArray();
		}

		/**
		 * @private
		 */
		private static var argMap:Array = [ createInstance0, createInstance1, createInstance2, createInstance3, createInstance4, createInstance5 ];
		//okay, so AS doesn't really allow us to do an apply on the constructor, so we need to fake it
		/**
		 * @private
		 */
		private static function createInstance0( klass:Class ):* {
			return new klass();
		}

		/**
		 * @private
		 */
		private static function createInstance1( clazz:Class, arg1:* ):* {
			return new clazz( arg1 );
		}

		/**
		 * @private
		 */
		private static function createInstance2( clazz:Class, arg1:*, arg2:* ):* {
			return new clazz( arg1, arg2 );
		}

		/**
		 * @private
		 */
		private static function createInstance3( clazz:Class, arg1:*, arg2:*, arg3:* ):* {
			return new clazz( arg1, arg2, arg3 );
		}

		/**
		 * @private
		 */
		private static function createInstance4( clazz:Class, arg1:*, arg2:*, arg3:*, arg4:* ):* {
			return new clazz( arg1, arg2, arg3, arg4 );
		}

		/**
		 * @private
		 */
		private static function createInstance5( clazz:Class, arg1:*, arg2:*, arg3:*, arg4:*, arg5:* ):* {
			return new clazz( arg1, arg2, arg3, arg4, arg5 );
		}
	
		/**
		 * @private
		 */
		private function canInstantiateWithParams( args:Array ):Boolean {
			var maxArgs:int = parameterTypes.length;

			if ( args.length < requiredArgNum || args.length > maxArgs ) {
				return false;
			}

			//Eventually, we need to verify that each param type is acceptable as well
			return true;
		}
		
		/**
		 * Creates a new instance of an object using the constructor definition
		 * 
		 * @param params An array of paramaters to be used by the constructor (max 5). 
		 * 
		 * @return A new instance of the object created by this constructor
		 * 
		 * @see #newInstance()
		 */
		public function newInstanceApply( params:Array ):Object {
			
			if ( !params ) {
				//null should mean the same as no params
				params = [];
			}
			
			var localParams:Array = params.slice();
			var mapIndex : uint = Math.min( parameterTypes.length, localParams.length );
			
			if ( !canInstantiateWithParams( localParams ) || ( requiredArgNum > mapIndex ) ) {
				throw new ArgumentError("Invalid number or type of arguments to contructor");
			}    

			if ( localParams.length > argMap.length ) {
				throw new ArgumentError("Sorry, we can't support constructors with more than " + argMap.length + " args out of the box... yes, its dumb, take a look at Constructor.as to modify on your own");
			}
			
			var generator:Function = argMap[ mapIndex ];
			localParams.unshift( _klass.classDef );
			
			return generator.apply( null, localParams );
			
		}
		
		/**
		 * Creates a new instance of an object using the constructor definition.  The maximum paramater
		 * list is currently restriced to 5.  If more paramaters are needed, take a look at <code>
		 * Constructor.as</code> on how to create your own.
		 * 
		 * @param args the arguments to pass to the constructor(max 5).
		 * 
		 * @return A new instance of the object created by this constructor
		 */
		public function newInstance( ...args ):Object {
			return newInstanceApply( args );
		}

		/**
		 * Constructor
		 *  
		 * Parses &lt;constructor/&gt; node returned from a call to <code>describeType</code> to provide an 
		 * object wrapper for the Constructor
		 * 
		 * Expected format of the argument is
		 * 		&lt;constructor&gt;
		 * 			&lt;parameter index=&quot;1&quot; type=&quot;*&quot; optional=&quot;false&quot;/&gt;
		 * 		&lt;/constructor&gt;		 
		 *  
		 * @param A &lt;constructor/&gt; XML node.
		 * 
		 */
		public function Constructor( constructorXML:XML, klass:Klass ) {
			
			//Unlike the other metadata class parsers, this one creates a default node if it does not exist
			//in the xml serving the role of a default constructor
			if ( constructorXML ) {
				_constructorXML = constructorXML;
			} else {
				_constructorXML = <constructor/>;
			}
			 
			_klass = klass;
		}
	}
}