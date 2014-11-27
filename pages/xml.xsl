<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="xml/helpers.xsl" />
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<data>
		<xsl:apply-templates select="data/types-find/entry" />
		<xsl:apply-templates select="data/keywords-find/entry" />
		<xsl:apply-templates select="data/bundles-find/entry" />
	</data>
</xsl:template>

</xsl:stylesheet>
