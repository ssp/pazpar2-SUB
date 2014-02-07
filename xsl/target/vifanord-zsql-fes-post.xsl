<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">
<!--
	Improve metadata from vifanord’s zSQL database for
	the catalogue of Friedrich Ebert Stiftung.
		* extract date from 008
		* split fields
		* clean up shelf-mark
		* mark electronic-urls as full text
		* medium
	
	Missing in the local database:
		* record id to link back to the catalogue (which is linkable)
	
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
		Extract date information from 008.
	-->
	<xsl:template match="*[@type='c008']">
		<xsl:variable name="date">
			<xsl:value-of select="normalize-space(substring(., 4, 4))"/>
		</xsl:variable>
		
		<xsl:if test="string-length($date) = 4
						and translate($date, '1234567890', '**********') = '****'">
			<pz:metadata type="date">
				<xsl:value-of select="$date"/>
			</pz:metadata>
		</xsl:if>
	</xsl:template>


	<!--
		Split the fields which can contain multiple values
		at the separator »;«.
	-->
	<xsl:template match="*[@type='author'] | *[@type='corporate-name'] | *[@type='subject']">
		<xsl:call-template name="tag-splitter">
			<xsl:with-param name="tag" select="."/>
			<xsl:with-param name="separator">;</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<!--
		Remove leading »Book number :« from shelf-mark.
	-->
	<xsl:template match="*[@type='shelf-mark']">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="substring(., 1, 13) = 'Book number :'">
					<xsl:value-of select="normalize-space(substring(., 14))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>


	<!--
		electronic-urls always point to full text.
	-->
	<xsl:template match="*[@type='electronic-url']">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="fulltextfile"/>
			<xsl:value-of select="."/>
		</xsl:copy>
	</xsl:template>


	<!--
		medium field: defaults to »book«,
		use »electronic« if there is a URL.
	-->
	<xsl:template match="pz:record">
		<xsl:copy>
			<pz:metadata type="medium">
				<xsl:choose>
					<xsl:when test="string-length(normalize-space(pz:metadata[@type='electronic-url'])) &gt; 0">electronic</xsl:when>
					<xsl:otherwise>book</xsl:otherwise>
				</xsl:choose>
			</pz:metadata>
			
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
