<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

<xsl:import href="../../utilities/typography.xsl"/>
<xsl:import href="../../utilities/output-json.xsl"/>
<xsl:import href="../../utilities/escape-string.xsl"/>

<xsl:strip-space elements="*"/>

<!-- Generic HTML text -->
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
		<xsl:call-template name="escape-bs-string"><!-- from escape-string.xsl -->
			<xsl:with-param name="s" select="."/>
		</xsl:call-template>
	</xsl:template>

<!-- Ignored -->
<xsl:template match="section" mode="output-json"/>

<!-- Named properties -->
<xsl:template match="completed/text()" mode="output-json">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="substring(current(),1,10)"/>
	<xsl:text>"</xsl:text>
</xsl:template>


<!-- Generic text-only array (e.g. atrributes) -->
<xsl:template match="item[count(text()) = count(node())]" mode="output-json">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="text()" />
	<xsl:text>"</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- Generic array -->
<xsl:template match="*[count(item|entry|empty) &gt; 0]" mode="output-json">
	<xsl:text>"</xsl:text>
	<xsl:value-of select="name(.)" />
	<xsl:text>":[</xsl:text>
	<xsl:apply-templates select="item|entry" mode="output-json"/>
	<xsl:text>]</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- All Articles 	-->
<xsl:template match="articles-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<!-- <xsl:apply-templates select="text" mode="prepare-json"/> -->
			<!-- <text><xsl:value-of select="text"/></text> -->
			<xsl:copy-of select="name | text"/>
			<!-- <name mode="formatted">
				<xsl:copy-of select="text/*"/>
			</name> -->
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!--  All types -->
<xsl:template match="types-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- All keywords -->
<xsl:template match="keywords-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name"/>
			<tId><xsl:value-of select="type/item/@id"/></tId>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>
