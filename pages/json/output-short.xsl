<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="common-prepare-json.xsl"/>
<xsl:import href="common-output-json.xsl"/>
<xsl:strip-space elements="*"/>

<!-- Two-pass transforms -->

<!-- 				-->
<!-- All Images 	-->
<!-- 				-->
<xsl:template match="images-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<bId><xsl:value-of select="bundle/item/@id"/></bId>
			<id><xsl:value-of select="@id"/></id>
			<o><xsl:value-of select="order"/></o>
			<src><xsl:copy-of select="file/filename/text()"/></src>
			<w><xsl:value-of select="file/meta/@width"/></w>
			<h><xsl:value-of select="file/meta/@height"/></h>
			<!-- <att><xsl:value -->
			<xsl:apply-templates select="attributes | description" mode="prepare-json"/>
			<xsl:apply-templates select="/data/images-sources/owner[@link-id = current()/@id]" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!-- Images Sources	-->
<!-- 				-->
<xsl:template match="images-sources/owner" mode="prepare-json">
	<xsl:variable name="item-list" select="entry"/>
	<srcset>
		<xsl:choose>
			<xsl:when test="$item-list">
				<xsl:copy-of select="$item-list"/>
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</srcset>
</xsl:template>
<xsl:template match="srcset/entry" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<src><xsl:copy-of select="file/filename/text()"/></src>
			<mime><xsl:value-of select="file/@type"/></mime>
			<xsl:apply-templates select="attributes" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!-- All bundles 	-->
<!-- 				-->
<xsl:template match="bundles-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:choose>
				<xsl:when test="display-name">
					<name mode="formatted">
						<xsl:copy-of select="display-name/*[1]/* | display-name/*[1]/text()"/>
					</name>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="name"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:copy-of select="completed"/>
			<xsl:apply-templates select="keywords" mode="prepare-json-ids"/>
			<xsl:apply-templates select="attributes | description" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!-- Keywords (IDs)	-->
<!-- 				-->
<xsl:template match="keywords" mode="prepare-json-ids">
	<kIds>
		<xsl:copy-of select="item"/>
	</kIds>
</xsl:template>
<xsl:template match="kIds/item" mode="output-json">
	<xsl:value-of select="@id" />
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!-- Images (IDs)	-->
<!-- 				-->
<xsl:template match="images-find-by-bundle | images" mode="prepare-json-ids">
	<xsl:variable name="images" select="entry | item"/>
	<iIds>
		<xsl:choose>
			<xsl:when test="$images">
				<xsl:copy-of select="$images"/>
				<!-- <xsl:apply-templates select="$images" mode="prepare-json"/> -->
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</iIds>
</xsl:template>
<xsl:template match="iIds/item" mode="output-json">
	<xsl:value-of select="@id" />
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
