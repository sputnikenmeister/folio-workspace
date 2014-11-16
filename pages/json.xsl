<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="json/output-short.xsl"/>
<xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:text>&#xa;var bootstrap = {</xsl:text>
	<xsl:text>&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/all-types" mode="output-json"/>
	<xsl:text>,&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/all-keywords" mode="output-json"/>
	<xsl:text>,&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/all-bundles" mode="output-json"/>
	<xsl:text>,&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/all-images" mode="output-json"/>
	<xsl:text>&#xa;};</xsl:text>
	<!-- <xsl:apply-templates select="data/all-bundles/error"/> -->
</xsl:template>

</xsl:stylesheet>
