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
	import org.flexunit.runner.external.ExternalDependencyToken;
	import org.flexunit.runner.external.IExternalDependencyLoader;

	public class ExternalDependencyResolver extends EventDispatcher implements IExternalDependencyResolver {
		public static const ALL_DEPENDENCIES_FOR_RUNNER_RESOLVED:String = "runnerDependenciesResolved";

		//just used to check if they are a RunWith class
		private static var metaDataBuilder:MetaDataBuilder;
		private var clazz:Class;
		private var dependencyMap:Dictionary;
		
		public function get ready():Boolean {
			return ( keyCount == 0 );
		}

		private function executeDependencyLoader( loaderField:Field, targetField:Field ):void {
			if ( loaderField && loaderField.isStatic ) {
				var loaderFieldInfo:Klass = new Klass( loaderField.type );

				if ( loaderFieldInfo.implementsInterface( IExternalDependencyLoader ) ) {
					var token:ExternalDependencyToken = ( loaderField.getObj( null ) as IExternalDependencyLoader ).retrieveDependency( clazz );
					token.targetField = targetField;
					token.addResolver( this );
					
					dependencyMap[ token ] = targetField;
				}
			}
		}

		public function resolveDependencies():Boolean {
			var klassInfo:Klass = new Klass( clazz );
			var targetFields:Array = klassInfo.fields;
			var targetField:Field;
			var metaDataAnnotation:MetaDataAnnotation;
			var token:ExternalDependencyToken;
			var arguments:Array;
			var argument:MetaDataArgument;
			var loaderField:Field;
			var loaderFieldName:String;
			var counter:uint = 0;

			//perhaps mark the class?
			for ( var i:int=0; i<targetFields.length; i++ ) {
				targetField = targetFields[ i ] as Field;
				
				if ( targetField.isStatic ) {
					metaDataAnnotation = targetField.getMetaData( "Parameters" );
					
					if ( !metaDataAnnotation ) {
						metaDataAnnotation = targetField.getMetaData( "DataPoints" );
					}
					
					if ( metaDataAnnotation ) {
						arguments = metaDataAnnotation.arguments;
						
						for ( var j:int=0 ; j<arguments.length; j++ ) {
							argument = arguments[ j ] as MetaDataArgument;
							
							if ( argument.key == "loader" ) {
								loaderFieldName = argument.value;
								break;
							}
						}
						
						loaderField = klassInfo.getField( loaderFieldName );
						executeDependencyLoader( loaderField, targetField );
						counter++;
					}
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

		public function dependencyResolved( token:ExternalDependencyToken, data:Object ):void {			
			var targetField:Field = token.targetField;
			var clazz:Class = targetField.definedBy;

			if ( data is targetField.type ) {
				clazz[ targetField.name ] = data;	
			} else {
				trace("Yeh, that's an issue");
			}
			
			manageResponseCleanup( token );
		} 
		
		public function dependencyFailed( token:ExternalDependencyToken, error:Object ):void {
			manageResponseCleanup( token );
		}

		private function manageResponseCleanup( token:ExternalDependencyToken ):void {
			token.removeResolver( this );
			
			delete dependencyMap[ token ];
			
			if ( keyCount == 0 ) {
				//all done
				dispatchEvent( new Event( ALL_DEPENDENCIES_FOR_RUNNER_RESOLVED ) );
			}
		}

		private function shouldResolveClass():Boolean {
			 return metaDataBuilder.canHandleClass( clazz );
		}
		
		public function ExternalDependencyResolver( clazz:Class ) {
			this.clazz = clazz;
			this.dependencyMap = new Dictionary();

			if ( !metaDataBuilder ) {
				metaDataBuilder = new MetaDataBuilder(null);
			}
		}
	}
}
