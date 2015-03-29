<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pz="http://www.indexdata.com/pazpar2/1.0"
	xmlns:tmarc="http://www.indexdata.com/turbomarc"
	version="1.0">
<!--
	Extract data from Unimarc records for pazpar2.
	
	To improve on unimarc.xsl from the pazpar2 distribution:
	more fields, media types, using TurboMARC.
	
	http://archive.ifla.org/VI/8/unimarc-concise-bibliographic-format-2008.pdf
	http://archive.ifla.org/VI/3/p1996-1/uni.htm
	
	2014: Sven-S. Porst <ssp-web@earthlingsoft.net>
-->

	<xsl:output indent="yes" method="xml" encoding="UTF-8"/>


	<xsl:template match="tmarc:r">
		<pz:record>
			
			<!-- Determine media type. -->
			<xsl:variable name="typeofrecord">
				<xsl:value-of select="substring(tmarc:l, 7, 1)"/>
			</xsl:variable>
			<xsl:variable name="biblevel">
				<xsl:value-of select="substring(tmarc:l, 8, 1)"/>
			</xsl:variable>
			<xsl:variable name="continuing">
				<xsl:value-of select="substring(tmarc:d110/tmarc:sa, 1, 1)"/>
			</xsl:variable>
			
			<pz:metadata type="medium">
				<xsl:choose>
					<xsl:when test="tmarc:d106/tmarc:sa = 't'">microform</xsl:when>
					<xsl:when test="$typeofrecord = 'a'">
						<xsl:choose>
							<xsl:when test="$biblevel = 'a'">article</xsl:when>
							<xsl:when test="$biblevel = 'm'">
								<xsl:choose>
									<xsl:when test="$continuing = 'b'">multivolume</xsl:when>
									<xsl:otherwise>book</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$biblevel = 's'">
								<xsl:choose>
									<xsl:when test="$continuing = 'b'">multivolume</xsl:when>
									<xsl:when test="$continuing = 'c'">newspaper</xsl:when>
									<xsl:when test="$continuing = 'f'">data</xsl:when>
									<xsl:when test="$continuing = 'g'">website</xsl:when>
									<xsl:otherwise>journal</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="$biblevel = 'c'">other</xsl:when>
							<xsl:otherwise>other</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$typeofrecord = 'b'">manuscript</xsl:when>
					<xsl:when test="contains('cd', $typeofrecord)">music-score</xsl:when>
					<xsl:when test="contains('ef', $typeofrecord)">map</xsl:when>
					<xsl:when test="$typeofrecord = 'g'">audio-visual</xsl:when>
					<xsl:when test="contains('ij', $typeofrecord)">recording</xsl:when>
					<xsl:when test="$typeofrecord = 'k'">image</xsl:when>
					<xsl:when test="contains('lm', $typeofrecord)">electronic</xsl:when>
					<xsl:when test="$typeofrecord = 'o'">multiple</xsl:when>
					<xsl:otherwise>other</xsl:otherwise>
				</xsl:choose>
			</pz:metadata>
			
			
			<!-- Extract date from position 9-12 of field 100 $a. -->
			<xsl:variable name="date">
				<xsl:value-of select="normalize-space(translate(substring(tmarc:d100/tmarc:sa, 10, 4), '|', ''))"/>
			</xsl:variable>
			
			<xsl:if test="string-length($date) = 4 and translate($date, '0123456789', '**********') = '****'">
				<pz:metadata type="date">
					<xsl:value-of select="$date"/>
				</pz:metadata>
			</xsl:if>
			
			
			
			<xsl:for-each select="tmarc:c001">
				<pz:metadata type="id">
					<xsl:value-of select="."/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d010">
				<pz:metadata type="isbn">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d011">
				<pz:metadata type="issn">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>

			<xsl:for-each select="tmarc:d020">
				<xsl:if test="tmarc:sa = 'US'">
					<pz:metadata type="lccn">
						<xsl:value-of select="tmarc:sb"/>
					</pz:metadata>
				</xsl:if>
			</xsl:for-each>

			<xsl:for-each select="tmarc:d101">
				<xsl:for-each select="tmarc:*">
					<pz:metadata type="language">
						<xsl:value-of select="."/>
					</pz:metadata>
				</xsl:for-each>
			</xsl:for-each>
			
			
			<xsl:for-each select="tmarc:d200">
				<pz:metadata type="title">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
				<pz:metadata type="title-remainder">
					<xsl:value-of select="tmarc:se"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d210">
				<pz:metadata type="publication-name">
					<xsl:value-of select="tmarc:sc"/>
				</pz:metadata>
				<pz:metadata type="publication-place">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
				<pz:metadata type="publication-date">
					<xsl:value-of select="tmarc:sd"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d215">
				<pz:metadata type="physical-extent">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
				<pz:metadata type="physical-format">
					<xsl:value-of select="tmarc:sc"/>
				</pz:metadata>
				<pz:metadata type="physical-dimensions">
					<xsl:value-of select="tmarc:sd"/>
				</pz:metadata>
				<pz:metadata type="physical-accomp">
					<xsl:value-of select="tmarc:se"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d225">
				<pz:metadata type="series-title">
					<xsl:value-of select="tmarc:sa"/>
					<xsl:if test="tmarc:sa"> </xsl:if>
					<xsl:value-of select="tmarc:sv"/>
				</pz:metadata>
			</xsl:for-each>
			
			
			<xsl:for-each select="tmarc:*[substring(local-name(.), 1, 1) = '3']">
				<pz:metadata type="description">
					<xsl:for-each select="./*">
						<xsl:value-of select="text()"/>
						<xsl:if test="position()!=last() and .!=''">
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</pz:metadata>
			</xsl:for-each>
			
			
			<xsl:for-each select="tmarc:d606|tmarc:d610">
				<pz:metadata type="subject">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d675">
				<pz:metadata type="classification-udc">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>

			<xsl:for-each select="tmarc:d676">
				<pz:metadata type="classification-ddc">
					<xsl:value-of select="tmarc:sa"/>
				</pz:metadata>
			</xsl:for-each>
			
			<xsl:for-each select="tmarc:d700|tmarc:d701|tmarc:d702">
				<xsl:variable name="fieldName">
					<xsl:choose>
						<xsl:when test="local-name() = 'd700'">author</xsl:when>
						<xsl:when test="contains(tmarc:s4, '070')">author</xsl:when>
						<xsl:otherwise>other-person</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<pz:metadata type="{$fieldName}">
					<xsl:value-of select="tmarc:sa"/>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="tmarc:sb"/>
				</pz:metadata>
			</xsl:for-each>
			

			
			<xsl:for-each select="tmarc:d856">
				<pz:metadata type="electronic-url">
					<xsl:value-of select="tmarc:su"/>
				</pz:metadata>
			</xsl:for-each>

		</pz:record>
	</xsl:template>


</xsl:stylesheet>
