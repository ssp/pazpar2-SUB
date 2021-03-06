<?xml version="1.0" encoding="UTF-8"?>
<!--
	Creates the pz:metadata field of type »catalogue-url« by building a
		URL string from the catalogueURLHint[Pre|Suf]fix metadata fields
		or parameters and the id field.
	
	2011-2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

	<xsl:param name="catalogueURLHintPrefix"/>
	<xsl:param name="catalogueURLHintSuffix"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	
	
	<xsl:template match="pz:metadata[@type='id'] | pz:metadata[@type='parent-id']">
		
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
		
		<xsl:variable name="fieldName">
			<xsl:value-of select="concat(substring-before(@type, 'id'), 'catalogue-url')"/>
		</xsl:variable>
				
		<xsl:variable name="prefix">
			<xsl:choose>
				<xsl:when test="../pz:metadata[@type='catalogueURLHintPrefix']">
					<xsl:value-of select="../pz:metadata[@type='catalogueURLHintPrefix'][1]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$catalogueURLHintPrefix"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="suffix">
			<xsl:choose>
				<xsl:when test="../pz:metadata[@type='catalogueURLHintSuffix']">
					<xsl:value-of select="../pz:metadata[@type='catalogueURLHintSuffix'][1]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$catalogueURLHintSuffix"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	
		<xsl:if test="string-length(concat($prefix, $suffix)) &gt; 0
						and not(../pz:metadata[@type=$fieldName])">
			
			<pz:metadata>
				<xsl:attribute name="type">
					<xsl:value-of select="$fieldName"/>
				</xsl:attribute>
				<xsl:value-of select="$prefix"/>
				<xsl:value-of select="."/>
				<xsl:value-of select="$suffix"/>
			</pz:metadata>
			
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
