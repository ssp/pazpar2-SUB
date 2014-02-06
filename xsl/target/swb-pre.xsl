<?xml version="1.0" encoding="UTF-8"?>
<!--
	Slight cleanup for SWB Marc Data.

	2012 Sven-S. Porst, SUB Göttingen <porst@sub.uni-goettingen.de>
-->

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tmarc="http://www.indexdata.com/turbomarc">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>
	<xsl:strip-space elements="*" />

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
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
