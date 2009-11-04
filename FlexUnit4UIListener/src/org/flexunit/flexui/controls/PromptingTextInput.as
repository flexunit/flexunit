/*
Copyright (c) 2007 FlexLib Contributors.  See:
    http://code.google.com/p/flexlib/wiki/ProjectContributors

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package org.flexunit.flexui.controls
{

   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.text.TextField;

   import mx.controls.TextInput;
   import mx.events.FlexEvent;

   /**
    * The <code>PromptingTextInput</code> component is a small enhancement to
    * standard <code>TextInput</code>.  It adds the ability to specify a prompt
    * value that displays when the text is empty, similar to how the prompt
    * property of the <code>ComboBox</code> behaves when there is no selected value.
    */
   public class PromptingTextInput extends TextInput
   {
   	/** Flag to indicate if the text is empty or not */
   	private var _textEmpty:Boolean;

   	/**
   	 * Flag to prevent us from re-inserting the prompt if the text is cleared
   	 * while the component still has focus.
   	 */
   	private var _currentlyFocused:Boolean = false;


   	/**
   	 * Constructor
   	 */
   	public function PromptingTextInput()
   	{
   		_textEmpty = true;

   		addEventListener( Event.CHANGE, handleChange );
   		addEventListener( FocusEvent.FOCUS_IN, handleFocusIn );
   		addEventListener( FocusEvent.FOCUS_OUT, handleFocusOut );
   	}

   	// ==============================================================
   	//	prompt
   	// ==============================================================

   	/** Storage for the prompt property */
   	private var _prompt:String = "";

   	/**
   	 * The string to use as the prompt value
   	 */
   	public function get prompt():String
   	{
   		return _prompt;
   	}

   	[Bindable]
   	public function set prompt( value:String ):void
   	{
   		_prompt = value;

   		invalidateProperties();
   	}

   	// ==============================================================
   	//	promptFormat
   	// ==============================================================

   	/** Storage for the promptFormat property */
   	private var _promptFormat:String = '<font color="#999999"><i>[prompt]</i></font>';

   	/**
   	 * A format string to specify how the prompt is displayed.  This is typically
   	 * an HTML string that can set the font color and style.  Use <code>[prompt]</code>
   	 * within the string as a replacement token that will be replaced with the actual
   	 * prompt text.
   	 *
   	 * The default value is "&lt;font color="#999999"&gt;&lt;i&gt;[prompt]&lt;/i&gt;&lt;/font&gt;"
   	 */
   	public function get promptFormat():String
   	{
   		return _promptFormat;
   	}

   	public function set promptFormat( value:String ):void
   	{
   		_promptFormat = value;
   		// Check to see if the replacement code is found in the new format string
   		if ( _promptFormat.indexOf( "[prompt]" ) < 0 )
   		{
   			// TODO: Log error with the logging framework, or just use trace?
   			//trace( "PromptingTextInput warning: prompt format does not contain [prompt] replacement code." );
   		}

   		invalidateDisplayList();
   	}

   	// ==============================================================
   	//	text
   	// ==============================================================


   	/**
   	 * Override the behavior of text so that it doesn't take into account
   	 * the prompt.  If the prompt is displaying, the text is just an empty
   	 * string.
   	 */
   	[Bindable("textChanged")]
       [CollapseWhiteSpace]
       [NonCommittingChangeEvent("change")]
   	override public function set text( value:String ):void
   	{
   		// changed the test to also test for null values, not just 0 length
   		// if we were passed undefined or null then the zero length test would
   		// still return false. - Doug McCune
   		_textEmpty = (!value) || value.length == 0;
   		super.text = value;
   		invalidateDisplayList();
   	}

   	override public function get text():String
   	{
   		// If the text has changed
   		if ( _textEmpty )
   		{
   			// Skip the prompt text value
   			return "";
   		}
   		else
   		{
   			return super.text;
   		}
   	}



   	/**
   	 * We store a local copy of displayAsPassword. We need to keep this so that we can
   	 * change it to false if we're showing the prompt. Then we change it back (if it was
   	 * set to true) once we're no longer showing the prompt.
   	 */
   	private var _displayAsPassword:Boolean = false;

   	override public function set displayAsPassword(value:Boolean):void {
   		_displayAsPassword = value;
   		super.displayAsPassword = value;
   	}
   	override public function get displayAsPassword():Boolean {
   		return _displayAsPassword;
   	}

   	// ==============================================================
   	//	overriden methods
   	// ==============================================================

   	/**
   	 * @private
   	 *
   	 * Determines if the prompt needs to be displayed.
   	 */
   	override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void
   	{
   		// If the text is empty and a prompt value is set and the
   		// component does not currently have focus, then the component
   		// needs to display the prompt
   		if ( _textEmpty && _prompt != "" && !_currentlyFocused )
   		{
   			if ( _promptFormat == "" )
   			{
   				super.text = _prompt;
   			}
   			else
   			{
   				super.htmlText = _promptFormat.replace( /\[prompt\]/g, _prompt );
   			}

   			if ( super.displayAsPassword )
   			{
   				//If we're showing the prompt and we have displayAsPassword set then
   				//we need to set it to false while the prompt is showing.
   				var oldVal:Boolean = _displayAsPassword;
   				super.displayAsPassword = false;
   				_displayAsPassword = oldVal;
   			}
   		}
   		else
   		{
   			if ( super.displayAsPassword != _displayAsPassword )
   			{
   				super.displayAsPassword = _displayAsPassword;
   			}
   		}

   		super.updateDisplayList( unscaledWidth, unscaledHeight );
   	}

   	// ==============================================================
   	//	event handlers
   	// ==============================================================

   	/**
   	 * @private
   	 */
   	protected function handleChange( event:Event ):void
   	{
   		_textEmpty = super.text.length == 0;
   	}

   	/**
   	 * @private
   	 *
   	 * When the component recevies focus, check to see if the prompt
   	 * needs to be cleared or not.
   	 */
   	protected function handleFocusIn( event:FocusEvent ):void
   	{
   		_currentlyFocused = true;

   		// If the text is empty, clear the prompt
   		if ( _textEmpty )
   		{
   			super.htmlText = "";
   			// KLUDGE: Have to validate now to avoid a bug where the format
   			// gets "stuck" even though the text gets cleared.
   			validateNow();
   		}
   	}

   	/**
   	 * @private
   	 *
   	 * When the component loses focus, check to see if the prompt needs
   	 * to be displayed or not.
   	 */
   	protected function handleFocusOut( event:FocusEvent ):void
   	{
   		_currentlyFocused = false;

   		// If the text is empty, put the prompt back
   		invalidateDisplayList();
   	}
   } // end class
} // en package