package org.flexunit.utils
{
	import org.flexunit.Assert;
	import org.flexunit.runner.FlexUnitCore;

	public class ClassNameUtilCase
	{
		[Test]
		public function testGetLoggerFriendlyClassName():void {
			var obj:FlexUnitCore = new FlexUnitCore();
			var name:String = ClassNameUtil.getLoggerFriendlyClassName( obj );
			
			if ( name == null || name == "" )
			{
				Assert.fail( "Empty name returned." );
			}
			else if ( name.indexOf( '.' ) != -1 || name.indexOf( ":" ) != -1 )
			{
				Assert.fail( "Name contains periods or colons." );
			}
			else
			{
				// pass
			}
		}
	}
}