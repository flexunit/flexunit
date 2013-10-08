/**
 *  Copyright 2008 Marvin Herman Froeder
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 *
 */
package org.sonatype.flexmojos.test.report;

import org.codehaus.plexus.util.xml.Xpp3Dom;

@SuppressWarnings( "unused" )
public class TestMethodReport
{

    private ErrorReport error;

    private ErrorReport failure;

    private String name;

    private double time;

    private Xpp3Dom dom;

    public TestMethodReport( Xpp3Dom dom )
    {
        this.dom = dom;
    }

    public ErrorReport getError()
    {
        Xpp3Dom child = this.dom.getChild( "error" );
        if ( child != null )
        {
            return new ErrorReport( child );
        }
        return null;
    }

    public ErrorReport getFailure()
    {
        Xpp3Dom child = this.dom.getChild( "failure" );
        if ( child != null )
        {
            return new ErrorReport( child );
        }
        return null;
    }

    public String getName()
    {
        return dom.getAttribute( "name" );
    }

    public double getTime()
    {
        return Double.parseDouble( dom.getAttribute( "time" ) );
    }

    public void setError( ErrorReport error )
    {
        throw new UnsupportedOperationException();
    }

    public void setFailure( ErrorReport failure )
    {
        throw new UnsupportedOperationException();
    }

    public void setName( String name )
    {
        throw new UnsupportedOperationException();
    }

    public void setTime( double time )
    {
        throw new UnsupportedOperationException();
    }

}
