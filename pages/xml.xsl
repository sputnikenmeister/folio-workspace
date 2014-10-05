<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="xml/helpers.xsl" />

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:template match="/">
	<data>
		<xsl:apply-templates select="//types-by-id/entry" />
		<xsl:apply-templates select="//keywords-by-id/entry" />
		<xsl:apply-templates select="//bundles-by-id/entry" />
	</data>
</xsl:template>

</xsl:stylesheet>