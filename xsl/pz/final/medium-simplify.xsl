<?xml version="1.0" encoding="UTF-8"?>
<!--
	Simplify the media types for extracted by tmarc.xsl.
	
		* map all »video*« types to »audiovisual«
		* map all »recording*« types to »recording«
		* remove a trailing »(electronic)«
	
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


	<xsl:template match="pz:metadata[@type='medium']">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:choose>
				<xsl:when test="substring(text(), 1, 5) = 'video'">audio-visual</xsl:when>
				<xsl:when test="substring(text(), 1, 9) = 'recording'">recording</xsl:when>
				<xsl:when test="contains(., ' (electronic)')">
					<xsl:value-of select="substring-before(., ' (electronic)')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>


</xsl:stylesheet>
