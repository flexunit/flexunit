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
package org.flexunit.internals.runners.watcher {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import org.fluint.uiImpersonation.IVisualEnvironmentBuilder;
	import org.fluint.uiImpersonation.IVisualTestEnvironment;
	import org.fluint.uiImpersonation.VisualTestEnvironmentBuilder;
	
	public class FrameWatcher {
		private static var instance:FrameWatcher;
		private var _stage:Stage;
		private var lastEnterFrameTime:Number = 0;
		
		public static const ALLOWABLE_FRAME_USE:Number = .85;
		
		//Approximate mode means that we don't have a reference to the stage so we can't observe the real
		//frame rate. So, in approximate mode, the StackAndFrameManagement code informs us of the last time it ran
		//and we use that number plus an approximation of the frame to make decisions
		private var _approximateMode:Boolean = true;
		
		private var fps:Number = 24;
		
		//Frame length is 1second (1000ms)/fps
		private var frameLength:Number = 1000/fps;
		//Use 85% of the frame
		private var maxFrameUsage:Number = frameLength * ALLOWABLE_FRAME_USE;
		
		public function get stage():Stage {
			return _stage; 
		}
		
		public function set stage( value:Stage ):void {
			
			if ( _stage ) {
				_stage.removeEventListener( Event.ENTER_FRAME, handleEnterFrame );
			}
			
			_stage = value;

			if ( _stage ) {
				fps = Math.max( stage.frameRate, 1 );
				frameLength = 1000/fps;
				maxFrameUsage = frameLength * ALLOWABLE_FRAME_USE;
				
				_approximateMode = false;
				_stage.addEventListener( Event.ENTER_FRAME, handleEnterFrame );
			} 
		}
		
		public function get approximateMode():Boolean {
			return _approximateMode; 
		}
		
		public function get timeRemaining():Boolean {
			var time:Number = ( getTimer() - lastEnterFrameTime );
			var tr:Boolean = ( time < maxFrameUsage );
			
			return tr;
		}
		
		public function simulateTick():void {
			lastEnterFrameTime = getTimer();
		}
		
		private function handleEnterFrame( event:Event ):void {
			lastEnterFrameTime = getTimer();
		}

		protected function getStage():Stage {
			/* try to get the stage through any means possible
			   Best case, someone will have given us the stage, 
			   through the VisualEnvironmentBuilder
			
			   If it wasn't specied, and we are running as Flex, that is possible, else likely not
			*/
			var testEnvironment:IVisualEnvironmentBuilder = VisualTestEnvironmentBuilder.getInstance();
			var environment:IVisualTestEnvironment = testEnvironment.buildVisualTestEnvironment();		
			
			if ( environment is DisplayObject ) {
				return ( environment as DisplayObject ).stage;
			}
			
			return null;
		}
			
		public function FrameWatcher( stage:Stage=null ) {
			if ( !stage ) {
				//If we weren't passed a stage, then try to find one
				this.stage = getStage();
			} else {
				this.stage = stage;
			}
			
		}
	}
}
