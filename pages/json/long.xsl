<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl"> -->

<xsl:strip-space elements="*"/>

<xsl:include href="helpers.xsl"/>

<xsl:template match="images/item" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<file><xsl:copy-of select="file/filename/text()"/></file>
			<!-- <url><xsl:value-of select="file/@path"/>/<xsl:copy-of select="file/filename/text()"/></url> -->
			<w><xsl:value-of select="file/meta/@width"/></w>
			<h><xsl:value-of select="file/meta/@height"/></h>
			<xsl:apply-templates select="description | attributes" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="images" mode="prepare-json">
	<xsl:variable name="images" select="item[published/text() = 'Yes']"/>
	<!-- <path><xsl:value-of select="$images/file/@path"/></path> -->
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

<xsl:template match="attributes" mode="prepare-json">
	<attrs>
		<xsl:choose>
			<xsl:when test="item">
				<xsl:copy-of select="item"/>
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</attrs>
</xsl:template>

<xsl:template match="description" mode="prepare-json">
	<desc mode="formatted">
		<xsl:copy-of select="*"/>
	</desc>
</xsl:template>

</xsl:stylesheet>
