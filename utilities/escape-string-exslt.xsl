<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:s="http://exslt.org/strings"
	extension-element-prefixes="s">

	<xsl:template name="escape-string">
		<xsl:param name="s"/>
		<xsl:text>'</xsl:text>
		<xsl:call-template name="escape-bs-string">
			<xsl:with-param name="s" select="$s"/>
		</xsl:call-template>
		<xsl:text>'</xsl:text>
	</xsl:template>

	<xsl:template name="escape-bs-string">
		<xsl:param name="s"/>
		<!--
		backslash, quote, tab, line feed, carriage return
		'\', '\\'
		'&quot;', '\&quot;'
		'&#x9;', '\t'
		'&#xA;', '\n'
		'&#xD;', '\r'
		-->
		<xsl:value-of select="
			s:replace(
				s:replace(
					s:replace(
						s:replace(
							s:replace($s,
							'\', '\\'),
						'&quot;', '\&quot;'),
					'&#x9;', '\t'),
				'&#xA;', '\n'),
			'&#xD;', '\r')"/>
	</xsl:template>

</xsl:stylesheet>
