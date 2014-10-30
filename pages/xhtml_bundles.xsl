<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:math="http://exslt.org/math"
	 extension-element-prefixes="math">

<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="../utilities/typography.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<!-- <xsl:strip-space elements="*"/> -->

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
	<xsl:text> &#8212; </xsl:text>
	<xsl:value-of select="/data/bundles-by-handle/entry[1]/name/text()"/>
</xsl:template>

<xsl:template match="data">
<div id="navigation">
	<xsl:apply-templates select="all-types"/>
	<xsl:apply-templates select="bundles-by-handle/entry[1]" mode="navigation"/>
</div>
<div id="content">
	<xsl:apply-templates select="bundles-by-handle/entry[1]" mode="content"/>
	<xsl:apply-templates select="bundles-by-handle/error"/>
</div>
</xsl:template>

<!--
  ** Bundle
  -->
<xsl:template match="bundles-by-handle/entry" mode="navigation">
	<!-- bundle pager -->
	<xsl:variable name="current-bundle" select="/data/all-bundles/entry[@id = current()/@id]"/>
	<xsl:variable name="preceding-bundle" select="$current-bundle/preceding-sibling::entry[1]"/>
	<xsl:variable name="following-bundle" select="$current-bundle/following-sibling::entry[1]"/>
	<div id="bundle-pager" class="text-pager">
		<xsl:if test="$preceding-bundle">
		<a id="preceding-bundle" class="preceding-button button" href="/{$current-page}/{$preceding-bundle/name/@handle}">
			<xsl:copy-of select="$preceding-bundle/name/text()"/>
		</a>
		</xsl:if>
		<xsl:if test="$following-bundle">
		<a id="following-bundle" class="following-button button" href="/{$current-page}/{$following-bundle/name/@handle}">
			<xsl:copy-of select="$following-bundle/name/text()"/>
		</a>
		</xsl:if>
		<a id="close-bundle" class="close-button button" href="/">
			<xsl:text>Close</xsl:text>
		</a>
	</div>
	<!-- bundle detail -->
	<div id="bundle-detail">
		<h2 class="name"><xsl:value-of select="name/text()" /></h2>
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
</xsl:template>

<xsl:template match="bundles-by-handle/entry" mode="content">
	<xsl:apply-templates select="images" />
</xsl:template>

<xsl:template match="bundles-by-handle/error">
	<div class="bundle-detail">
		<h2>Here be dragons, ye be warned</h2>
		<p>Ok, I maybe made a mistake on my website.</p>
	</div>
</xsl:template>

<!--
  ** Images
  -->
<xsl:variable name="img-width" select="700" />

<xsl:template match="images[item/published/text() = 'Yes']">
	<xsl:variable name="image-items" select="item"/>
	<xsl:variable name="max-height" select="round(($img-width div math:max(item/file/meta/@width)) * math:max(item/file/meta/@height))" />
	<!-- Image Pager -->
	<xsl:if test="count($image-items) &gt; 1">
	<div id="bundle-images-pager" class="rsquare-pager">
		<a id="preceding-image" class="preceding-button button" href="#"><!--&#x25C0;--></a>
		<a id="following-image" class="following-button button" href="#"><!--&#x25B6;--></a>
	</div>
	</xsl:if>
	<!-- Image List -->
	<ul id="bundle-images" class="image-list" style="width: {$img-width}px; height: {$max-height}px;">
		<xsl:apply-templates select="$image-items"/>
	</ul>
</xsl:template>

<xsl:template match="images/item">
	<li id="i{@id}" class="image-item">
		<xsl:if test="position() &gt; 1">
			<xsl:attribute name="style">
				<xsl:copy-of select="'display: none'"/>
			</xsl:attribute>
		</xsl:if>
		<img width="{$img-width}"
			 height="{floor(($img-width div file/meta/@width) * file/meta/@height)}"
			 title="{file/filename}" alt="{file/filename}"
			 src="{$root}/image/1/{$img-width}/0{file/@path}/{file/filename}"/>
		<!-- Without JIT recipe:	src="{$root}/image/1/{$img-width}/0{file/@path}/{file/filename}" -->
		<!-- With JIT recipe:		src="{$root}/image/bundle{file/@path}/{file/filename}"	-->
		<div class="caption">
			<xsl:apply-templates select="description/*" mode="html"/>
		</div>
	</li>
</xsl:template>

<!--
  ** Types/Keywords
  -->
<xsl:variable name="bundle-keywords" select="//ds-bundles-by-handle.keywords" />

<xsl:template match="all-types">
	<dl id="keyword-list" class="selectable-list">
		<xsl:apply-templates select="entry"/>
	</dl>
</xsl:template>

<xsl:template match="all-types/entry">
	<xsl:variable name="current-type-keywords" select="/data/all-keywords/entry[type/item/@id = current()/@id]"/>
	<dt id="t{@id}">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$bundle-keywords/item[@handle = $current-type-keywords/@id]">
					<xsl:copy-of select="'group'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="'group excluded'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:value-of select="name/text()"/>
	</dt>
	<xsl:apply-templates select="$current-type-keywords"/>
</xsl:template>

<xsl:template match="all-keywords/entry">
	<dd id="k{@id}">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$bundle-keywords/item[@handle = current()/@id]">
					<xsl:copy-of select="'item'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="'item excluded'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<a href="{$root}/keywords/{name/@handle}">
			<xsl:value-of select="name/text()"/>
		</a>
	</dd>
</xsl:template>

</xsl:stylesheet>
