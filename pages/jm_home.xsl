<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="jm/bundle-item.xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" encoding="UTF-8" />

<xsl:template match="/">
<div id="content" class="index scrollable">
	<div id="projects">
		<xsl:apply-templates select="//bundles-by-id/entry"/>
		<xsl:apply-templates select="//bundles-by-id/error"/>
	</div>
</div>
</xsl:template>

</xsl:stylesheet>