<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="favicon">
	<xsl:param name="url-prefix" select="concat($workspace, '/assets/images/favicons')"/>
	<xsl:param name="bg-color" select="'#000000'"/>
	<meta name="msapplication-square70x70logo" content="{$url-prefix}/square/windows-tile-70x70.png"/>
	<meta name="msapplication-square150x150logo" content="{$url-prefix}/square/windows-tile-150x150.png"/>
	<meta name="msapplication-square310x310logo" content="{$url-prefix}/square/windows-tile-310x310.png"/>
	<meta name="msapplication-TileImage" content="{$url-prefix}/square/windows-tile-144x144.png"/>
	<meta name="msapplication-TileColor" content="{$bg-color}"/>
	<link rel="apple-touch-icon-precomposed" sizes="152x152" href="{$url-prefix}/square/apple-touch-icon-152x152-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="120x120" href="{$url-prefix}/square/apple-touch-icon-120x120-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="76x76" href="{$url-prefix}/square/apple-touch-icon-76x76-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="60x60" href="{$url-prefix}/square/apple-touch-icon-60x60-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="{$url-prefix}/square/apple-touch-icon-144x144-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="{$url-prefix}/square/apple-touch-icon-114x114-precomposed.png"/>
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="{$url-prefix}/square/apple-touch-icon-72x72-precomposed.png"/>
	<link rel="apple-touch-icon" sizes="57x57" href="{$url-prefix}/square/apple-touch-icon.png"/>
	<link rel="shortcut icon" href="{$url-prefix}/circle/favicon.ico"/>
	<link rel="icon" type="image/png" sizes="64x64" href="{$url-prefix}/circle/favicon.png"/>
</xsl:template>

</xsl:stylesheet>
