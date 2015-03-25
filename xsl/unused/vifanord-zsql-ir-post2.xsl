<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">
<!--
	Improve metadata from vifanord’s link database.
		* split fields with multiple values
		* add region field
		* add label to electronic-url based on medium
	
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
		Split the fields which can contain multiple values
		at the separator »;«.
	-->
	<xsl:template match="*[@type='language']
							| *[@type='country']
							| *[substring(@type, 1, 18)='classification-ddc']
							| *[@type='subject']">
		<xsl:call-template name="tag-splitter">
			<xsl:with-param name="tag" select="."/>
			<xsl:with-param name="separator">;</xsl:with-param>
		</xsl:call-template>
	</xsl:template>



	<!--
		Map region information.
	-->
	<xsl:template match="*[@type='region']">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<pz:metadata type="region">
				<xsl:choose>
					<xsl:when test=".='Baltikum'">balt</xsl:when>
					<xsl:when test=".='Skandinavien' or .='Finnland'">nord</xsl:when>
					<xsl:when test=".='Ostseeraum'">ostsee</xsl:when>
				</xsl:choose>
			</pz:metadata>
		</xsl:copy>
	</xsl:template>



	<!--
		Add a label to the URL of website and electronic media types.
	-->
	<xsl:template match="*[@type='electronic-url']">
		<xsl:copy>
			<xsl:variable name="label">
				<xsl:choose>
					<xsl:when test="../pz:metadata[@type='medium'][1] = 'website'">Website</xsl:when>
					<xsl:when test="../pz:metadata[@type='medium'][1] = 'electronic'">Volltext</xsl:when>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:if test="string-length($label) &gt; 0">
				<xsl:attribute name="name">
					<xsl:value-of select="$label"/>
				</xsl:attribute>
			</xsl:if>
			
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
