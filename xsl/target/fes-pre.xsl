<?xml version="1.0" encoding="UTF-8"?>
<!--
	Fix certain quirks of Friedrich-Ebert-Stiftung’s Unimarc.

	2015: Sven-S. Porst <ssp-web@earthlingsoft.net>
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
		Many of the records have »k« at position 6 of the leader despite
		not being images. Set those to »a«.
	-->
	<xsl:template match="tmarc:l">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="substring(., 7, 1)='k'">
					<xsl:value-of select="substring(., 1, 6)"/>
					<xsl:text>a</xsl:text>
					<xsl:value-of select="substring(., 8)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<!--
		Non-sorting text is bracketed by Unicode U+98 / U+9C pairs. Remove those.
	-->
	<xsl:template match="text()">
		<xsl:value-of select="translate(., '&#x98;&#x9C;', '')"/>
	</xsl:template>

</xsl:stylesheet>
