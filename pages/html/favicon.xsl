<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times"
	extension-element-prefixes="date">

<xsl:template name="favicon">
	<xsl:param name="url-prefix"/>
	<xsl:param name="bg-color" select="'#ffffff'"/>
	<xsl:param name="output-apps" select="true()"/>
	<xsl:param name="output-comments" select="false()"/>
	<xsl:param name="prevent-cache" select="false()"/>
	<xsl:variable name="ts">
		<xsl:if test="$prevent-cache">?<xsl:value-of select="date:seconds()"/></xsl:if>
	</xsl:variable>
	<xsl:if test="$output-apps">
	<!-- ms -->
	<xsl:if test="$output-comments"><xsl:comment>msapplication begin</xsl:comment></xsl:if>
	<meta name="msapplication-square70x70logo" content="{$url-prefix}/windows-tile-70x70.png{$ts}"/>
	<meta name="msapplication-square150x150logo" content="{$url-prefix}/windows-tile-150x150.png{$ts}"/>
	<meta name="msapplication-square310x310logo" content="{$url-prefix}/windows-tile-310x310.png{$ts}"/>
	<meta name="msapplication-TileImage" content="{$url-prefix}/windows-tile-144x144.png{$ts}"/>
	<meta name="msapplication-TileColor" content="{$bg-color}"/>
	<xsl:if test="$output-comments"><xsl:comment>msapplication end</xsl:comment></xsl:if>
	<!-- apple [57, 72, 114, 120, 144, 152];-->
	<xsl:if test="$output-comments"><xsl:comment>apple-touch-icon begin</xsl:comment></xsl:if>
	<link rel="apple-touch-icon" href="{$url-prefix}/apple-touch-icon-152x152.png{$ts}" sizes="152x152"/>
	<link rel="apple-touch-icon" href="{$url-prefix}/apple-touch-icon-144x144.png{$ts}" sizes="144x144"/>
	<link rel="apple-touch-icon" href="{$url-prefix}/apple-touch-icon-120x120.png{$ts}" sizes="120x120"/>
	<link rel="apple-touch-icon" href="{$url-prefix}/apple-touch-icon-114x114.png{$ts}" sizes="114x114"/>
	<link rel="apple-touch-icon" href="{$url-prefix}/apple-touch-icon-72x72.png{$ts}" sizes="72x72"/>
	<link rel="apple-touch-icon" href="{$url-prefix}/apple-touch-icon-57x57.png{$ts}"/>
	<link rel="apple-touch-icon-precomposed" href="{$url-prefix}/apple-touch-icon-57x57.png{$ts}"/>
	<!-- <link rel="apple-touch-icon-precomposed" href="{$url-prefix}/apple-touch-icon.png"/> -->
	<xsl:if test="$output-comments"><xsl:comment>apple-touch-icon end</xsl:comment></xsl:if>
	</xsl:if>
	<!-- favicon -->
	<xsl:if test="$output-comments"><xsl:comment>favicon begin</xsl:comment></xsl:if>
	<link rel="shortcut icon" href="{$url-prefix}/favicon.ico{$ts}"/>
	<link rel="icon" type="image/png{$ts}" sizes="64x64" href="{$url-prefix}/favicon.png{$ts}"/>
	<xsl:if test="$output-comments"><xsl:comment>favicon end</xsl:comment></xsl:if>
</xsl:template>

<!--
<link rel="apple-touch-icon-precomposed" sizes="152x152" href="{$url-prefix}/circle/apple-touch-icon-152x152-precomposed.png"/>
<link rel="apple-touch-icon-precomposed" sizes="120x120" href="{$url-prefix}/circle/apple-touch-icon-120x120-precomposed.png"/>
<link rel="apple-touch-icon-precomposed" sizes="76x76" href="{$url-prefix}/circle/apple-touch-icon-76x76-precomposed.png"/>
<link rel="apple-touch-icon-precomposed" sizes="60x60" href="{$url-prefix}/circle/apple-touch-icon-60x60-precomposed.png"/>
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="{$url-prefix}/circle/apple-touch-icon-144x144-precomposed.png"/>
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="{$url-prefix}/circle/apple-touch-icon-114x114-precomposed.png"/>
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="{$url-prefix}/circle/apple-touch-icon-72x72-precomposed.png"/>
<link rel="apple-touch-icon" sizes="57x57" href="{$url-prefix}/circle/apple-touch-icon.png"/>
-->

</xsl:stylesheet>
