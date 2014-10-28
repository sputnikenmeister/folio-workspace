<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="json/long.xsl"/>

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
			<uid><xsl:value-of select="uid/@handle"/></uid>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name | completed "/>
			<xsl:apply-templates select="description | attributes | images" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
