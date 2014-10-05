<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:exsl="http://exslt.org/common"
		extension-element-prefixes="exsl">
		
<xsl:import href="../../utilities/typography.xsl"/>
<xsl:import href="../../utilities/output-json.xsl"/>
<xsl:import href="../../utilities/xml-to-json.xsl"/>
<xsl:strip-space elements="*"/>

<xsl:template match="item | entry" mode="output-json">
	<xsl:text>{</xsl:text>
	<xsl:apply-templates mode="output-json"/>
	<xsl:text>}</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="*[count(item|entry) &gt; 0]" mode="output-json">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="name(.)" /> 
	<xsl:text>":[</xsl:text>
	<xsl:apply-templates select="item|entry" mode="output-json"/>
	<xsl:text>]</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="*[@mode='formatted']" mode="output-json">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="name(.)" /> 
	<xsl:text>":"</xsl:text>
	<xsl:apply-templates select="node()|text()" mode="html"/>
	<xsl:text>"</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- Escape Quotes -->
<xsl:template match="text()" mode="html">
	<xsl:call-template name="escape-bs-string"><!-- from xml-to-json.xsl -->
		<xsl:with-param name="s" select="."/>
	</xsl:call-template>
<!--	<xsl:call-template name="string-replace">
		<xsl:with-param name="haystack" select="." />
		<xsl:with-param name="search" select="'&#34;'" />
		<xsl:with-param name="replace" select="'&#92;&#34;'" />
	</xsl:call-template>-->
</xsl:template>

<xsl:template match="completed/text()" mode="output-json">
	<xsl:value-of select="substring(current(),1,4)"/>
</xsl:template>

<xsl:template match="section" mode="output-json"/>

<xsl:template match="attributes/item" mode="output-json">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="text()" /> 
	<xsl:text>"</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="keywords/item" mode="output-json">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="name/@handle" /> 
	<xsl:text>"</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="all-bundles/entry" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="name/@handle"/></id>
			<xsl:copy-of select="name | completed | keywords"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="all-keywords/entry" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="name/@handle"/></id>
			<type><xsl:value-of select="type/item/name/@handle"/></type>
			<xsl:copy-of select="name"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!--<xsl:template match="type" mode="output-json">
	<xsl:text>"type":"</xsl:text>
	<xsl:value-of select="item/name/@handle" /> 
	<xsl:text>"</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>-->

<xsl:template match="all-types/entry" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="name/@handle"/></id>
			<xsl:copy-of select="name"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
