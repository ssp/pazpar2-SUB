<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">
<!--
	Improve metadata from vifanord’s link database.
		* map all subject information to the subject field
	
	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->

	<xsl:output indent="yes" method="xml" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>



	<!--
		Merge all »subject-*« fields to »subject«.
		Keep the remainder of the tag name in the »lang« attribute.
	-->
	<xsl:template match="*[substring(@type, 1, 8) = 'subject-']">
		<xsl:copy>
			<xsl:attribute name="type">subject</xsl:attribute>
			<xsl:attribute name="lang">
				<xsl:value-of select="substring(@type, 9)"/>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:copy>		
	</xsl:template>	


</xsl:stylesheet>
