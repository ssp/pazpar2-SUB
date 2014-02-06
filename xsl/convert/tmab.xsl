<?xml version="1.0" encoding="UTF-8"?>
<!--
	Extract a few fields from MAB Data, read in as TurboMARC.

	http://www.dnb.de/DE/Standardisierung/Formate/MAB/mab_node.html

	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tmarc="http://www.indexdata.com/turbomarc"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0">

	<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>
	
	<xsl:strip-space elements="*" />

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="tmarc:collection">
		<collection>
			<xsl:apply-templates/>
		</collection>
	</xsl:template>

	<xsl:template match="tmarc:r">
		<pz:record>
			
			<!--
				Record ID.
			-->
			<xsl:for-each select="tmarc:c001">
				<pz:metadata type="id">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			
			<xsl:for-each select="tmarc:d037/tmarc:sa">
				<pz:metadata type="language">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d050">
				<xsl:variable name="mab050">
					<xsl:value-of select="translate(., '|', ' ')"/>
					<!-- ensure minimum length to avoid empty substrings when the field is too short. -->
					<xsl:text>||||||||||||||</xsl:text>
				</xsl:variable>
				<xsl:variable name="mab051">
					<xsl:value-of select="translate(../tmarc:d051, '|', ' ')"/>
					<xsl:text>|||||||</xsl:text>
				</xsl:variable>
				<xsl:variable name="mab052">
					<xsl:value-of select="translate(../tmarc:d052, '|', ' ')"/>
					<xsl:text>|||||||||||||||</xsl:text>
				</xsl:variable>
				
				<pz:metadata type="medium">
					<xsl:choose>
						<xsl:when test="substring($mab050, 2, 1) = 'a'">manuscript</xsl:when>
						<xsl:when test="contains('abc', substring($mab050, 4, 1))">microform</xsl:when>
						<xsl:when test="substring($mab050, 6, 1) = 'a'">recording</xsl:when>
						<xsl:when test="contains('bc', substring($mab050, 6, 1))">audio-visual</xsl:when>
						<xsl:when test="substring($mab050, 6, 1) = 'd'">image</xsl:when>
						<xsl:when test="contains('abcdefgz', substring($mab050, 9, 1))">electronic</xsl:when>
						<xsl:when test="substring($mab050, 11, 1) = 'a'">map</xsl:when>
						<xsl:when test="substring($mab050, 8, 1) = 'a'">multiple</xsl:when>
						<xsl:when test="contains('nt', substring($mab051, 1, 1))">multivolume</xsl:when>
						<xsl:when test="substring($mab052, 1, 1) = 'a'">article</xsl:when>
						<xsl:when test="substring($mab052, 1, 1) = 'z'">newspaper</xsl:when>
						<xsl:when test="substring($mab052, 1, 1) = 'p'">journal</xsl:when>
						<xsl:when test="contains(substring($mab051, 2, 3), 'm')">music-score</xsl:when>		
						<xsl:otherwise>book</xsl:otherwise>
					</xsl:choose>					
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d100|tmarc:d104|tmarc:d108|tmarc:d112|tmarc:d116|tmarc:d120|tmarc:d124|tmarc:d128|tmarc:d132|tmarc:d136">
				<xsl:variable name="fieldName">
					<xsl:choose>
						<xsl:when test="./tmarc:sp or ./tmarc:sa">author</xsl:when>
						<xsl:otherwise>other-person</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<pz:metadata type="{$fieldName}">
					<xsl:value-of select="tmarc:sa|tmarc:sb|tmarc:sc|tmarc:se|tmarc:sp"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d200|tmarc:d204|tmarc:d208|tmarc:d212|tmarc:d216|tmarc:d220|tmarc:d224|tmarc:d228|tmarc:d232|tmarc:d236">
				<pz:metadata type="corporate-name">
					<xsl:value-of select="tmarc:sa|tmarc:sb|tmarc:sc|tmarc:se|tmarc:sp"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d331/tmarc:sa">
				<pz:metadata type="title">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d335/tmarc:sa">
				<pz:metadata type="title-remainder">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d331/tmarc:sa">
				<pz:metadata type="title">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d410/tmarc:sa">
				<pz:metadata type="publication-place">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d412/tmarc:sa">
				<pz:metadata type="publication-name">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d425[@i1='a']/tmarc:sa">
				<pz:metadata type="date">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:if test="not(tmarc:d425[@i1='a'])">
				<xsl:for-each select="tmarc:d425">
					<pz:metadata type="publication-date">
						<xsl:value-of select="."/>
					</pz:metadata>
				</xsl:for-each>
			</xsl:if>
			
			<xsl:for-each select="tmarc:d433/tmarc:sa">
				<pz:metadata type="physical-extent">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d451/tmarc:sa">
				<pz:metadata type="series-title">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d501|tmarc:502|tmarc:503|tmarc:504|tmarc:505|
									tmarc:506|tmarc:507|tmarc:508|tmarc:509|tmarc:510|
									tmarc:511|tmarc:512|tmarc:513|tmarc:514|tmarc:515|
									tmarc:516|tmarc:517|tmarc:518|tmarc:519|tmarc:520|
									tmarc:521|tmarc:522|tmarc:523|tmarc:524|tmarc:525|
									tmarc:526|tmarc:527|tmarc:528|tmarc:529|tmarc:530|
									tmarc:531|tmarc:532|tmarc:533|tmarc:534|tmarc:535|
									tmarc:536|tmarc:537|tmarc:538">
				<pz:metadata type="description">
					<xsl:value-of select="./*"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d540/tmarc:sa">
				<pz:metadata type="isbn">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d542/tmarc:sa">
				<pz:metadata type="issn">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d552/tmarc:sa">
				<pz:metadata type="doi">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>

			<xsl:for-each select="tmarc:d655[@i1='e']">
				<pz:metadata type="electronic-url">
					<xsl:if test="tmarc:s3">
						<xsl:attribute name="name">
							<xsl:value-of select="tmarc:s3"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d700[@i1='g']">
				<pz:metadata type="classification-rvk">
					<xsl:value-of select="./tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d700[@i1='m']">
				<pz:metadata type="classification-msc">
					<xsl:value-of select="./tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d700[@i1='b']/tmarc:sa|tmarc:d705[@i1='a']/tmarc:sc">
				<pz:metadata type="classification-ddc">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d710|tmarc:d711|tmarc:d740">
				<pz:metadata type="subject">
					<xsl:value-of select="./tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>
			
		</pz:record>
	</xsl:template>

</xsl:stylesheet>
