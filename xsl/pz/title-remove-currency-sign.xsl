<?xml version="1.0" encoding="UTF-8"?>
<!--
	Removes the currency sign ¤ from the title field.

	(Used and output as a nonsorting character by the Danish
	national library’s system.)

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="pz:metadata[@type='title']">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:value-of select="translate(., '¤', '')"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
