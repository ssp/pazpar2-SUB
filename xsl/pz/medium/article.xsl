<?xml version="1.0" encoding="UTF-8"?>
<!--
	Remove all pz:metadata elements and insert one of type »article«.

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="pz:record">
		<xsl:copy>
			<pz:metadata type="medium">article</pz:metadata>
			<xsl:apply-templates select="@*|pz:metadata[@type!='medium']"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
