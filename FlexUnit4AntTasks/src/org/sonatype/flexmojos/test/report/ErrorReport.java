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
public class ErrorReport
{
    private String message;

    private String stackTrace;

    private String type;

    private Xpp3Dom dom;

    public ErrorReport( Xpp3Dom dom )
    {
        this.dom = dom;
    }

    public String getMessage()
    {
        return dom.getAttribute( "message" );
    }

    public String getStackTrace()
    {
        return dom.getAttribute( "stackTrace" );
    }

    public String getType()
    {
        return dom.getAttribute( "type" );
    }

    public void setMessage( String message )
    {
        throw new UnsupportedOperationException();
    }

    public void setStackTrace( String stackTrace )
    {
        throw new UnsupportedOperationException();
    }

    public void setType( String type )
    {
        throw new UnsupportedOperationException();
    }

}
