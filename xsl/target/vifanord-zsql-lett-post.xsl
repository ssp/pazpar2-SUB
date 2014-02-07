<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">
<!--
	Improve metadata from vifanord’s zSQL databases.
	
		* Split language field into several fields à 3 characters
	
	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->

	<xsl:output indent="yes" method="xml" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<!--
		Split the »language« field into separate fields of three characters each.
		
		e.g.: enggerrus -> eng / ger / rus (1 tag / 3 tags)
	-->
	<xsl:template match="*[@type='language']">
		<xsl:call-template name="tagsForLanguageCodes">
			<xsl:with-param name="codes" select="normalize-space(.)"/>
		</xsl:call-template>
	</xsl:template>	


	<xsl:template name="tagsForLanguageCodes">
		<xsl:param name="codes"/>
		
		<xsl:if test="string-length($codes) &gt;= 3">
			<pz:metadata type="language">
				<xsl:value-of select="substring($codes, 1, 3)"/>
			</pz:metadata>
			<xsl:call-template name="tagsForLanguageCodes">
				<xsl:with-param name="codes" select="normalize-space(substring($codes, 4))"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>
