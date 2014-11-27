<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="xml/helpers.xsl" />
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="$filter = 'count'">
			<count>
				<xsl:value-of select="data/types-find/pagination/@total-entries" />
			</count>
		</xsl:when>
		<xsl:when test="($filter = 'items') and ($types = '')">
			<data />
		</xsl:when>
		<xsl:otherwise>
			<data>
				<xsl:apply-templates select="data/types-find/entry" />
			</data>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
