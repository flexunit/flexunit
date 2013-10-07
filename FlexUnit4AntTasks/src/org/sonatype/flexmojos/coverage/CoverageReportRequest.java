package org.sonatype.flexmojos.coverage;

import java.io.File;
import java.util.List;

import scala.actors.threadpool.Arrays;

public class CoverageReportRequest
{

    private File dataDirectory;

    private List<String> formats;

    private String encoding;

    private File reportDirectory;

    private List<File> sourcePath;

    @SuppressWarnings( "unchecked" )
    public CoverageReportRequest( File dataDirectory, List<String> formats, String encoding, File reportDirectory,
                                  File... sourcePath )
    {
        super();
        this.dataDirectory = dataDirectory;
        this.formats = formats;
        this.encoding = encoding;
        this.reportDirectory = reportDirectory;
        this.sourcePath = Arrays.asList( sourcePath );
    }

    public File getDataDirectory()
    {
        return dataDirectory;
    }

    public List<String> getFormats()
    {
        return formats;
    }

    public String getReportEncoding()
    {
        return encoding;
    }

    public File getReportDestinationDir()
    {
        return reportDirectory;
    }

    public List<File> getSourcePaths()
    {
        return sourcePath;
    }

}
