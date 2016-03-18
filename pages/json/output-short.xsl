<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="common-prepare-json.xsl"/>
<xsl:import href="common-output-json.xsl"/>
<xsl:strip-space elements="*"/>

<!-- Two-pass transforms -->

<!-- 				-->
<!-- All Media 	-->
<!-- 				-->
<xsl:template match="media-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<bId><xsl:value-of select="bundle/item/@id"/></bId>
			<id><xsl:value-of select="@id"/></id>
			<o><xsl:value-of select="order"/></o>
			<name mode="formatted">
				<xsl:copy-of select="description/*[1]/* | description/*[1]/text()"/>
			</name>
			<!-- <xsl:apply-templates mode="prepare-json" select="description"/> -->
			
			<xsl:apply-templates mode="prepare-json" select="attributes"/>
			<xsl:apply-templates mode="prepare-json" select="sources"/>
			<!-- <xsl:apply-templates select="/data/media-sources/owner[@link-id = current()/@id]" mode="prepare-json"/> -->
			
			<srcIdx><xsl:apply-templates mode="get-position" select="sources/item[contains(file/@type,'image')][1]"/></srcIdx>
			
			<!-- <srcIdx><xsl:value-of select="position(sources/item[contains(file/@type,'image')][1])"/></srcIdx> -->
			<!-- <xsl:call-template name="get-position">
				<xsl:with-param name="e" select="sources/item[contains(file/@type,'image')][1]"/>
			</xsl:call-template> -->
			<!-- <srcIdx><xsl:number value="sources/item[contains(file/@type,'image')][1][position()]"/></srcIdx> -->
			<!-- <xsl:variable name="default-image" select="sources/item[contains(file/@type,'image')][1]"/>
			<xsl:choose>
				<xsl:when test="$default-image">
					<src><xsl:copy-of select="$default-image/file/filename/text()"/></src>
					<w><xsl:value-of select="$default-image/file/meta/@width"/></w>
					<h><xsl:value-of select="$default-image/file/meta/@height"/></h>
				</xsl:when>
				<xsl:otherwise>
					<src><xsl:copy-of select="file/filename/text()"/></src>
					<w><xsl:value-of select="file/meta/@width"/></w>
					<h><xsl:value-of select="file/meta/@height"/></h>
				</xsl:otherwise>
			</xsl:choose> -->
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>
<xsl:template match="*/item" mode="get-position">
	<xsl:value-of select="position() - 1"/>
</xsl:template>

<!-- 				-->
<!-- Media Sources	-->
<!-- 				-->
<xsl:template match="sources | media-sources/owner" mode="prepare-json">
	<xsl:variable name="item-list" select="entry | item"/>
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
<xsl:template match="srcset/entry | srcset/item" mode="output-json">
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<src><xsl:copy-of select="file/filename/text()"/></src>
			<mime><xsl:value-of select="file/@type"/></mime>
			<!-- <w><xsl:value-of select="file/meta/@width"/></w> -->
			<!-- <h><xsl:value-of select="file/meta/@height"/></h> -->
			<xsl:apply-templates select="file/meta/@width | file/meta/@height" mode="prepare-json"/>
			<xsl:apply-templates select="attributes" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>
<xsl:template match="meta/@width" mode="prepare-json">
	<w><xsl:value-of select="."/></w>
</xsl:template>
<xsl:template match="meta/@height" mode="prepare-json">
	<h><xsl:value-of select="."/></h>
</xsl:template>

<!-- <xsl:template match="file/meta/@height" mode="prepare-json">
<xsl:template match="file/meta/@width | file/meta/@height" mode="prepare-json">
	<xsl:element name="{name()}">
		<xsl:value-of select="."/>
	</xsl:element>
</xsl:template> -->

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
<!-- Media (IDs)	-->
<!-- 				-->
<xsl:template match="media-find-by-bundle | media" mode="prepare-json-ids">
	<xsl:variable name="media" select="entry | item"/>
	<mIds>
		<xsl:choose>
			<xsl:when test="$media">
				<xsl:copy-of select="$media"/>
				<!-- <xsl:apply-templates select="$media" mode="prepare-json"/> -->
			</xsl:when>
			<xsl:otherwise>
				<empty/>
			</xsl:otherwise>
		</xsl:choose>
	</mIds>
</xsl:template>
<xsl:template match="iIds/item" mode="output-json">
	<xsl:value-of select="@id" />
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
