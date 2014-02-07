<?xml version="1.0" encoding="UTF-8"?>
<!--
	Template taking a given tag containing text and a separator string.
	It splits the string at the separator and wraps each part in the
	original tag.

	Parameters:	* tag - element(s) containing the string(s) to be split
				* separator - string to split the tag content at

	2014: Sven-S. Porst, <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<xsl:template name="tag-splitter">
		<xsl:param name="tag"/>
		<xsl:param name="separator"/>

		<xsl:variable name="text">
			<xsl:value-of select="$tag"/>
		</xsl:variable>
		
		<xsl:call-template name="split-and-wrap">
			<xsl:with-param name="string" select="$text"/>
			<xsl:with-param name="separator" select="$separator"/>
			<xsl:with-param name="tag" select="$tag"/>
		</xsl:call-template>
	</xsl:template>



	<xsl:template name="split-and-wrap">
		<xsl:param name="string"/>
		<xsl:param name="separator"/>
		<xsl:param name="tag"/>
		
		<xsl:variable name="firstItem">
			<xsl:choose>
				<xsl:when test="contains($string, $separator)">
					<xsl:value-of select="normalize-space(substring-before($string, $separator))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space($string)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="remainingItems" select="substring-after($string, $separator)"/>

		<xsl:if test="$firstItem">
			<xsl:element name="{name($tag)}" namespace="{namespace-uri($tag)}">
				<xsl:copy-of select="$tag/@*"/>
				<xsl:value-of select="$firstItem"/>
			</xsl:element>
		</xsl:if>
		
		<xsl:if test="$remainingItems">
			<xsl:call-template name="split-and-wrap">
				<xsl:with-param name="string" select="$remainingItems"/>
				<xsl:with-param name="separator" select="$separator"/>
				<xsl:with-param name="tag" select="$tag"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
