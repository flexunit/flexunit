package org.sonatype.flexmojos.coverage;

import java.io.File;

public interface CoverageReporter
{

    void instrument( File swf, File... sourcePaths );
    
    void generateReport( CoverageReportRequest request )
        throws CoverageReportException;

    void addResult( String classname, Integer[] touchs );
    
    void setExcludes( String[] excludes );

}
