<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">
<!--
	Improve metadata from vifanord’s zSQL database for BMEB.
		* media types
		* split subject
	
	Missing in the local database:
		* ID for linking to the server at http://www.otalib.fi/
		* URLs for items with full texts
	
	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
	
	<xsl:import href="../template/tag-splitter.xsl"/>

	<xsl:output indent="yes" method="xml" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<!--
		Map media types.
	-->
	<xsl:template match="*[@type='medium']">
		<pz:metadata type="medium">
			<xsl:choose>
				<xsl:when test=".='fulltext'">electronic</xsl:when>
				<xsl:when test=".='c'">book</xsl:when>
				<xsl:otherwise>article</xsl:otherwise>
			</xsl:choose>
		</pz:metadata>
	</xsl:template>
	

	<!--
		Split the fields which can contain multiple values
		at the separator »;«.
	-->
	<xsl:template match="*[@type='author'] | *[@type='subject']">
		<xsl:call-template name="tag-splitter">
			<xsl:with-param name="tag" select="."/>
			<xsl:with-param name="separator">;</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
