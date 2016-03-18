<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="json/output-short.xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
<xsl:strip-space elements="*"/>

<xsl:template match="/data">
	window.approot = "<xsl:value-of select="$root"/>/";
	window.mediadir = "<xsl:value-of select="$workspace"/>/uploads";
	window.bootstrap = {
	<xsl:apply-templates select="types-all" mode="output-json"/>,
	<xsl:apply-templates select="keywords-all" mode="output-json"/>,
	<xsl:apply-templates select="bundles-all" mode="output-json"/>,
	<xsl:apply-templates select="media-all" mode="output-json"/>
	};
</xsl:template>

	<!-- This works but indentation gets messed up -->
	<!--
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml" select="types-all | keywords-all | bundles-all | media-all"/>
	</xsl:call-template>
	-->

	<!-- Figure out what to do with errors!!! -->
	<!-- <xsl:apply-templates select="data/bundles-all/error"/> -->

</xsl:stylesheet>
