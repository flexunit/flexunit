package org.sonatype.flexmojos.coverage;

import java.io.File;

//import org.codehaus.plexus.logging.AbstractLogEnabled;
//import org.codehaus.plexus.util.SelectorUtils;
//import org.sonatype.flexmojos.coverage.util.ApparatUtil;
//import org.sonatype.flexmojos.util.PathUtil;

import apparat.tools.coverage.Coverage.CoverageTool;
import apparat.tools.coverage.CoverageObserver;

import org.sonatype.flexmojos.util.OSUtils;

public abstract class AbstractCoverageReporter
    //extends AbstractLogEnabled
    implements CoverageReporter
{
    protected String[] excludes;

    public void instrument( File swf, File... sourcePaths )
    {
        /*
        getLogger().debug( "Instrumenting code to test coverage mode " + System.getProperty( "apparat.threads" ) );
        if ( getLogger().isDebugEnabled() )
        {
            getLogger().info( "Instrumenting: " + PathUtil.path( swf ) + "\n source paths: \n"
                                  + PathUtil.pathString( sourcePaths ) );
        }
        else
        {
            getLogger().info( "Instrumenting: " + PathUtil.path( swf ) );
        }
        */

        CoverageTool c = new CoverageTool();
        c.configure( new CoverageConfigurationImpl( swf, swf, sourcePaths ) );
        c.addObserver( getInstrumentationObserver() );

        /*
        if ( getLogger().isDebugEnabled() )
        {
            c.addObserver( new CoverageObserver()
            {
                public void instrument( String file, int line )
                {
                    getLogger().debug( "Instrumenting " + ApparatUtil.toClassname( file ) + ":" + line );
                }
            } );
        }
        */
        c.run();

    }

    @Override
    public void setExcludes(String[] value) {
        this.excludes = null;
        if ( value != null )
        {
            excludes = new String[value.length];
            for ( int i=0; i<excludes.length; i++)
            {
                        //JG
                        if (OSUtils.isWindows()) {
                            excludes[i] = value[i].replace(".", "\\");
                        } else {
                            excludes[i] = value[i].replace(".", "/");
                        }
                //excludes[i] = normalizePattern(value[i]);
                //getLogger().debug("exclusion added " + excludes[i]);
            }
        }
    }

    protected boolean isExcluded( String file )
    {
        //getLogger().debug("isExcluded " + file + "?");

        //JG
            String filePath = null;
            String fileName = null;
            if (file != null) {
                String[] fileParts = file.split(";");
                filePath = fileParts[1];
                fileName = fileParts[2];
            }
        //

        if ( excludes != null )
        {
            for ( String exclude : excludes)
            {
                    //JG
                    if (filePath != null && exclude != null) {
                        if (filePath.startsWith(exclude)) {
                            return true;
                        }
                    }
                ////replace ; with / because file with be in the form
                ////fullpath of folder;ClassName.as (or .mxml)
                //if ( SelectorUtils.matchPath(exclude, file.replace(';', File.separatorChar)) ) {
                //  return true;
                //}

            }
        }
        return false;
    }

    protected abstract CoverageObserver getInstrumentationObserver();

    /**
     * Taken from Ant DirectoryScanner.java
     * All '/' and '\' characters are replaced by
     * <code>File.separatorChar</code>, so the separator used need not
     * match <code>File.separatorChar</codoe>.
     *
     * <p> When a pattern ends with a '/' or '\', "**" is appended.
     */
    private String normalizePattern( String p )
    {
        String pattern = p.replace('/', File.separatorChar)
                .replace('\\', File.separatorChar);
        if ( pattern.endsWith( File.separator ) ) {
            pattern += "**";
        }

        return pattern;
    }
}
