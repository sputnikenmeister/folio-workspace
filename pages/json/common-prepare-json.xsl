<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:e="http://exslt.org/common"
	 xmlns:s="http://exslt.org/strings"
	 extension-element-prefixes="e s">

<xsl:strip-space elements="*"/>

<!-- Attributes -->
<xsl:template match="attributes" mode="prepare-json">
	<attrs>
		<xsl:choose>
			<xsl:when test="item">
				<!-- <item>
					<xsl:value-of select="s:replace(item/text(), ';', ',')"/>
				</item> -->
				<xsl:copy-of select="item"/>
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</attrs>
</xsl:template>

<!-- Description -->
<xsl:template match="description" mode="prepare-json">
	<desc mode="formatted">
		<xsl:copy-of select="*"/>
	</desc>
</xsl:template>


</xsl:stylesheet>
