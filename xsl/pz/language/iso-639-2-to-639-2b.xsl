<?xml version="1.0" encoding="UTF-8"?>
<!--
	Applies the template »iso-639-2-cleaner« from »iso-639-2-cleaner.xsl«
	to pz:metadata fields of type language.
	Copies all other fields unchanged.

	2011-2014 Sven-S. Porst <ssp-web@earthlingsoft.net>
-->

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:pz="http://www.indexdata.com/pazpar2/1.0">

	<xsl:import href="iso-639-2-cleaner.xsl"/>

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="pz:metadata[@type='language']">
		<pz:metadata type="language">
			<xsl:call-template name="iso-639-2-cleaner">
				<xsl:with-param name="languageCode" select="."/>
			</xsl:call-template>
		</pz:metadata>
	</xsl:template>

</xsl:stylesheet>

