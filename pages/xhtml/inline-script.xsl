<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

<xsl:strip-space elements="*"/>

<!-- JavaScript CDATA script wrapper -->
<xsl:template name="inline-script">
	<xsl:param name="id"/>
	<xsl:param name="type" select="'text/javascript'"/>
	<!-- <xsl:param name="class"/> -->
	<xsl:param name="content" />
	<xsl:element name="script">
		<xsl:if test="$id">
			<xsl:attribute name="id">
				<xsl:value-of select="$id"/>
			</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="type">
			<xsl:value-of select="$type"/>
		</xsl:attribute>
		<!-- <xsl:if test="$class">
			<xsl:attribute name="class">
				<xsl:value-of select="$class"/>
			</xsl:attribute>
		</xsl:if> -->
		<!-- newline: &#xa;, fwd slash: &#47; tab: &#9;-->
		<!-- <xsl:text disable-output-escaping="yes">&#xa;&#47;&#47;&lt;![CDATA[&#xa;</xsl:text> -->
		<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
		<xsl:copy-of select="exsl:node-set($content)"/>
		<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
		<!-- <xsl:text disable-output-escaping="yes">&#xa;&#47;&#47;]]&gt;</xsl:text> -->
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
