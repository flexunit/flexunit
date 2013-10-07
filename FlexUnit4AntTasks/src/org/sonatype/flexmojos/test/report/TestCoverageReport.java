package org.sonatype.flexmojos.test.report;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.plexus.util.xml.Xpp3Dom;

@SuppressWarnings( "unused" )
public class TestCoverageReport
{

    private String classname;

    private Integer[] touchs;

    private Xpp3Dom dom;

    public TestCoverageReport( Xpp3Dom dom )
    {
        this.dom = dom;
    }

    public String getClassname()
    {
        return dom.getAttribute( "classname" );
    }

    public void setClassname( String classname )
    {
        throw new UnsupportedOperationException();
    }

    public Integer[] getTouchs()
    {
        if ( touchs == null )
        {
            List<Integer> t = new ArrayList<Integer>();
            Xpp3Dom[] children = dom.getChildren("touch");
            for ( Xpp3Dom c : children )
            {
                t.add( Integer.valueOf( c.getValue() ) );
            }

            touchs = t.toArray( new Integer[0] );
        }
        return touchs;
    }

    public void setTouchs( Integer[] touchs )
    {
        throw new UnsupportedOperationException();
    }
}
