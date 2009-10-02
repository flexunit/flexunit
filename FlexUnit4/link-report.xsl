<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output indent="no" omit-xml-declaration="yes" method="xml" />
	<xsl:template match="/">
		<xsl:apply-templates select="report/scripts" />
	</xsl:template>
	<xsl:template match="report/scripts">
		<xsl:for-each select="script">
			<xsl:if test="dep[contains(@id, 'mx.') and not(contains(@id, 'mx.utils:'))]">
				<xsl:copy-of select="." />
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>