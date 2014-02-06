<?xml version="1.0" encoding="UTF-8"?>
<!--
	Convert	language information in ELibM data from ISO 639-1 to ISO 639-2/B


	2010-2012 Sven-S. Porst, SUB Göttingen <porst@sub.uni-goettingen.de>
-->

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../pz/language/iso-639-1-converter.xsl"/>

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="la">
		<la>
			<xsl:call-template name="iso-639-1-converter">
				<xsl:with-param name="languageCode" select="."/>
			</xsl:call-template>
		</la>
	</xsl:template>

</xsl:stylesheet>
