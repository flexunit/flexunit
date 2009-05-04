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
 * @author     Michael Labriola <labriola@digitalprimates.net>
 * @version    
 **/ 
package org.flexunit.runners.model {
	import flash.events.EventDispatcher;
	
	import flex.lang.reflect.Method;
	import flex.lang.reflect.utils.MetadataTools;
	
	import org.flexunit.token.AsyncTestToken;
	
	/**
	 * Represents a method on a test class to be invoked at the appropriate point in
	 * test execution. These methods are usually marked with an annotation (such as
	 * {@code @Test}, {@code @Before}, {@code @After}, {@code @BeforeClass}, {@code
	 * @AfterClass}, etc.)
	 */
	public class FrameworkMethod extends EventDispatcher {
		
		private var parentToken:AsyncTestToken;

		private var _method:Method;

		/**
		 * Returns a new {@code FrameworkMethod} for {@code method}
		 */
		//We don't really have a method class, but we do have a chunk of XML that can describe our 
		//method, so we will preserve it that way I also suspect we are going to need a class reference 
		//to do all of the elegant things the Java implementation can do
		public function FrameworkMethod( method:Method ) {
			_method = method;
		}
		/**
		 * Returns the underlying method
		 */
		public function get method():Method {
			return _method;
		}

		/**
		 * Returns the method's name
		 */
		public function get name():String {
			return method.name;
		}
		
		public function get metadata():XMLList {
			return method.metadata;
		}

		//Consider upper/lower case issues
		public function getSpecificMetaDataArg( metaDataTag:String, key:String ):String {
			var returnValue:String = MetadataTools.getArgValueFromMetaDataNode( method.methodXML, metaDataTag, key );
			
			if ( !returnValue || ( returnValue.length == 0 ) ) {
				//if we didn't find that string, we try one more thing, which is to look for that value with a blank string
				//this is important for cases where we use the key as a marker and not actually a name/value pair
				var returnBool:Boolean = MetadataTools.checkForValueInBlankMetaDataNode( method.methodXML, metaDataTag, key );
				
				if ( returnBool ) {
					returnValue = "true";
				}
			}
			
			return returnValue;
		}

		public function hasMetaData( metaDataTag:String ):Boolean {
			return MetadataTools.nodeHasMetaData( method.methodXML, metaDataTag );
		}

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

		public function applyExplosivelyAsync( parentToken:AsyncTestToken, target:Object, params:Array ):void {
			this.parentToken = parentToken;

			//var method:Function = getMethodFromTarget( target );
			
			var methodCall:ReflectiveCallable = new ReflectiveCallable( method, target, params );
			var result:Object = methodCall.run();
			
			parentToken.sendResult();
		}
		
		/**
		 * Returns the result of invoking this method on {@code target} with
		 * parameters {@code params}. {@link InvocationTargetException}s thrown are
		 * unwrapped, and their causes rethrown.
		 */
		public function invokeExplosivelyAsync( parentToken:AsyncTestToken, target:Object, ...params ):void {
			applyExplosivelyAsync( parentToken, target, params );
		}

		public function invokeExplosively( target:Object, ...params ):Object {
			//var method:Function = getMethodFromTarget( target );
			var methodCall:ReflectiveCallable = new ReflectiveCallable( method, target, params );
			var result:Object = methodCall.run();
			
			return result;
		}

		protected function asyncComplete( error:Error ):void {
			parentToken.sendResult( error );
		}

		/**
		 * Adds to {@code errors} if this method:
		 * <ul>
		 * <li>is not public, or
		 * <li>takes parameters, or
		 * <li>returns something other than void, or
		 * <li>is static (given {@code isStatic is false}), or
		 * <li>is not static (given {@code isStatic is true}).
		 */
		public function validatePublicVoidNoArg( isStatic:Boolean, errors:Array ):void {
			validatePublicVoid(isStatic, errors);

			var needsParams:Boolean = method.parameterTypes.length > 0;

			if ( needsParams )
				errors.add(new Error("Method " + name + " should have no parameters"));
		}

		/**
		 * Adds to {@code errors} if this method:
		 * <ul>
		 * <li>is not public, or
		 * <li>returns something other than void, or
		 * <li>is static (given {@code isStatic is false}), or
		 * <li>is not static (given {@code isStatic is true}).
		 */
		public function validatePublicVoid( isStatic:Boolean, errors:Array ):void {

			if ( method.isStatic != isStatic) {
				var state:String = isStatic ? "should" : "should not";
				errors.add( new Error("Method " + name + "() " + state + " be static"));
			}

//			if (!Modifier.isPublic(fMethod.getDeclaringClass().getModifiers()))
//				errors.add(new Exception("Class " + fMethod.getDeclaringClass().getName() + " should be public"));
//			if (!Modifier.isPublic(fMethod.getModifiers()))
//				errors.add(new Exception("Method " + fMethod.getName() + "() should be public"));

			var isVoid:Boolean = !method.returnType;

			if ( !isVoid )
				errors.add(new Error("Method " + name + "() should be void"));
		}

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