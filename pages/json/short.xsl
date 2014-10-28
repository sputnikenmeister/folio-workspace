<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:strip-space elements="*"/>

<xsl:include href="helpers.xsl"/>

<!-- Two-pass transforms -->

<!-- All bundles -->
<xsl:template match="all-bundles/entry" mode="output-json">
	<xsl:text>&#xa;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<uid><xsl:value-of select="uid/@handle"/></uid>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name | completed"/>
			<xsl:apply-templates select="keywords | images" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- Second pass -->
<xsl:template match="keywordIds/item" mode="output-json">
	<xsl:value-of select="@id" />
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="imageIds/item" mode="output-json">
	<xsl:value-of select="@id" />
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- First pass -->
<xsl:template match="keywords" mode="prepare-json">
	<keywordIds>
		<xsl:copy-of select="item"/>
	</keywordIds>
</xsl:template>

<xsl:template match="images" mode="prepare-json">
	<!-- <xsl:variable name="images" select="item[published/text() = 'Yes']"/> -->
	<xsl:variable name="item-list" select="item"/>
	<imageIds>
		<xsl:choose>
			<xsl:when test="$item-list">
				<xsl:copy-of select="$item-list"/>
				<!-- <xsl:apply-templates select="$item-list" mode="prepare-json"/> -->
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</imageIds>
</xsl:template>

</xsl:stylesheet>
