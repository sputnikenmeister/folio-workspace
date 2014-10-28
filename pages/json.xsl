<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="json/short.xsl"/>

<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates select="/data/all-types" mode="output-json"/>
	<xsl:text>,&#xa;</xsl:text>
	<xsl:apply-templates select="/data/all-keywords" mode="output-json"/>
	<xsl:text>,&#xa;</xsl:text>
	<xsl:apply-templates select="/data/all-bundles" mode="output-json"/>
	<!--<xsl:apply-templates select="data/all-bundles/error"/>-->
</xsl:template>

</xsl:stylesheet>
