<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

<xsl:import href="json/output-short.xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
<xsl:strip-space elements="*"/>

<xsl:template match="/data">
	window.approot = '<xsl:value-of select="$root"/>/';
	window.mediadir = '<xsl:value-of select="$workspace"/>/uploads';
	window.bootstrap = {
	<xsl:apply-templates select="articles-all" mode="output-json"/>,
	<xsl:apply-templates select="types-all" mode="output-json"/>,
	<xsl:apply-templates select="keywords-all" mode="output-json"/>,
	<xsl:apply-templates select="bundles-all" mode="output-json"/>,
	<xsl:apply-templates select="media-all" mode="output-json"/>
	};
	<!-- window.bootstrap =
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<types-all>
				<xsl:copy-of select="types-all/entry[not(attributes)] | types-all/entry[attributes/item/@handle != 'private-private']"/>
			</types-all>
		</xsl:with-param>
	</xsl:call-template>; -->
	<!-- window.bootstrap = {<xsl:apply-templates select="types-all | keywords-all | articles-all | media-all | bundles-all" mode="filter"/>}; -->
</xsl:template>

<!-- <xsl:template match="*" mode="filter">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<xsl:element name="{name()}">
				<xsl:copy-of select="./entry[not(attributes)] | ./entry[attributes/item/@handle != 'private-private']"/>
			</xsl:element>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template> -->
<!-- <xsl:template match="*" mode="filter">
	<xsl:text>&#xa;&#9;'</xsl:text>
	<xsl:value-of select="name(.)" />
	<xsl:text>':[</xsl:text>
	<xsl:apply-templates select="./entry[not(attributes)] | ./entry[attributes/item/@handle != 'private-private']" mode="output-json"/>
	<xsl:text>]</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template> -->

	<!-- This works but indentation gets messed up -->
	<!--/data/articles-all/group[@handle = 'content']
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml" select="types-all | keywords-all | bundles-all | media-all"/>
	</xsl:call-template>
	-->

	<!-- Figure out what to do with errors!!! -->
	<!-- <xsl:apply-templates select="data/bundles-all/error"/> -->

</xsl:stylesheet>
