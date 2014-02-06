<?xml version="1.0" encoding="UTF-8"?>
<!--
	Creates the pz:metadata field of type »catalogue-url« by concatenating
		the $catalogueURLHintPrefix and $catalogueURLHintPostfix parameters
		with the »id« pz:metadata field.

	2011-2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

	<xsl:param name="catalogueURLHintPrefix"/>
	<xsl:param name="catalogueURLHintPostfix"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="pz:metadata[@type='id'] | pz:metadata[@type='parent-id']">

		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>

		<xsl:if test="string-length(concat($catalogueURLHintPrefix, $catalogueURLHintPostfix)) &gt; 0">
			<pz:metadata>
				<xsl:attribute name="type">
					<xsl:value-of select="concat(substring-before(@type, 'id'), 'catalogue-url')"/>
				</xsl:attribute>
				<xsl:value-of select="$catalogueURLHintPrefix"/>
				<xsl:value-of select="."/>
				<xsl:value-of select="$catalogueURLHintPostfix"/>
			</pz:metadata>
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
