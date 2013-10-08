package org.sonatype.flexmojos.coverage;

import apparat.tools.coverage.CoverageConfiguration;
import org.sonatype.flexmojos.util.PathUtil;
import scala.collection.immutable.List;
import scala.collection.mutable.ListBuffer;

import java.io.File;

/**
 * @author Joa Ebert
 */
final class CoverageConfigurationImpl implements CoverageConfiguration
{
	private final ListBuffer<String> _sourcePath = new ListBuffer<String>();
	private final File _input;
	private final File _output;

	public CoverageConfigurationImpl(final File input, final File output, final File... sourcePath)
	{
		_input = input;
		_output = output;

		for(final File sourcePathElement : sourcePath)
		{
			//
			// Java equivalent of the following Scala code:
			// _sourcePath += PathUtil getCanonicalPath sourcePathElement
			//

			_sourcePath.$plus$eq(PathUtil.path( sourcePathElement));
		}
	}

	public File input()
	{
		return _input;
	}

	public File output()
	{
		return _output;
	}

	public List<String> sourcePath()
	{
		//
		// Convert the mutable ListBuffer[String] to an immutable List[String] for Apparat.
		//
		
		return _sourcePath.toList();
	}
}
