<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:e="http://exslt.org/common"
	extension-element-prefixes="e">

<xsl:template match="webfonts" mode="webfonts">
	<style>
		<xsl:apply-templates select="font-face" mode="webfonts"/>
	</style>
</xsl:template>

<xsl:template match="font-face" mode="webfonts">
	<xsl:text>&#xa;&#9;</xsl:text>
	<xsl:text>@font-face {</xsl:text>

	<!-- <xsl:text>&#xa;&#9;&#9;</xsl:text> -->
	<xsl:apply-templates select="font-family | font-weight | font-style" mode="webfonts"/>

	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:text>src: </xsl:text>
	<xsl:apply-templates select="src[not(format)]" mode="webfonts"/>
	<xsl:text>;</xsl:text>

	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:text>src: </xsl:text>
	<xsl:apply-templates select="src[format]" mode="webfonts"/>
	<xsl:text>;</xsl:text>

	<xsl:text>&#xa;&#9;</xsl:text>
	<xsl:text>}</xsl:text>
	<!-- <xsl:if test="position() != last()">
		<xsl:text>&#xa;</xsl:text>
	</xsl:if> -->
</xsl:template>

<xsl:template match="font-family | font-weight | font-style" mode="webfonts">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:value-of select="local-name()"/>
	<xsl:text>: </xsl:text>
	<xsl:copy-of select="text()"/>
	<xsl:text>; </xsl:text>
</xsl:template>

<xsl:template match="src" mode="webfonts">
	<xsl:apply-templates select="url[not(@scheme)][1]" mode="webfonts"/>
	<xsl:if test="format">
		<xsl:apply-templates select="format" mode="webfonts"/>
	</xsl:if>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
		<xsl:text>&#xa;&#9;&#9;&#9;</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="url[@scheme = 'data']" mode="webfonts">
	<xsl:text>url('</xsl:text>
	<xsl:copy-of select="normalize-space(text())"/>
	<xsl:text>')</xsl:text>
</xsl:template>

<xsl:template match="url" mode="webfonts">
	<xsl:text>url('</xsl:text>
	<xsl:value-of select="$workspace"/>
	<xsl:text>/assets/fonts/</xsl:text>
	<xsl:value-of select="normalize-space(text())"/>
	<xsl:text>')</xsl:text>
</xsl:template>


<xsl:template match="src/format" mode="webfonts">
	<xsl:text>&#x20;</xsl:text>
	<xsl:text>format('</xsl:text>
	<xsl:copy-of select="normalize-space(text())"/>
	<xsl:text>')</xsl:text>
</xsl:template>


<!--
<xsl:template match="src[not(format)]" mode="webfonts">
	<xsl:text>url('</xsl:text>
	<xsl:copy-of select="url/text()"/>
	<xsl:text>') format('</xsl:text>
	<xsl:copy-of select="format/text()"/>
	<xsl:text>')</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,&#xa;</xsl:text>
	</xsl:if>
</xsl:template>
-->

<!--
<xsl:template match="src[format]" mode="webfonts">
	<xsl:value-of select="local-name()"/>:<xsl:copy-of select="text()"/>;
</xsl:template>
-->

</xsl:stylesheet>
