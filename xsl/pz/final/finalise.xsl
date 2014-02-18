<?xml version="1.0" encoding="UTF-8"?>
<!--
	Apply a number of XSL transformations to all records.
	
	Collected in a single XSL to simplify changes for all settings.

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">

	<xsl:include href="catalogue-url-create.xsl"/>
	<xsl:include href="zdb-number.xsl"/>
	<xsl:include href="medium-simplify.xsl"/>
	<xsl:include href="merge-fields.xsl"/>

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
