<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="json/output-long.xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	{ msg: "unused page "}
</xsl:template>


<!--
<xsl:template match="all-images/entry" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<uid><xsl:value-of select="uid/@handle"/></uid>
			<file><xsl:copy-of select="file/filename/text()"/></file>
			<width><xsl:value-of select="file/meta/@width"/></width>
			<height><xsl:value-of select="file/meta/@height"/></height>
			<xsl:copy-of select="description"/>
			<xsl:copy-of select="attributes"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>
-->

</xsl:stylesheet>
