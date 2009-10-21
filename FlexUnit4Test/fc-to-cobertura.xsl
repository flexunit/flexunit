<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0">
	<xsl:output indent="yes" omit-xml-declaration="no" method="xml" />
	<xsl:param name="timestamp" />
	<xsl:param name="version" />
	<xsl:param name="sourcePath" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="applicationCoverage" />
	</xsl:template>

	<xsl:template match="applicationCoverage">
		<coverage>
			<xsl:attribute name="line-rate">
				<xsl:value-of select="@lineCoverage" />
			</xsl:attribute>
			<xsl:attribute name="branch-rate">
				<xsl:value-of select="@branchCoverage" />
			</xsl:attribute>
			<xsl:attribute name="lines-covered">
				<xsl:value-of select="@coveredLines" />
			</xsl:attribute>
			<xsl:attribute name="line-valid">
				<xsl:value-of select="@lines" />
			</xsl:attribute>
			<xsl:attribute name="branches-covered">
				<xsl:value-of select="@coveredBranches" />
			</xsl:attribute>
			<xsl:attribute name="branches-valid">
				<xsl:value-of select="@branches" />
			</xsl:attribute>
			<xsl:attribute name="complexity" />
			<xsl:attribute name="version">
				<xsl:value-of select="$version" />
			</xsl:attribute>
			<xsl:attribute name="timestamp">
				<xsl:value-of select="$timestamp" />
			</xsl:attribute>
			<sources>
				<xsl:for-each select="tokenize(string($sourcePath), ',')">
					<source>
						<xsl:value-of select="." />
					</source> 
				</xsl:for-each>
			</sources>
			<packages>
				<xsl:apply-templates select="package" />
			</packages>
		</coverage>
	</xsl:template>

	<xsl:template match="package">
		<package>
			<xsl:attribute name="name">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<xsl:attribute name="line-rate">
				<xsl:value-of select="@lineCoverage" />
			</xsl:attribute>
			<xsl:attribute name="branch-rate">
				<xsl:value-of select="@branchCoverage" />
			</xsl:attribute>
			<xsl:attribute name="complexity" />
			<classes>
				<xsl:apply-templates select="class" />
			</classes>
		</package>
	</xsl:template>

	<xsl:template match="class">
		<class>
			<xsl:attribute name="name">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<xsl:attribute name="filename">
				<xsl:variable name="path" select="@pathname" />
				<xsl:for-each select="tokenize(string($sourcePath), ',')">
					<xsl:variable name="safeSourcePath" select="lower-case(replace(., '\\', '/'))" />
					<xsl:variable name="safePathname" select="lower-case(replace($path, '\\', '/'))" />
					<xsl:if test="compare($safeSourcePath, substring($safePathname, 1, string-length($safeSourcePath))) = 0">
						<xsl:value-of select="substring($path, string-length($safeSourcePath) + 2, string-length($path))" />
					</xsl:if>
				</xsl:for-each>
			</xsl:attribute>
			<xsl:attribute name="line-rate">
				<xsl:value-of select="@lineCoverage" />
			</xsl:attribute>
			<xsl:attribute name="branch-rate">
				<xsl:value-of select="@branchCoverage" />
			</xsl:attribute>
			<xsl:attribute name="complexity" />
			<methods>
				<xsl:apply-templates select="function" />
			</methods>
			<lines>
				<xsl:apply-templates select="function/line" />
			</lines>
		</class>
	</xsl:template>

	<xsl:template match="function">
		<method>
			<xsl:attribute name="name">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<xsl:attribute name="signature">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<xsl:attribute name="line-rate">
				<xsl:value-of select="@lineCoverage" />
			</xsl:attribute>
			<xsl:attribute name="branch-rate">
				<xsl:value-of select="@branchCoverage" />
			</xsl:attribute>
			<lines>
				<xsl:apply-templates select="line" />
			</lines>
		</method>
	</xsl:template>
	
	<xsl:template match="line">
		<xsl:variable name="lineNumber" select="@name" />
		<line>
			<xsl:attribute name="number">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<xsl:attribute name="hits">
				<xsl:value-of select="@count" />
			</xsl:attribute>
			
			<xsl:choose>
				<xsl:when test="count(ancestor::function/branch[contains(substring-before(@name, '.'), $lineNumber)]) > 0">
					<xsl:attribute name="branch">
						<xsl:text>true</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="condition-coverage">
						<xsl:variable name="coveredBranches" select="count(ancestor::function/branch[contains(substring-before(@name, '.'), $lineNumber) and (@count > 0)])" />
						<xsl:variable name="totalBranches" select="count(ancestor::function/branch[contains(substring-before(@name, '.'), $lineNumber)])" />
						<xsl:value-of select="($coveredBranches div $totalBranches) * 100" />
						<xsl:text>% (</xsl:text>
						<xsl:value-of select="$coveredBranches" />
						<xsl:text>/</xsl:text>
						<xsl:value-of select="$totalBranches" />
						<xsl:text>)</xsl:text>
					</xsl:attribute>
		
					<conditions>
						<xsl:for-each-group select="ancestor::function/branch"	group-by="substring-after(@name, concat($lineNumber, '.'))">
							<xsl:if test="not(string-length(current-grouping-key()) = 0)">
								<condition>
									<xsl:attribute name="number">
										<xsl:value-of select="current-grouping-key()" />
									</xsl:attribute>
									<xsl:attribute name="type">
										<xsl:text>jump</xsl:text>
									</xsl:attribute>
									<xsl:attribute name="coverage">
										<!-- Count the number of covered branches, the total number of branches, divide and then multiply by 100 -->
										<xsl:value-of select="(count(current-group()[@count > 0]) div count(current-group())) * 100" />
										<xsl:text>%</xsl:text>
									</xsl:attribute>
								</condition>
							</xsl:if>
						</xsl:for-each-group>
					</conditions>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="branch">
						<xsl:text>false</xsl:text>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</line>
	</xsl:template>
</xsl:stylesheet>