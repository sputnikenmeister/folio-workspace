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
	<xsl:value-of select="/data/bundles-get/entry[1]/name/text()"/>
</xsl:template>

<xsl:template match="data">
<div id="navigation">
	<xsl:apply-templates select="bundles-get/entry[1]" mode="navigation"/>
	<xsl:apply-templates select="types-all"/>
</div>
<div id="content">
	<xsl:apply-templates select="bundles-get/entry[1]" mode="content"/>
	<xsl:apply-templates select="bundles-get/error"/>
</div>
</xsl:template>

<!--
  ~~ Bundle
  -->
<xsl:template match="bundles-get/entry" mode="navigation">
	<!-- bundle pager -->
	<xsl:variable name="current-bundle" select="/data/bundles-all/entry[@id = current()/@id]"/>
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

<xsl:template match="bundles-get/error">
	<div class="bundle-detail">
		<h2>Here be dragons, ye be warned</h2>
		<p>Ok, I maybe made a mistake on my website.</p>
	</div>
</xsl:template>

<xsl:template match="bundles-get/entry" mode="content">
	<!-- <xsl:apply-templates select="media" /> -->
	<xsl:apply-templates select="/data/media-find-by-bundle/bundle[@link-id = current()/@id]" />
</xsl:template>

<!--
  ~~ Media
  -->
<xsl:variable name="img-width" select="700" />

<!-- <xsl:template match="media[item/published/text() = 'Yes']"> -->
<xsl:template match="media-find-by-bundle/bundle">
	<!-- <xsl:variable name="image-items" select="item"/> -->
	<xsl:variable name="image-items" select="entry"/>
	<xsl:variable name="max-height" select="round(($img-width div math:max($image-items/file/meta/@width)) * math:max($image-items/file/meta/@height))" />
	<!-- Image Pager -->
	<xsl:if test="count($image-items) &gt; 1">
	<div id="bundle-media-pager" class="rsquare-pager">
		<a id="preceding-image" class="preceding-button button" href="#"><!--&#x25C0;--></a>
		<a id="following-image" class="following-button button" href="#"><!--&#x25B6;--></a>
	</div>
	</xsl:if>
	<!-- Image List -->
	<ul id="bundle-media" class="image-list" style="width: {$img-width}px; height: {$max-height}px;">
		<!-- <xsl:apply-templates select="item"/> -->
		<xsl:apply-templates select="entry"/>
	</ul>
</xsl:template>

<!-- <xsl:template match="media/item"> -->
<xsl:template match="media-find-by-bundle/bundle/entry">
	<li id="i{@id}" class="image-item">
		<xsl:if test="position() &gt; 1">
			<xsl:attribute name="style">
				<xsl:copy-of select="'display: none'"/>
			</xsl:attribute>
		</xsl:if>
		<img width="{$img-width}"
			 height="{floor(($img-width div file/meta/@width) * file/meta/@height)}"
			 title="{file/filename}" alt="{file/filename}" longdesc="#i{@id}-caption"
			 src="{$root}/image/1/{$img-width}/0{file/@path}/{file/filename}"/>
		<div id="i{@id}-caption" class="caption longdesc">
			<xsl:apply-templates select="description/*" mode="html"/>
		</div>
	</li>
</xsl:template>

<!--
  ~~ Types/Keywords
  -->
<xsl:variable name="bundle-keywords" select="//ds-bundles-get.keywords" />

<xsl:template match="types-all">
	<dl id="keyword-list" class="list selectable filterable grouped">
		<xsl:apply-templates select="entry"/>
	</dl>
</xsl:template>

<xsl:template match="types-all/entry">
	<xsl:variable name="current-type-keywords" select="/data/keywords-all/entry[type/item/@id = current()/@id]"/>
	<dt id="t{@id}">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$bundle-keywords/item[@handle = $current-type-keywords/@id]">
					<xsl:copy-of select="'list-group'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="'list-group excluded'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:value-of select="name/text()"/>
	</dt>
	<xsl:apply-templates select="$current-type-keywords"/>
</xsl:template>

<xsl:template match="keywords-all/entry">
	<dd id="k{@id}">
		<xsl:attribute name="class">
			<xsl:choose>
				<xsl:when test="$bundle-keywords/item[@handle = current()/@id]">
					<xsl:copy-of select="'list-item'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="'list-item excluded'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<a href="{$root}/keywords/{name/@handle}">
			<xsl:value-of select="name/text()"/>
		</a>
	</dd>
</xsl:template>

</xsl:stylesheet>
