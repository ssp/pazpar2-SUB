<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">
<!--
	Improve metadata from vifanord’s link database.
		* map all subject information to the subject field
		* map source-type field to media types
	
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



	<!--
		Map source-type field to media types.
		The medium field is used by vifanord-zqsl-ir-post2.xsl.
		
		Expected values for the website type are in the list:
		ar, sf1, so1, fv, so2, spol, me, sc, etc-info, dg, fp, kn,
		etc-koop, ej0, ej1, ej2, we, ak, ay, d6, etc-fact, ff, smk,
		kb, blz6, bls, vcz6, vme, vcfd, vckn, vcho, vcvt, vcbd, sgv,
		vle, vcue, vcka, etc-bib, sw, ph, nm, bb, ka, mp, do, etc-prim
	-->
	<xsl:template match="pz:metadata[@type='source-type']">
		<xsl:variable name ="firstMedium">
			<xsl:choose>
				<xsl:when test="contains(., ';')">
					<xsl:value-of select="substring-before(., ';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<pz:metadata type="medium">
			<xsl:choose>
				<xsl:when test="$firstMedium = 'z59' or
								$firstMedium = 'z61' or
								$firstMedium = 'fds' or
								$firstMedium = 'ktb' or
								$firstMedium = 'eb2' or
								$firstMedium = 'eb1' or
								$firstMedium = 'ap' or
								$firstMedium = 'gs' or
								$firstMedium = 'le'">
					<xsl:text>electronic</xsl:text>
				</xsl:when>
				<xsl:when test="$firstMedium = 'z60'">journal</xsl:when>
				<xsl:otherwise>website</xsl:otherwise>
			</xsl:choose>
		</pz:metadata>
	</xsl:template>

</xsl:stylesheet>
