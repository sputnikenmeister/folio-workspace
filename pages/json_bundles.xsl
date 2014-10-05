<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">

<xsl:import href="json/helpers.xsl"/>

<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates select="data/bundles-by-handle/entry"/>
	<xsl:apply-templates select="data/bundles-by-handle/error"/>
</xsl:template>

<xsl:template match="bundles-by-handle/error">
	<xsl:text>{}</xsl:text>
</xsl:template>

<xsl:template match="bundles-by-handle/entry">
</xsl:template>

<xsl:template match="bundles-by-handle/entry[1]">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="name/@handle"/></id>
			<xsl:copy-of select="name | images | completed | description | attributes"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="images/item" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
<!--		<xsl:element name="item">-->
			<url><xsl:value-of select="file/@path"/>/<xsl:copy-of select="file/filename/text()"/></url>
			<width><xsl:value-of select="file/meta/@width"/></width>
			<height><xsl:value-of select="file/meta/@height"/></height>
			<xsl:copy-of select="description"/>
			<xsl:copy-of select="attributes"/>
<!--		</xsl:element>-->
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
