<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:e="http://exslt.org/common"
	extension-element-prefixes="e">

<!-- <xsl:import href="escape-string.xsl" /> -->
<xsl:import href="escape-string-exslt.xsl" />
<!-- <xsl:import href="string-replace.xsl" /> -->
<!-- <xsl:strip-space elements="*"/> -->

<!--
Example call:
<xsl:call-template name="output-json">
	<xsl:with-param name="xml">
		[Any XSLT-transformation]
	</xsl:with-param>
</xsl:call-template>
-->

<xsl:template name="output-json">
	<xsl:param name="xml" />
	<xsl:text>{</xsl:text>
	<xsl:apply-templates select="e:node-set($xml)" mode="output-json"/>
	<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="*" mode="output-json">
	<xsl:variable name="has-siblings" select="name(.) = name(preceding-sibling::*) or name(.) = name(following-sibling::*)" />
	<xsl:variable name="has-children" select="child::*" />
	<xsl:variable name="is-node" select="$has-siblings and position() = 1 or not($has-siblings)" />

	<!-- Name -->
	<xsl:if test="$is-node">'<xsl:value-of select="name(.)" />':</xsl:if>
	<!-- Array -->
	<xsl:if test="$has-siblings and position() = 1">
		<xsl:text>[</xsl:text>
	</xsl:if>
	<!-- Object -->
	<xsl:if test="$has-children">
		<xsl:text>{</xsl:text>
	</xsl:if>

	<!-- Recursion -->
	<xsl:apply-templates select="* | text()" mode="output-json"/>

	<!-- Empty Element -->
	<xsl:if test=". = ''">null</xsl:if>
	<!-- /Object -->
	<xsl:if test="$has-children">
		<xsl:text>}</xsl:text>
	</xsl:if>
	<!-- /Array -->
	<xsl:if test="$has-siblings and position() = last()">
		<xsl:text>]</xsl:text>
	</xsl:if>
	<!-- Separator -->
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="text()" mode="output-json">
	<xsl:variable name="is-string" select="string(number(.)) = 'NaN' and . != 'true' and . != 'false'" />

	<xsl:if test="$is-string">'</xsl:if>
	<!-- <xsl:call-template name="escape-bs-string"> -->
		<!-- <xsl:with-param name="s"> -->
			<xsl:call-template name="escape-bs-string">
				<xsl:with-param name="s" select="."/>
			</xsl:call-template>
		<!-- </xsl:with-param> -->
	<!-- </xsl:call-template> -->
	<xsl:if test="$is-string">'</xsl:if>
</xsl:template>

</xsl:stylesheet>
