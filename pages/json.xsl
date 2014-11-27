<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="json/output-short.xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:text>&#xa;window.bootstrap = {</xsl:text>
	<xsl:text>&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/types-all" mode="output-json"/>
	<xsl:text>,&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/keywords-all" mode="output-json"/>
	<xsl:text>,&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/bundles-all" mode="output-json"/>
	<xsl:text>,&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="/data/images-all" mode="output-json"/>
	<xsl:text>&#xa;};</xsl:text>
	<!-- <xsl:apply-templates select="data/bundles-all/error"/> -->
</xsl:template>

</xsl:stylesheet>
