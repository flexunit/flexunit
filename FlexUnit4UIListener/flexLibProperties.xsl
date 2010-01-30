<?xml version="1.0" ?>
<xsl:stylesheet	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output indent="no" method="text" />
	<xsl:template match="//includeClasses">
		<xsl:text>src.class-list=</xsl:text>
		<xsl:for-each select="classEntry">
			<xsl:value-of select="@path"/>
			<xsl:text>&#32;</xsl:text>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="//includeResources">
		<xsl:text>src.resource-list-for-compc=</xsl:text>
		<xsl:for-each select="resourceEntry">
			<xsl:text>-include-file&#32;</xsl:text>
			<xsl:value-of select="@destPath"/>
			<xsl:text>&#32;${src.loc}/</xsl:text>
			<xsl:value-of select="@sourcePath"/>
			<xsl:text>&#32;</xsl:text>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>