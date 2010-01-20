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
package org.flexunit.runners.model {
	import flash.events.EventDispatcher;
	
	import flex.lang.reflect.Method;
	import flex.lang.reflect.metadata.MetaDataAnnotation;
	import flex.lang.reflect.metadata.MetaDataArgument;
	
	import org.flexunit.token.AsyncTestToken;
	
	/**
	 * Represents a method on a test class to be invoked at the appropriate point in
	 * test execution. These methods are usually marked with an annotation (such as
	 * <code>Test</code>, <code>Before</code>, <code>After</code>, <code>BeforeClass</code>, 
	 * <code>AfterClass</code>, etc.).
	 */
	public class FrameworkMethod extends EventDispatcher {
		
		/**
		 * @private
		 */
		private var parentToken:AsyncTestToken;
		
		/**
		 * @private
		 */
		private var _method:Method;

		/**
		 * Construcotr.
		 * 
		 * Returns a new <code>FrameworkMethod</code> for a provided<code>method</code>.
		 * 
		 * @param method The metadata for a particular test method.
		 */
		//We don't really have a method class, but we do have a chunk of XML that can describe our 
		//method, so we will preserve it that way I also suspect we are going to need a class reference 
		//to do all of the elegant things the Java implementation can do
		public function FrameworkMethod( method:Method ) {
			_method = method;
		}
		/**
		 * Returns the underlying method.
		 */
		public function get method():Method {
			return _method;
		}

		/**
		 * Returns the method's name.
		 */
		public function get name():String {
			return method.name;
		}
		
		/**
		 * Returns the method's metadata.
		 */
		public function get metadata():Array {
			return method.metadata;
		}

		//Consider upper/lower case issues
		/**
		 * Returns a metadata argument string based on whether the method's metadata has a matching <code>metaDataTag</code>
		 * and <code>key</code>.
		 * 
		 * @param metaDataTag The metadata tag to search for in the method's metadata.
		 * @param key The key to find a specific atrribute argument in the <code>metaDataTag</code>.
		 * 
		 * @return the specific String if the <code>metaDataTag</code> and <code>key</code> exist, a value of 'true' if there 
		 * is an argument that has a value that matches the <code>key</code>, or an empty or null String if the key is not 
		 * found for the given <code>metaDataTag</code>.
		 */
		public function getSpecificMetaDataArgValue( metaDataTag:String, key:String ):String {
			var metaDataAnnotation:MetaDataAnnotation = method.getMetaData( metaDataTag );
			var metaDataArgument:MetaDataArgument;
			var returnValue:String;
			
			if ( metaDataAnnotation ) {
				metaDataArgument = metaDataAnnotation.getArgument( key, true );
			}
			
			if ( metaDataArgument ) {			
				returnValue = metaDataArgument.value;
			}
			
			return returnValue;
		}
		
		/**
		 * Determine if the method has metadata for a specific <code>metaDataTag</code>.
		 * 
		 * @param metaDataTag The metadata tag to search for in the method's metadata.
		 * 
		 * @return a Boolean value indicating if the method has specific metadata that matches the <code>metaDataTag</code>.
		 */
		public function hasMetaData( metaDataTag:String ):Boolean {
			return method.hasMetaData( metaDataTag );
		}
		
		/**
		 * Returns a Boolean value indicating whether the method has no parameters and 
		 * whether the method has a return type that matches the provided <code>type</code>.
		 * 
		 * @param type The return type to check for in the method.
		 * 
		 * @reutrn a Boolean value indicating whether the method has no parameters and 
		 * whether the method has a return type that matches the provided <code>type</code>.
		 */
		public function producesType( type:Class ):Boolean {
			return ( ( method.parameterTypes.length == 0 ) &&
					( type == method.returnType ) );
		}
			
/* 		protected function getMethodFromTarget( target:Object ):Function {
			//var method:Function;
			
			if ( target is TestClass ) {
				//this is a static method
				method = target.asClass[ name ];
			} else {
				//this is an instance method
				method = target[ name ];
			}
			
			return method;
		} */
		
		/**
		 * Calls the method with the provided set of <code>params</code> for the <code>target</code> class.
		 * Once the method has finished execution, instruct the <code>parentToken</code> that the method
		 * has finished running.
		 * 
		 * @param parentToken The <code>AsyncTestToken</code> to be notified when the method has been run.
		 * @param target The class that contains the method.
		 * @param params The parameters to be supplied to the method.
		 */
		public function applyExplosivelyAsync( parentToken:AsyncTestToken, target:Object, params:Array ):void {
			this.parentToken = parentToken;

			//var method:Function = getMethodFromTarget( target );
			
			var methodCall:ReflectiveCallable = new ReflectiveCallable( method, target, params );
			var result:Object = methodCall.run();
			
			parentToken.sendResult();
		}
		
		/**
		 * Returns the result of invoking this method on <code>target</code> with
		 * parameters <code>params</code>. <code>InvocationTargetException</code>s thrown are
		 * unwrapped, and their causes rethrown.
		 * 
		 * @param parentToken The <code>AsyncTestToken</code> to be notified when the method has been run.
		 * @param target The class that contains the method.
		 * @param params The parameters to be supplied to the method.
		 */
		public function invokeExplosivelyAsync( parentToken:AsyncTestToken, target:Object, ...params ):void {
			applyExplosivelyAsync( parentToken, target, params );
		}
		
		/**
		 * Calls the method with the provided set of <code>params</code> for the <code>target</code> class.
		 * 
		 * 
		 * @param parentToken The <code>AsyncTestToken</code> to be notified when the method has been run.
		 * @param target The class that contains the method.
		 * @param params The parameters to be supplied to the method.
		 */
		public function invokeExplosively( target:Object, ...params ):Object {
			//var method:Function = getMethodFromTarget( target );
			var methodCall:ReflectiveCallable = new ReflectiveCallable( method, target, params );
			var result:Object = methodCall.run();
			
			return result;
		}
		
		/**
		 * Alerts the parentToken that the operation has been completed.
		 * 
		 * @param error A potential error encoutnered during the process.
		 */
		protected function asyncComplete( error:Error ):void {
			parentToken.sendResult( error );
		}

		/**
		 * Adds to <code>errors</code> if this method:
		 * <ul>
		 * <li>is not public, or</li>
		 * <li>takes parameters, or</li>
		 * <li>returns something other than void, or</li>
		 * <li>is static (given <code>isStatic</code> is <code>false</code>), or</li>
		 * <li>is not static (given <code>isStatic</code> is <code>true</code>).</li>
		 * </ul>
		 * 
		 * @param isStatic A Boolean value indicating whether it is acceptable that the method
		 * is a static method.
		 * @param errors An array of errors that will potential have the current method added if
		 * the method does not fufill the proper criteria.
		 */
		public function validatePublicVoidNoArg( isStatic:Boolean, errors:Array ):void {
			validatePublicVoid(isStatic, errors);

			var needsParams:Boolean = method.parameterTypes.length > 0;

			if ( needsParams )
				errors.push(new Error("Method " + name + " should have no parameters"));
		}

		/**
		 * Adds to <code>errors</code> if this method:
		 * <ul>
		 * <li>is not public, or</li>
		 * <li>returns something other than void, or</li>
		 * <li>is static (given <code>isStatic</code> is <code>false</code>), or</li>
		 * <li>is not static (given <code>isStatic</code> is <code>true</code>).</li>
		 * </ul>
		 * 
		 * @param isStatic A Boolean value indicating whether it is acceptable that the method
		 * is a static method.
		 * @param errors An array of errors that will potential have the current method added if
		 * the method does not fufill the proper criteria.
		 */
		public function validatePublicVoid( isStatic:Boolean, errors:Array ):void {

			if ( method.isStatic != isStatic) {
				var state:String = isStatic ? "should" : "should not";
				errors.push( new Error("Method " + name + "() " + state + " be static"));
			}

//			if (!Modifier.isPublic(fMethod.getDeclaringClass().getModifiers()))
//				errors.push(new Exception("Class " + fMethod.getDeclaringClass().getName() + " should be public"));
//			if (!Modifier.isPublic(fMethod.getModifiers()))
//				errors.push(new Exception("Method " + fMethod.getName() + "() should be public"));

			var isVoid:Boolean = !method.returnType;

			if ( !isVoid )
				errors.push(new Error("Method " + name + "() should be void"));
		}
		
		/**
		 * @private
		 * @return
		 */
		override public function toString():String {
			return "FrameworkMethod " + this.name;
		}
	}
}


import org.flexunit.internals.runners.model.IReflectiveCallable;
import flex.lang.reflect.Method;

class ReflectiveCallable implements IReflectiveCallable {
	private var method:Method;
	private var target:Object;
	private var params:Array;

	public function ReflectiveCallable( method:Method, target:Object, params:Array ) {
		this.method = method;
		this.target = target;
		this.params = params;
	}
	
	public function run():Object {
		try {
			return method.apply( target, params );
		} catch ( error:Error ) {
			//this is a wee bit different than the java equiv... need to ponder more
			throw error;
		}
		
		return null;
	}
}