package org.flexunit.runner {
	import mx.collections.ArrayCollection;
	
	public interface IDescription {
		function get children():ArrayCollection;
		/**
		 * @return a user-understandable label
		 */
		function get displayName():String;
		/**
		 * @return <code>true</code> if the receiver is a suite
		 */
		function get isSuite():Boolean;
		/**
		 * @return <code>true</code> if the receiver is an atomic test
		 */
		function get isTest():Boolean;
		/**
		 * @return the total number of atomic tests in the receiver
		 */
		function get testCount():int;

		/**
		 * @return the metadata as XML that is attached to this description node, 
		 * or null if none exists
		 */
		function getMetadata( type:String ):XML;
		function getAllMetadata():XMLList;
		function get isInstance():Boolean;
		/**
		 * @return true if this is a description of a Runner that runs no tests
		 */
		function get isEmpty():Boolean;

		/**
		 * Add <code>Description</code> as a child of the receiver.
		 * @param description the soon-to-be child.
		 */
		function addChild( description:IDescription ):void;		
		/**
		 * @return a copy of this description, with no children (on the assumption that some of the
		 * children will be added back)
		 */
		function childlessCopy():IDescription;
		function equals( obj:Object ):Boolean;
	}
}