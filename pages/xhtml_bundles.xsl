<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://exslt.org/math"
	extension-element-prefixes="math">

<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="../utilities/typography.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<xsl:strip-space elements="*"/>

<xsl:template match="data">
<div id="navigation">
	<xsl:apply-templates select="all-types"/>
	<xsl:apply-templates select="all-bundles"/>
</div>
<div id="main">
	<xsl:apply-templates select="bundles-by-handle/entry[1]"/>
	<xsl:apply-templates select="bundles-by-handle/error"/>
</div>
</xsl:template>

<xsl:template match="all-bundles">
	<xsl:variable name="current-bundle" select="entry[@id = $ds-bundles-by-handle.system-id]"/>
	<xsl:variable name="preceding-bundle" select="$current-bundle/preceding-sibling::entry[1]"/>
	<xsl:variable name="following-bundle" select="$current-bundle/following-sibling::entry[1]"/>
	
	<div id="bundles">
		<h2 class="bundle-name"><xsl:value-of select="$current-bundle/name/text()" /></h2>
	</div>
	<div id="bd-nav" class="text-nav">
		<xsl:if test="$preceding-bundle">
		<a id="preceding-bundle" class="preceding-button button" href="{$parent-path}/{$current-page}/{$preceding-bundle/name/@handle}/">
			<xsl:copy-of select="$preceding-bundle/name/text()"/>
		</a>
		</xsl:if>
		<xsl:if test="$following-bundle">
		<a id="following-bundle" class="following-button button" href="{$parent-path}/{$current-page}/{$following-bundle/name/@handle}/">
			<xsl:copy-of select="$following-bundle/name/text()"/>
		</a>
		</xsl:if>
		<a id="close-bundle" class="close-button button" href="{$parent-path}/">
			<xsl:text>Close</xsl:text>
		</a>
	</div>
</xsl:template>

<xsl:template match="bundles-by-handle/entry">
	<div id="bd-detail">
		<h2 class="bundle-name"><xsl:value-of select="name/text()" /></h2>
		<div class="completed meta pubDate" data-datetime="{completed/text()}">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="completed"/>
				<xsl:with-param name="format" select="'%y+;'"/>
			</xsl:call-template>
		</div>
		<div class="description">
			<xsl:apply-templates select="description/*" mode="html"/>
		</div>
	</div>
	<xsl:apply-templates select="images" />
</xsl:template>

<xsl:template match="bundles-by-handle/error">
	<div class="bd-detail">
		<h3>No bundle found.</h3>
	</div>
</xsl:template>

<xsl:variable name="img-width" select="700" />
<!--<xsl:variable name="img-width" select="480" />-->
<!--<xsl:variable name="img-height" select="320" />-->

<xsl:template match="images[item/published/text() = 'Yes']">
	<xsl:variable name="image-items" select="item"/>
	<xsl:variable name="max-height" select="round(($img-width div math:max(item/file/meta/@width)) * math:max(item/file/meta/@height))" />
	<div id="bd-images" class="pageable" style="width: {$img-width}px; height: {$max-height}px;">
		<ul>
			<xsl:apply-templates select="$image-items"/>
		</ul>
		<xsl:if test="count($image-items) &gt; 1">
			<div class="pageable-ctls">
				<a id="preceding-image" class="preceding-button button" href="#"><!--&#x25C0;--></a>
				<a id="following-image" class="following-button button" href="#"><!--&#x25B6;--></a>
			</div>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="images/item">
	<li>
		<xsl:if test="position() &gt; 1">
			<xsl:attribute name="style">
				<xsl:copy-of select="'display: none'"/>
			</xsl:attribute>
		</xsl:if>
		<img width="{$img-width}" height="{floor(($img-width div file/meta/@width) * file/meta/@height)}" title="{description}" alt="{description}" src="{$root}/image/1/{$img-width}/0{file/@path}/{file/filename}"/>
		<!-- Without JIT recipe:	src="{$root}/image/1/{$img-width}/0{file/@path}/{file/filename}" -->
		<!-- With JIT recipe:		src="{$root}/image/bundle{file/@path}/{file/filename}"	-->
		<div class="caption">
			<xsl:apply-templates select="description/*" mode="html"/>
		</div>
	</li>
</xsl:template>

<xsl:template match="all-types">
	<dl id="keywords" class="mapped has-highlight">
		<xsl:apply-templates select="entry"/>
	</dl>
</xsl:template>

<xsl:template match="all-types/entry">
	<xsl:variable name="current-keywords" select="//all-keywords/entry[type/item/@id = current()/@id]"/>
	<dt id="{name/@handle}">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="//ds-bundles-by-handle.keywords/item[@handle = $current-keywords/@id]">
					<xsl:copy-of select="'group highlight'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="'group'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:value-of select="name/text()"/>
	</dt>
	<xsl:apply-templates select="$current-keywords"/>
</xsl:template>

<xsl:template match="all-keywords/entry">
	<dd id="{name/@handle}">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="//ds-bundles-by-handle.keywords/item[@handle = current()/@id]">
					<xsl:copy-of select="'item highlight'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="'item'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<a href="#{name/@handle}" data-href="{$root}/xhtml/keywords/{name/@handle}">
			<xsl:value-of select="name/text()"/>
		</a>
	</dd>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
	<xsl:text> &#8212; </xsl:text>
	<xsl:value-of select="//all-bundles/entry[@id = $ds-bundles-by-handle.system-id]/name/text()"/>
</xsl:template>

</xsl:stylesheet>