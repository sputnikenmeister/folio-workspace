<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../../utilities/typography.xsl"/>
<xsl:import href="../../utilities/date-time-extended.xsl"/>

<xsl:template match="bundles-by-id/error">
	<div class="entry">
		<h4>No articles found.</h4>
	</div>
</xsl:template>

<xsl:template match="bundles-by-id/entry">
	<a id="item-{@id}" class="project int"
		data-href="/project/{name/@handle}"
		href="/project/{name/@handle}.html"
		data-slug="{name/@handle}"
		data-key="{@id}"
		data-pos="{position()}">
		<h6><xsl:value-of select="position()" /></h6>		
		<h4><xsl:value-of select="name/text()" /></h4>
		<h5 class="meta pubDate">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="completed"/>
				<xsl:with-param name="format" select="'%m+;, %y+;'"/>
			</xsl:call-template>
		</h5>
		<xsl:apply-templates select="images/item[published/text() = 'Yes'][position() = 1]"/>
		<!--<xsl:apply-templates select="description/*" mode="html"/>-->
		<p>
			<xsl:apply-templates select="keywords/item[published/text() = 'Yes']"/>
		</p>
	</a>
</xsl:template>

<xsl:template match="keywords/item">
	<xsl:value-of select="name/text()"/>
	<xsl:if test="position() != last()">
		<br/>
		<!--<xsl:text>, </xsl:text>-->
	</xsl:if>
</xsl:template>


<xsl:template match="images/item">
	<xsl:variable name="w" select="177" />
	<xsl:variable name="h" select="floor(($w div file/meta/@width) * file/meta/@height)" />
	<div>
		<img width="{$w}" height="{$h}"/>
	</div>
	<span class="name"><xsl:value-of select="concat($root, '/image/1/', $w, '/0', file/@path, '/', file/filename, ',')"/></span>
</xsl:template>

</xsl:stylesheet>