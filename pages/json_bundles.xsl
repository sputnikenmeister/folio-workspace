<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="json/output-long.xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates select="data/bundles-get/entry[1]"/>
	<xsl:apply-templates select="data/bundles-get/error"/>
</xsl:template>

<xsl:template match="bundles-get/error">
	<xsl:text>{}</xsl:text>
</xsl:template>

<xsl:template match="bundles-get/entry">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name | completed "/>
			<xsl:apply-templates select="description | attributes" mode="prepare-json"/>
			<xsl:apply-templates select="/data/media-find-by-bundle/bundle[@link-id = current()/@id]" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- Media -->
<xsl:template match="media-find-by-bundle/bundle" mode="prepare-json">
	<xsl:variable name="item-list" select="entry"/>
	<media>
		<xsl:choose>
			<xsl:when test="$item-list">
				<xsl:copy-of select="$item-list"/>
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</media>
</xsl:template>
<xsl:template match="media/entry" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<o><xsl:value-of select="order"/></o>
			
			<xsl:variable name="$default-file" select="sources/item/file[contains(@type,'image')][1]"/>
			<f><xsl:copy-of select="$default-file/filename/text()"/></f>
			<w><xsl:value-of select="$default-file/meta/@width"/></w>
			<h><xsl:value-of select="$default-file/meta/@height"/></h>
			
			<xsl:apply-templates select="description | attributes" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
