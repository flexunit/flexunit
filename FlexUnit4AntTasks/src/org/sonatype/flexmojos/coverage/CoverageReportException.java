package org.sonatype.flexmojos.coverage;

public class CoverageReportException
    extends Exception
{

    private static final long serialVersionUID = 5536698162379992541L;

    public CoverageReportException( String message, Throwable cause )
    {
        super( message, cause );
    }

    public CoverageReportException( String message )
    {
        this(message, null);
    }

}
