<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="cdata-value">
		<xsl:param name="item" />
		<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
			<xsl:for-each select="$item/self::*">
				<xsl:copy-of select="text() | node()" />
				<!-- <xsl:copy-of disable-output-escaping="yes" select="text() | node()" /> -->
			</xsl:for-each>
		<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
	</xsl:template>
	
	<xsl:template name="cdata-simple-element">
		<xsl:param name="item" />
		<xsl:param name="name" />
		<xsl:element name="{$name}">
			<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
			<xsl:value-of disable-output-escaping="yes" select="$item/text()" />
			<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
		</xsl:element>
	</xsl:template>

	<xsl:template name="cdata-complex-element">
		<xsl:param name="item" />
		<xsl:param name="name" />
		<xsl:element name="{$name}">
			<xsl:call-template name="cdata-value">
				<xsl:with-param name="item" select="$item"/>
			</xsl:call-template>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>