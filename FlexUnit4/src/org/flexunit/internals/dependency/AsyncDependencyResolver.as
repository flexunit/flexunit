package org.flexunit.internals.dependency {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import flex.lang.reflect.Field;
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.internals.builders.MetaDataBuilder;

	public class AsyncDependencyResolver extends EventDispatcher {
		//just used to check if they are a RunWith class
		private static var metaDataBuilder:MetaDataBuilder;
		private var clazz:Class;
		private var dependencyMap:Dictionary;

		private function executeDependencyMethod( method:Method, field:Field ):void {
			if ( method && method.isStatic && ( method.returnType == AsyncDependencyToken ) ) {
				var token:AsyncDependencyToken = method.invoke(null) as AsyncDependencyToken;
				token.field = field;
				token.addResolver( this );
				
				dependencyMap[ token ] = field;
			}
		}

		public function lookForUnresolvedDependencies():Boolean {
			var klassInfo:Klass = new Klass( clazz );
			var fields:Array = klassInfo.fields;
			var field:Field;
			var metaDataAnnotation:MetaDataAnnotation;
			var token:AsyncDependencyToken;
			var arguments:Array;
			var argument:MetaDataArgument;
			var method:Method;
			var methodName:String;
			var counter:uint = 0;

			//perhaps mark the class?
			for ( var i:int=0; i<fields.length; i++ ) {
				field = fields[ i ] as Field;
				
				if ( field.isStatic && field.hasMetaData( "Parameters" ) ) {
					metaDataAnnotation = field.getMetaData( "Parameters" );
					
					arguments = metaDataAnnotation.arguments;
					
					for ( var j:int=0 ; j<arguments.length; j++ ) {
						argument = arguments[ j ] as MetaDataArgument;
						
						if ( argument.key == "method" ) {
							methodName = argument.value;
							break;
						}
					}
					
					method = klassInfo.getMethod( methodName );
					executeDependencyMethod( method, field );
					counter++;
				}
			}
			
			return ( counter > 0 );
		}

		private function get keyCount():int {
			var counter:int = 0;

			for ( var key:* in dependencyMap ) {
				counter++;
			} 
			
			return counter;
		}

		public function dependencyResolved( token:AsyncDependencyToken, data:Object ):void {			
			var field:Field = token.field;
			var clazz:Class = field.definedBy;

			if ( data is field.type ) {
				clazz[ field.name ] = data;	
			} else {
				trace("Yeh, that's an issue");
			}
			
			token.removeResolver( this );
			
			delete dependencyMap[ token ];
			
			if ( keyCount == 0 ) {
				//all done
			
				dispatchEvent( new Event("complete") );
			}
		} 

		private function shouldResolveClass():Boolean {
			 return metaDataBuilder.canHandleClass( clazz );
		}
		
		public function AsyncDependencyResolver( clazz:Class ) {
			this.clazz = clazz;
			this.dependencyMap = new Dictionary();

			if ( !metaDataBuilder ) {
				metaDataBuilder = new MetaDataBuilder(null);
			}
		}
	}
}
