<?xml version="1.0" encoding="UTF-8"?>
<!--
	Extract region information from GBV data for vifanord.

	2010-2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	xmlns:tmarc="http://www.indexdata.com/turbomarc">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

	<xsl:param name="catalogueURLHintPrefix"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>



	<!--
		Extract region information from SSG-Selektionskennzeichen.
		
		Use it to
		* create the region field
		* choose an appropriate OLC subdatabase when working with OLC
	-->
	<xsl:template match="tmarc:d084[tmarc:s2='olc-ssg' or tmarc:s2='ssgn'
							or (tmarc:s2='z' and tmarc:sq='DE-601')]">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
		
		
		<xsl:for-each select="tmarc:sa">
			<xsl:variable name="region">
				<xsl:choose>
					<xsl:when test=".='sca' or .='xsc'
									or .='suo' or .='xsu'">nord</xsl:when>
					<xsl:when test=".='bal' or .='xba'
									or .='oeu'">balt</xsl:when>
					<xsl:when test=".='vnd' or .='xvn'">ostsee</xsl:when>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:if test="$region='nord' or $region='balt' or $region='ostsee'">
				<pz:metadata type="region">
					<xsl:value-of select="$region"/>
				</pz:metadata>
			</xsl:if>
			
			<xsl:if test="$catalogueURLHintPrefix='http://gso.gbv.de/DB=2.3/PPNSET?PPN='">
				<xsl:variable name="db-id">
					<xsl:choose>
						<xsl:when test="$region='nord'">2.47</xsl:when>
						<xsl:when test="$region='balt'">2.151</xsl:when>
					</xsl:choose>
				</xsl:variable>

				<xsl:if test="string-length($db-id) &gt; 0">
					<pz:metadata type="catalogueURLHintPrefix">
						<xsl:text>http://gso.gbv.de/DB=</xsl:text>
						<xsl:value-of select="$db-id"/>
						<xsl:text>/PPNSET?PPN=</xsl:text>
					</pz:metadata>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
