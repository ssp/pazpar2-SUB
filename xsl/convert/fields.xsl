<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">
<!--
	Transforms simple XML records to pazpar2 metadata.
	
	Tag names of the root element’s children are the pazpar2
	metadata field names the data is mapped to.

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
	
	<xsl:output indent="yes" method="xml" encoding="UTF-8"/>


	<xsl:template match="/*">
		<pz:record>
			<xsl:apply-templates select="*"/>
		</pz:record>
	</xsl:template>
	
	
	<xsl:template match="*">
		<pz:metadata>
			<xsl:attribute name="type">
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:value-of select="text()"/>
		</pz:metadata>
	</xsl:template>


</xsl:stylesheet>
