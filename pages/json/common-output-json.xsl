<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:e="http://exslt.org/common"
	 xmlns:s="http://exslt.org/strings"
	 extension-element-prefixes="e s">

<xsl:import href="../../utilities/output-json.xsl"/>
<xsl:import href="../../utilities/typography.xsl"/>
<!-- <xsl:import href="../../utilities/escape-string.xsl"/> -->

<xsl:strip-space elements="*"/>

<!-- Generic HTML text -->
<xsl:template match="*[@mode='formatted']" mode="output-json">
	<xsl:text>'</xsl:text>
	<xsl:value-of select="name(.)" />
	<xsl:text>':'</xsl:text>
	<!-- <xsl:copy-of select="node()|text()"/> -->
	<xsl:apply-templates select="node()|text()" mode="html"/>
	<xsl:text>'</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>
	<!-- Escape Quotes -->
	<!-- extends html mode in escape-string.xsl -->
	<xsl:template match="text()" mode="html">
		<!-- <span class="s"> -->
		<xsl:call-template name="escape-bs-string">
			<xsl:with-param name="s" select="."/>
		</xsl:call-template>
		<!-- </span> -->
	</xsl:template>
	<xsl:template match="@href[starts-with(.,'http')]" mode="html">
		<xsl:attribute name="{name()}">
			<xsl:value-of disable-output-escaping="yes" select="."/>
		</xsl:attribute>
		<xsl:attribute name="target">_blank</xsl:attribute>
	</xsl:template>

<!-- Ignored -->
<xsl:template match="section" mode="output-json"/>

<!-- Named properties -->
<xsl:template match="completed/text()" mode="output-json">
	<xsl:text>'</xsl:text>
	<xsl:value-of select="substring(current(),1,10)"/>
	<xsl:text>'</xsl:text>
</xsl:template>


<!-- Generic text-only array (e.g. atrributes) -->
<xsl:template match="item[count(text()) = count(node())]" mode="output-json">
	<xsl:text>'</xsl:text>
	<xsl:value-of select="text()" />
	<xsl:text>'</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- Generic array -->
<xsl:template match="*[count(item|entry|empty) &gt; 0]" mode="output-json">
	<xsl:text>'</xsl:text>
	<xsl:value-of select="name(.)" />
	<xsl:text>':[</xsl:text>
	<xsl:apply-templates select="item|entry" mode="output-json"/>
	<xsl:text>]</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>
