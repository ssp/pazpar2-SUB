<?xml version="1.0" encoding="UTF-8"?>
<!--
	Slight cleanup for SWB MARC Data.

	2012-2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tmarc="http://www.indexdata.com/turbomarc"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>
	<xsl:strip-space elements="*" />

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>



	<!--
		In WAO records the classification is noted in 084 marked with $2 FIV.
		Create a region value for that.
	-->
	<xsl:template match="tmarc:d084[tmarc:s2 = 'FIV']">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>

		<pz:metadata type="region">
			<xsl:choose>
				<xsl:when test="substring(tmarc:sa, 1, 7) = 'RA02.12'">ostsee</xsl:when>
				<xsl:when test="substring(tmarc:sa, 1, 4) = 'RA03'">nord</xsl:when>
				<xsl:when test="substring(tmarc:sa, 1, 6) = 'RA07.1'">balt</xsl:when>
			</xsl:choose>
		</pz:metadata>
	</xsl:template>



	<!--
		SWB use field 689 for local keywords (Pica field 044K).
		https://wiki.bsz-bw.de/doku.php?id=v-team:daten:datendienste:marc21
		Map those to 690.
	-->
	<xsl:template match="tmarc:d689">
		<tmarc:d690>
			<xsl:apply-templates select="@*|node()"/>
		</tmarc:d690>
	</xsl:template>


</xsl:stylesheet>
