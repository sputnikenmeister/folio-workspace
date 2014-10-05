<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- TEMPORARY -->

<xsl:template match="data" mode="json-old">
	<xsl:text>
	"bundle-to-keywords":{</xsl:text>
	<xsl:for-each select="all-bundles/entry">
		<xsl:apply-templates select="name" mode="json-old"/>
		<xsl:text>:</xsl:text>
		<xsl:apply-templates select="keywords" mode="json-old"/>
		<xsl:if test="position() != last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:for-each>
	<xsl:text>},
	"keyword-to-type":{</xsl:text>
	<xsl:for-each select="all-keywords/entry">
		<xsl:apply-templates select="name" mode="json-old"/>
		<xsl:text>:</xsl:text>
		<xsl:apply-templates select="type/item/name" mode="json-old"/>
		<xsl:if test="position() != last()">
			<xsl:text>,</xsl:text>
		</xsl:if>
	</xsl:for-each>
	<xsl:text>}
	</xsl:text>
</xsl:template>

<xsl:template match="*[count(item|entry) &gt; 0]" mode="json-old">
	<xsl:text>[</xsl:text>
	<xsl:for-each select="item|entry">
		<xsl:if test="position() &gt; 1">
			<xsl:text>,</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="name" mode="json-old"/>
	</xsl:for-each>
	<xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="name" mode="json-old">
	<xsl:text>"</xsl:text>
		<xsl:value-of select="@handle" />
	<xsl:text>"</xsl:text>
</xsl:template>

</xsl:stylesheet>