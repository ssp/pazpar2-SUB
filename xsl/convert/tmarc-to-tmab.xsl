<?xml version="1.0" encoding="UTF-8"?>
<!--
	Processes a TurboMARC record containing MAB data and attempts to fix it.

	When moving MAB data as MARC records, indicators for fields
	in the 0XX range may be lost while non-existing subfields
	may be added.

	This transformation hopes to undo some of the damage done
	e.g. by Aleph’s Z39.50 interface.

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tmarc="http://www.indexdata.com/turbomarc"
	xmlns:marc="http://www.loc.gov/MARC21/slim">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>


	<xsl:template match="tmarc:r">
		<xsl:copy>
			<xsl:apply-templates select="*"/>
		</xsl:copy>
	</xsl:template>


	<!--
		Strip »$$a« which may appear before the actual identifier.
	-->
	<xsl:template match="tmarc:c001">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="substring(., 1, 3) = '$$a'">
					<xsl:value-of select="substring(., 4)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>


	<!--
		The initial subfield code in 050 and 051 should be the first
		letter of the field content.
	-->
	<xsl:template match="tmarc:d050|tmarc:d051">
		<xsl:copy>
			<xsl:for-each select="tmarc:*">
				<xsl:value-of select="substring(local-name(.), 2, 1)"/>
				<xsl:value-of select="."/>
			</xsl:for-each>
			<!-- Also cover subfield tags (which may remain for | subfields) -->
			<xsl:for-each select="marc:subfield|subfield">
				<xsl:value-of select="@code"/>
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>


	<!-- 
		Copy the rest.
	-->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
