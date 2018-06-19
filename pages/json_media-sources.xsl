<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/output-json.xsl"/>

<xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />

<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates select="data/*" mode="output-json"/>
</xsl:template>

</xsl:stylesheet>
