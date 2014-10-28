<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">

<xsl:import href="escape-string.xsl" />
<xsl:strip-space elements="*"/>

<!--
A complete XML to JSON transformation utility adapted from
Doeke Zanstra's xml2json utility (http://code.google.com/p/xml2json-xslt/)

This version:

- resorbs* repetitive elements:
	<days>
		<day>Monday</day>
		<day>Tuesday</day>
		<day>Wendsday</day>
	</days>
	====> {days: ["Monday", "Tuesday", "Wendsday"] }

	*Nota bene: If only 1 element exists, it will be output as-is
	<days>
		<day>Monday</day>
	</days>
	====> {days: {day: "Monday"} }

- empty text nodes are transformed to empty strings
	<days>
		<day></day>
		<day>Monday</day>
	</days>
	====> {days: ["", "Monday"] }

- numbers are output as integers
- nodes with text equal to "null" are transformed to items with value set to Javascript `null`
	<days>
		null
	</days>
	====> {days: null }
-->

<!--
Example call

<xsl:call-template name="xml-to-json">
	<xsl:with-param name="xml">
		[Any XML or XSLT transformation]
	</xsl:with-param>
</xsl:call-template>
-->
<xsl:template name="xml-to-json">
	<xsl:param name="xml"/>
	<xsl:apply-templates select="exsl:node-set($xml)" mode="xml-to-json"/>
</xsl:template>

<!-- string -->
<xsl:template match="text()" mode="xml-to-json" >
	<xsl:choose>
		<xsl:when test=". = 'null'">null</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="escape-string">
				<xsl:with-param name="s" select="."/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- number (no support for javascript mantise) -->
<xsl:template match="text()[not(string(number())='NaN')]" mode="xml-to-json" >
	<xsl:value-of select="."/>
</xsl:template>

<!-- boolean, case-insensitive -->
<xsl:template match="text()[translate(.,'TRUE','true')='true']" mode="xml-to-json" >true</xsl:template>
<xsl:template match="text()[translate(.,'FALSE','false')='false']" mode="xml-to-json" >false</xsl:template>

<!-- object -->
<xsl:template name="object" match="*" mode="xml-to-json" >
	<xsl:if test="not(preceding-sibling::*)">{</xsl:if>
	<xsl:call-template name="escape-string">
		<xsl:with-param name="s" select="name()"/>
	</xsl:call-template>
	<xsl:text>:</xsl:text>
	<xsl:if test="count(child::node())=0">""</xsl:if>
	<xsl:apply-templates select="child::node()" mode="xml-to-json"/>
	<xsl:if test="following-sibling::*">,</xsl:if>
	<xsl:if test="not(following-sibling::*)">}</xsl:if>
</xsl:template>

<!-- array -->
<xsl:template name="array" match="*[count(../*[name(../*)=name(.)])=count(../*) and count(../*)&gt;1]" mode="xml-to-json" >
	<xsl:if test="not(preceding-sibling::*)">[</xsl:if>
	<xsl:choose>
		<xsl:when test="not(child::node())">
			<xsl:text>null</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="child::node()" mode="xml-to-json"/>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="following-sibling::*">,</xsl:if>
	<xsl:if test="not(following-sibling::*)">]</xsl:if>
</xsl:template>

</xsl:stylesheet>
