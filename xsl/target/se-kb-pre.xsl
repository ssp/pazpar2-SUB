<?xml version="1.0" encoding="UTF-8"?>
<!--
	Swedish national library:
		* extract sub-database ID

	2014-2015: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->

<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tmarc="http://www.indexdata.com/turbomarc"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	version="1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>


	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<!--
		Extract sub-database/collection ID from 852 $5 or 042 $9.
		only keep the databases we know and create the collection field.
	-->
	<xsl:template match="tmarc:d852|tmarc:d042">
		<xsl:copy-of select="."/>
		<xsl:for-each select="tmarc:s5[parent::tmarc:d852]|tmarc:s9[parent::tmarc:d042]">
			<xsl:if test="
				.='NB' or
				.='COL' or
				.='SB17' or
				.='SOT' or
				.='SHB' or
				.='SLB' or
				.='BIRB' or
				.='BULB' or
				.='KVIN' or
				.='SAMB' or
				.='SWAM' or
				.='NLT' or
				.='LOB' or
				.='DALA' or
				.='GOTL' or
				.='OSGO' or
				.='SAH' or
				.='SARB' or
				.='SFBB' or
				.='SNUB' or
				.='VSTM' or
				.='VIMO' or
				.='LITT'
			">
				<pz:metadata type="se-kb-collection">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
