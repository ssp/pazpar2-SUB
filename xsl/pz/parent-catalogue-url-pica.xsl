<?xml version="1.0" encoding="UTF-8"?>
<!--
	Creates a link to all related works in a Pica OPAC using the record’s
	»parent-id« field.

	Example:
	parent-id: 16276040X
	becomes: https://opac.sub.uni-goettingen.de/DB=1/FAM?PPN=16276040X

	2012-2014 Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

	<xsl:param name="catalogueURLHintPrefix"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="pz:metadata[@type='parent-id']">
		<xsl:choose>
			<xsl:when test="string-length($catalogueURLHintPrefix)">
				<pz:metadata type="parent-catalogue-url">
					<xsl:value-of select="substring-before($catalogueURLHintPrefix, 'PPNSET?PPN=')"/>
					<xsl:text>FAM?PPN=</xsl:text>
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
