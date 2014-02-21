<?xml version="1.0" encoding="UTF-8"?>
<!--
	Extract a workable ID for records of the
	Bibliography of Old Norse-Icelandic Studies.

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
		Reduce the identifier.

		MARC 001 contains a string like »x271266200|c20020712|d20090804101500«.
		We need the part before the first »|« to link to records.
	-->
	<xsl:template match="tmarc:c001">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="contains(., '|')">
					<xsl:value-of select="substring-before(., '|')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
