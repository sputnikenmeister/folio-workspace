<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

<xsl:import href="../utilities/typography.xsl"/>
<xsl:import href="json/helpers.xsl"/>

<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates select="/data/bundles-by-handle/entry"/>
	<xsl:apply-templates select="/data/bundles-by-handle/error"/>
</xsl:template>

<xsl:template match="bundles-by-handle/error">
	<xsl:text>{}</xsl:text>
</xsl:template>

<xsl:template match="bundles-by-handle/entry">
</xsl:template>

<xsl:template match="bundles-by-handle/entry[1]">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name | completed "/>
			<xsl:apply-templates select="description | attributes | images"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="images/item" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<!--<file><xsl:copy-of select="file/filename/text()"/></file>-->
			<url><xsl:value-of select="file/@path"/>/<xsl:copy-of select="file/filename/text()"/></url>
			<w><xsl:value-of select="file/meta/@width"/></w>
			<h><xsl:value-of select="file/meta/@height"/></h>
			<xsl:apply-templates select="description | attributes"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="images">
	<xsl:variable name="images" select="item[published/text() = 'Yes']"/>
	<path><xsl:value-of select="$images/file/@path"/></path>
	<images>
		<xsl:choose>
			<xsl:when test="$images">
				<xsl:copy-of select="$images"/>
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</images>
</xsl:template>

<xsl:template match="description">
	<desc mode="formatted">
		<xsl:copy-of select="*"/>
	</desc>
</xsl:template>

<xsl:template match="attributes">
	<attrs>
		<xsl:choose>
			<xsl:when test="item"><xsl:copy-of select="item"/></xsl:when>
			<xsl:otherwise><empty/></xsl:otherwise>
		</xsl:choose>
	</attrs>
</xsl:template>

</xsl:stylesheet>
