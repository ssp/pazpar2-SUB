<?xml version="1.0" encoding="UTF-8"?>
<!--
	Move the ID for records of the Estonian National Library to 001.
	Currently it is provided in 907 $a without the first and last character.

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tmarc="http://www.indexdata.com/turbomarc"
	version="1.0">

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<!--
		Add the identifier in 907 $a to 001 if 001 does not exist.
		Drop 907.
	-->
	<xsl:template match="tmarc:d907">
		<xsl:if test="not(../tmarc:c001) and tmarc:sa">
			<tmarc:c001>
				<xsl:value-of select="substring(tmarc:sa, 2, string-length(tmarc:sa) - 2)"/>
			</tmarc:c001>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>
