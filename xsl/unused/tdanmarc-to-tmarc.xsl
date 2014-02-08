<?xml version="1.0" encoding="UTF-8"?>
<!--
	Processes a TurboMARC record containing DanMARC data and
	tries to create the usual MARC control field data from 
	the data fields in DanMARC.

	Can help for data from the Danish national library whose MARC
	records lack fields 001 and 008.

	This transformation takes place in ignorance of many other
	subtleties DanMARC may have.

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tmarc="http://www.indexdata.com/turbomarc"
	xmlns:marc="http://www.loc.gov/MARC21/slim">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>



	<!--
		Map the identifier to c001.
	-->
	<xsl:template match="tmarc:d001">
		<tmarc:c001>
			<xsl:value-of select="tmarc:sa"/>
		</tmarc:c001>
	</xsl:template>


	<!--
		Transform the 008 data to non-subfielded MARC form.
	-->
	<xsl:template match="tmarc:d008">
		<tmarc:c008>
			<!-- 00-05 - Date entered on file -->
			<xsl:text>||||||</xsl:text>
			<!-- 06 - Type of date/Publication status: multiple dates -->
			<xsl:text>m</xsl:text>
			<!-- 07-10 - Date 1 -->
			<xsl:choose>
				<xsl:when test="string-length(tmarc:sa) = 4">
					<xsl:value-of select="tmarc:sa"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>||||</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<!-- 11-14 - Date 2 -->
			<xsl:choose>
				<xsl:when test="string-length(tmarc:sz) = 4">
					<xsl:value-of select="tmarc:sz"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>||||</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<!-- 15-17 - Place of publication, production, or execution -->
			<xsl:choose>
				<xsl:when test="string-length(tmarc:sa) = 4">
					<xsl:value-of select="tmarc:sa"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>||||</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<!-- 15-17 - Place of publication, production, or execution -->
			<xsl:choose>
				<xsl:when test="string-length(tmarc:sb) = 3">
					<xsl:value-of select="tmarc:sb"/>
				</xsl:when>
				<xsl:when test="string-length(tmarc:sb) = 2">
					<xsl:value-of select="tmarc:sb"/>
					<xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>|||</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<!-- Use 008 data model for books in all cases -->
			<!-- 18-21 - Illustrations (006/01-04) -->
			<xsl:text>||||</xsl:text>
			<!-- 22 - Target audience (006/05) -->
			<xsl:text>|</xsl:text>
			<!-- 23 - Form of item (006/06) -->
			<xsl:text>|</xsl:text>
			<!-- 24-27 - Nature of contents (006/07-10) -->
			<xsl:text>||||</xsl:text>
			<!-- 28 - Government publication (006/11) -->
			<xsl:text>|</xsl:text>
			<!-- 29 - Conference publication (006/12) -->
			<xsl:text>|</xsl:text>
			<!-- 30 - Festschrift (006/13) -->
			<xsl:text>|</xsl:text>
			<!-- 31 - Index (006/14) -->
			<xsl:text>|</xsl:text>
			<!-- 32 - Undefined (006/15) -->
			<xsl:text>|</xsl:text>
			<!-- 33 - Literary form (006/16) -->
			<xsl:text>|</xsl:text>
			<!-- 33 - Literary form (006/16) -->
			<xsl:text>|</xsl:text>
			<!-- 35-37 - Language -->
			<xsl:choose>
				<xsl:when test="string-length(tmarc:sb[1]) = 3">
					<xsl:value-of select="tmarc:sb[1]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>|||</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<!-- 38 - Modified record -->
			<xsl:text>|</xsl:text>
			<!-- 39 - Cataloging source -->
			<xsl:text>|</xsl:text>
		</tmarc:c008>
	</xsl:template>


	<!--
		Join last name and first name of persons into the $a.
	-->
	<xsl:template match="tmarc:d100|tmarc:d700">
		<xsl:copy>
			<xsl:copy-of select="@*|tmarc:s4|tmarc:sc|tmarc:sd"/>
			<tmarc:sa>
				<xsl:value-of select="tmarc:sa"/>
				<xsl:if test="tmarc:sh">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="tmarc:sh"/>
				</xsl:if>
			</tmarc:sa>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
