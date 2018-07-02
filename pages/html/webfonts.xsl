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
	<xsl:text>&#xa;@font-face {</xsl:text>

	<xsl:text>&#xa;</xsl:text>
	<xsl:apply-templates select="font-family | font-weight | font-style" mode="webfonts"/>

	<xsl:text>&#xa;src: </xsl:text>
	<xsl:apply-templates select="src[not(format)]" mode="webfonts"/>
	<xsl:text>;</xsl:text>

	<xsl:text>&#xa;src: </xsl:text>
	<xsl:apply-templates select="src[format]" mode="webfonts"/>
	<xsl:text>;</xsl:text>

	<xsl:text>&#xa;}</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>&#xa;</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="font-family | font-weight | font-style" mode="webfonts">
	<xsl:value-of select="local-name()"/>
	<xsl:text>: </xsl:text>
	<xsl:copy-of select="text()"/>
	<xsl:text>; </xsl:text>
</xsl:template>

<xsl:template match="src" mode="webfonts">
	<xsl:text>url('</xsl:text>
	<!-- if inline base64 data available -->
	<xsl:choose>
		<xsl:when test="url[@scheme = 'data']
			and (format/text() = 'woff' or format/text() = 'woff2')
			and (../font-style/text() = 'normal')
			">
			<xsl:value-of select="normalize-space(url[@scheme = 'data'][1])"/>
		</xsl:when>
		<xsl:otherwise>
			<!-- <xsl:value-of select="concat(
				$workspace,
				'/assets/fonts/',
				normalize-space(url[not(@scheme)][1])
			)"/> -->
			<xsl:value-of select="$workspace"/>
			<xsl:text>/assets/fonts/</xsl:text>
			<xsl:value-of select="normalize-space(url[not(@scheme)][1])"/>
			<!-- <xsl:if test="$debug"> -->
				<!-- <xsl:text>?</xsl:text> -->
				<!-- <xsl:value-of select="$tstamp"/> -->
			<!-- </xsl:if> -->
		</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="format">
		<xsl:text> </xsl:text>
		<xsl:apply-templates select="format"/>
	</xsl:if>
	<xsl:if test="position() != last()">
		<xsl:text>,&#xa;</xsl:text>
	</xsl:if>
</xsl:template>

<!-- <xsl:template match="src/url" mode="webfonts">
	<xsl:text>url('</xsl:text>
	<xsl:value-of select="$workspace"/>
	<xsl:text>/assets/fonts/</xsl:text>
	<xsl:value-of select="normalize-space(url[not(@scheme)][1])"/>
	<xsl:text>')</xsl:text>
</xsl:template> -->

<!-- <xsl:template match="src/url[@scheme = 'data']" mode="webfonts">
	<xsl:text>url('</xsl:text>
	<xsl:copy-of select="normalize-space(text())"/>
	<xsl:text>')</xsl:text>
</xsl:template> -->


<!-- <xsl:template match="src/format" mode="webfonts">
	<xsl:text> format('</xsl:text>
	<xsl:copy-of select="normalize-space(text())"/>
	<xsl:text>')</xsl:text>
</xsl:template> -->


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
