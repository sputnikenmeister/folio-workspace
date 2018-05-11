<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	Example:

	<xsl:call-template name="ie-cond">
		<xsl:with-param name="expr" select="'lte IE 9'"/>
		<xsl:with-param name="content">
			<link id="ie" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/ie.css"/>
		</xsl:with-param>
	</xsl:call-template>
-->

<xsl:template name="ie-cond">
	<xsl:param name="expr"/>
	<xsl:param name="content"/>
	<xsl:text disable-output-escaping="yes">&lt;!--[if </xsl:text>
	<xsl:value-of select="$expr" />
	<xsl:text disable-output-escaping="yes">]&gt;</xsl:text>
	<xsl:copy-of select="$content" />
	<xsl:text disable-output-escaping="yes">&lt;![endif]--&gt;</xsl:text>
</xsl:template>

</xsl:stylesheet>
