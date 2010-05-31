/**
 * Copyright (c) 2010 Digital Primates IT Consulting Group
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
package org.flexunit.internals.dependency {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import flex.lang.reflect.Field;
	import flex.lang.reflect.Klass;
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.constants.AnnotationArgumentConstants;
	import org.flexunit.constants.AnnotationConstants;
	import org.flexunit.internals.builders.MetaDataBuilder;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.external.ExternalDependencyToken;
	import org.flexunit.runner.external.IExternalDependencyLoader;
	import org.flexunit.runner.external.IExternalDependencyRunner;

	public class ExternalDependencyResolver extends EventDispatcher implements IExternalDependencyResolver {
		public static const ALL_DEPENDENCIES_FOR_RUNNER_RESOLVED:String = "runnerDependenciesResolved";
		public static const DEPENDENCY_FOR_RUNNER_FAILED:String = "runnerDependencyFailed";

		//just used to check if they are a RunWith class
		private static var metaDataBuilder:MetaDataBuilder;
		private var clazz:Class;
		private var dependencyMap:Dictionary;
		private var runner:IExternalDependencyRunner;
		
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
					metaDataAnnotation = targetField.getMetaData( AnnotationConstants.PARAMETERS );
					
					if ( !metaDataAnnotation ) {
						metaDataAnnotation = targetField.getMetaData( AnnotationConstants.DATA_POINTS );
					}
					
					if ( metaDataAnnotation ) {
						arguments = metaDataAnnotation.arguments;
						
						for ( var j:int=0 ; j<arguments.length; j++ ) {
							argument = arguments[ j ] as MetaDataArgument;
							
							if ( argument.key == AnnotationArgumentConstants.LOADER ) {
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

			if ( keyCount == 0 ) {
				//all done
				dispatchEvent( new Event( ALL_DEPENDENCIES_FOR_RUNNER_RESOLVED ) );
			}
		} 
		
		public function dependencyFailed( token:ExternalDependencyToken, errorMessage:String ):void {
			
			//Okay, badness.. stop listening to all outstanding requests
			for ( var key:* in dependencyMap ) {
				var foundToken:ExternalDependencyToken = key as ExternalDependencyToken;
				manageResponseCleanup( foundToken );
			} 
			
			runner.externalDependencyError = errorMessage;

			dispatchEvent( new Event( DEPENDENCY_FOR_RUNNER_FAILED ) );
		}

		private function manageResponseCleanup( token:ExternalDependencyToken ):void {
			token.removeResolver( this );
			
			delete dependencyMap[ token ];
		}

		private function shouldResolveClass():Boolean {
			 return metaDataBuilder.canHandleClass( clazz );
		}
		
		public function ExternalDependencyResolver( clazz:Class, runner:IExternalDependencyRunner ) {
			this.clazz = clazz;
			this.dependencyMap = new Dictionary();
			this.runner = runner;

			if ( !metaDataBuilder ) {
				metaDataBuilder = new MetaDataBuilder(null);
			}
		}
	}
}
