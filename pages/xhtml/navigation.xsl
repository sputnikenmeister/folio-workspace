<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="navigation">
	<ul class="clear">
		<xsl:apply-templates select="page[not(types/type = 'hidden') and not(types/type = 'admin')]"/>
		<!--<li><a href="{$root}/rss/">Feed</a></li>-->
	</ul>
</xsl:template>

<xsl:template match="page">
	<li>
		<a href="{$root}/{@handle}/"><xsl:value-of select="name"/></a>
	</li>
</xsl:template>

<xsl:template match="page[@handle = /data/params/current-page/text()]">
	<li class="active">
		<a href="{$root}/{@handle}/"><xsl:value-of select="name"/></a>
	</li>
</xsl:template>

</xsl:stylesheet>