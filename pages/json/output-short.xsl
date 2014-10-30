<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="common-prepare-json.xsl"/>
<xsl:import href="common-output-json.xsl"/>
<xsl:strip-space elements="*"/>

<!-- Two-pass transforms -->

<!-- All Images -->
<xsl:template match="all-images/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<f><xsl:copy-of select="file/filename/text()"/></f>
			<!-- <url><xsl:value-of select="file/@path"/>/<xsl:copy-of select="file/filename/text()"/></url> -->
			<w><xsl:value-of select="file/meta/@width"/></w>
			<h><xsl:value-of select="file/meta/@height"/></h>
			<bId><xsl:value-of select="bundle/item/@id"/></bId>
			<xsl:apply-templates select="attributes" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- All bundles -->
<xsl:template match="all-bundles/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name | completed"/>
			<xsl:apply-templates select="keywords | images" mode="prepare-json"/>
			<xsl:apply-templates select="attributes" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- Keywords -->
<xsl:template match="keywords" mode="prepare-json">
	<kIds>
		<xsl:copy-of select="item"/>
	</kIds>
</xsl:template>
<xsl:template match="kIds/item" mode="output-json">
	<xsl:value-of select="@id" />
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- Images -->
<xsl:template match="images" mode="prepare-json">
	<xsl:variable name="item-list" select="item[published/text() = 'Yes']"/>
	<!-- <xsl:variable name="item-list" select="item"/> -->
	<iIds>
		<xsl:choose>
			<xsl:when test="$item-list">
				<xsl:copy-of select="$item-list"/>
				<!-- <xsl:apply-templates select="$item-list" mode="prepare-json"/> -->
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</iIds>
</xsl:template>
<xsl:template match="iIds/item" mode="output-json">
	<xsl:value-of select="@id" />
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
