<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:e="http://exslt.org/common"
	 extension-element-prefixes="e">

<xsl:import href="common-prepare-json.xsl"/>
<xsl:import href="common-output-json.xsl"/>

<xsl:strip-space elements="*"/>

<!-- 								-->
<!--  All data-sources entry-point	-->
<!-- 								-->
<xsl:template match="data" mode="output-json">
	<xsl:text>&#xa;&#9;</xsl:text>
	<xsl:apply-templates select="types-all | keywords-all | articles-all | media-all | bundles-all | params | properties-ga" mode="output-json"/>
	<xsl:text>&#xa;</xsl:text>
</xsl:template>

<!-- Two-pass transforms -->

<!-- 						-->
<!--  Generic data-source	-->
<!-- 						-->
<xsl:template match="*[entry]" mode="output-json">
	<xsl:if test="position() != 1">
		<xsl:text>&#xa;&#9;</xsl:text>
	</xsl:if>
	<xsl:text>'</xsl:text>
	<xsl:value-of select="name(.)"/>
	<xsl:text>': [</xsl:text>
	<xsl:apply-templates select="entry" mode="output-json"/>
	<xsl:text>&#xa;&#9;]</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!--  All types		-->
<!-- 				-->
<xsl:template match="types-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!-- All keywords 	-->
<!-- 				-->
<xsl:template match="keywords-all/entry" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<handle><xsl:value-of select="name/@handle"/></handle>
			<xsl:copy-of select="name"/>
			<tId><xsl:value-of select="type/item/@id"/></tId>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!-- All Articles 	-->
<!-- 				-->
<xsl:template match="articles-system/entry | articles-all/entry" mode="output-json">
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
			<xsl:copy-of select="text"/>
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
	<!-- chars: linefeed, tab, tab -->
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
			<xsl:copy-of select="completed | sub"/>
			<!-- <xsl:apply-templates mode="prepare-json" select="sub"/> -->
			<!-- <xsl:apply-templates select="keywords[/data/params/ds-keywords-all/item/@id = item/@id]" mode="prepare-json-ids"/> -->
			<xsl:apply-templates select="keywords" mode="prepare-json-ids"/>
			<xsl:apply-templates select="attributes | description" mode="prepare-json"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 				-->
<!-- All Media		-->
<!-- 				-->
<xsl:template match="media-all/entry" mode="output-json">
	<!-- chars: linefeed, tab, tab -->
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<id><xsl:value-of select="@id"/></id>
			<o><xsl:value-of select="order"/></o>
			<name mode="formatted">
				<xsl:copy-of select="name/*[1]/* | name/*[1]/text()"/>
			</name>
			<xsl:copy-of select="sub"/>
			<bId>
				<xsl:value-of select="bundle/item/@id"/>
			</bId>
			<srcIdx>
				<xsl:apply-templates mode="get-position" select="sources/item[contains(file/@type,'image')][1]"/>
			</srcIdx>
			<xsl:apply-templates mode="prepare-json" select="attributes | description | sources"/>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>
<xsl:template match="*" mode="get-position">
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

<!-- 						-->
<!--  Parameters			-->
<!-- 						-->
<xsl:template match="params" mode="output-json">
	<xsl:variable name="uploads">
		<params><uploads><xsl:value-of select="workspace"/>/uploads</uploads></params>
	</xsl:variable>
	<xsl:if test="position() != 1">
		<xsl:text>&#xa;&#9;</xsl:text>
	</xsl:if>
	<!-- <xsl:text>&#xa;&#9;&#9;</xsl:text> -->
	<xsl:text>'</xsl:text>
	<xsl:value-of select="name(.)"/>
	<xsl:text>': {</xsl:text>
	<!-- <xsl:text>': {&#xa;&#9;</xsl:text> -->
	<xsl:apply-templates select="website-name | root | workspace | e:node-set($uploads)/params/*" mode="output-json"/>
	<xsl:text>}</xsl:text>
	<!-- <xsl:text>&#xa;&#9;}</xsl:text> -->
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>


<!-- 						-->
<!--  GA tracking			-->
<!-- 						-->
<xsl:template match="properties-ga" mode="output-json">
	<xsl:if test="position() != 1">
		<xsl:text>&#xa;&#9;</xsl:text>
	</xsl:if>
	<xsl:text>'ga-tags': [</xsl:text>
	<!-- <xsl:text>'ga-tags': {&#xa;&#9;</xsl:text> -->
	<xsl:apply-templates select="tags/item" mode="output-json"/>
	<!-- <xsl:text>}</xsl:text> -->
	<xsl:text>&#xa;&#9;]</xsl:text>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="tags/item" mode="output-json">
	<xsl:text>&#xa;&#9;&#9;</xsl:text>
	<xsl:call-template name="output-json">
		<xsl:with-param name="xml">
			<xsl:element name="{domain/text()}">
				<xsl:copy-of select="id/text()"/>
			</xsl:element>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
