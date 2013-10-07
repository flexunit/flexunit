package org.sonatype.flexmojos.coverage.cobertura;

import net.sourceforge.cobertura.coveragedata.ClassData;
import net.sourceforge.cobertura.coveragedata.PackageData;
import net.sourceforge.cobertura.coveragedata.ProjectData;
import net.sourceforge.cobertura.coveragedata.SourceFileData;
import net.sourceforge.cobertura.reporting.ComplexityCalculator;
import net.sourceforge.cobertura.util.FileFinder;

public class ZeroComplexityCalculator extends ComplexityCalculator {
	public ZeroComplexityCalculator( FileFinder finder ) {
		super( finder );
	}
	
	@Override
	public double getCCNForClass(ClassData classData) {
		return 0;
	}
	
	@Override
	public double getCCNForPackage(PackageData packageData) {
		return 0;
	}
	
	@Override
	public double getCCNForProject(ProjectData projectData) {
		return 0;
	}
	
	@Override
	public double getCCNForSourceFile(SourceFileData sourceFile) {
		return 0;
	}
}
