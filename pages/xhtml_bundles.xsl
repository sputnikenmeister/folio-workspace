<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://exslt.org/math"
	extension-element-prefixes="math">

<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="../utilities/typography.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<xsl:template match="data" mode="nav">
	<xsl:apply-templates select="bundles-by-handle/entry[1]" mode="nav"/>
	<xsl:apply-templates select="bundles-by-handle/error"/>
</xsl:template>

<xsl:template match="data">
	<xsl:apply-templates select="bundles-by-handle/entry[1]"/>
</xsl:template>

<xsl:template match="bundles-by-handle/error">
	<div class="bd-item">
		<h3>No bundle found.</h3>
	</div>
</xsl:template>

<xsl:template match="bundles-by-handle/entry" mode="nav">
	<div id="bd-nav">
		<!-- Preceding	-->
		<xsl:variable name="preceding-bundle" select="//all-bundles/entry[@id = current()/@id]/preceding-sibling::entry[1]"/>
		<xsl:if test="$preceding-bundle">
		<a id="preceding-bundle" href="{$parent-path}/{$current-page}/{$preceding-bundle/name/@handle}/">
			<!--<span class="symbol">&#x2190;</span>-->
			<xsl:copy-of select="$preceding-bundle/name/text()"/>
		</a>
		</xsl:if>
		<!-- Following	-->
		<xsl:variable name="following-bundle" select="//all-bundles/entry[@id = current()/@id]/following-sibling::entry[1]"/>
		<xsl:if test="$following-bundle">
		<a id="following-bundle" href="{$parent-path}/{$current-page}/{$following-bundle/name/@handle}/">
			<!--<span class="symbol">&#x2192;</span>-->
			<xsl:copy-of select="$following-bundle/name/text()"/>
		</a>
		</xsl:if>
		<!-- Close	-->
		<a id="close-bundle" href="{$parent-path}/">
			<!--<span class="symbol">&#2715;</span>-->
			<xsl:text>Close</xsl:text>
		</a>
	</div>
	<div id="bd-detail">
		<h2 class="bundle-name">
			<xsl:value-of select="name/text()" />
		</h2>
			
		<div class="completed meta pubDate">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="completed"/>
				<xsl:with-param name="format" select="'%y+;'"/>
			</xsl:call-template>
		</div>
		<!--
		<xsl:if test="$is-logged-in = 'true'">
			<div class="meta">
				<a class="edit" href="{$root}/symphony/publish/{../section/@handle}/edit/{@id}/">Edit</a>
			</div>
		</xsl:if>
		-->
		<div class="description">
			<xsl:apply-templates select="description/*" mode="html"/>
		</div>
	</div>
</xsl:template>

<xsl:template match="bundles-by-handle/entry">
	<div class="bd-content">
		<xsl:apply-templates select="images" />
	</div>
</xsl:template>

<xsl:variable name="img-width" select="480" />
<!--<xsl:variable name="img-height" select="320" />-->

<xsl:template match="images">
	<xsl:variable name="image-items" select="item[published = 'Yes']"/>
	<xsl:variable name="max-height" select="round(($img-width div math:max(item/file/meta/@width)) * math:max(item/file/meta/@height))" />
	
	<div id="bd-images" class="pageable" style="width: {$img-width}px; height: {$max-height}px;">
		<ul>
			<xsl:apply-templates select="$image-items"/>
		</ul>
		<xsl:if test="count($image-items) &gt; 1">
			<div class="pageable-ctls">
				<a class="preceding-button button" href="javascript:void(0)"><!--&#x25C0;--></a>
				<a class="following-button button" href="javascript:void(0)"><!--&#x25B6;--></a>
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
		<img src="{$root}/image/1/{$img-width}/0{file/@path}/{file/filename}" width="{$img-width}" height="{floor(($img-width div file/meta/@width) * file/meta/@height)}" title="{description}" alt="{description}"/>
		<div class="caption">
			<xsl:apply-templates select="description/*" mode="html"/>
		</div>
	</li>
</xsl:template>

<xsl:template match="all-types">
	<ul id="keywords" class="mapped collapsed pinned">
		<xsl:apply-templates select="entry"/>
	</ul>
</xsl:template>

<xsl:template match="all-types/entry">
	<xsl:variable name="current-keywords" select="//all-keywords/entry[type/item/@id = current()/@id]"/>
	<li id="{name/@handle}">
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
		<h3><xsl:value-of select="name/text()"/></h3>
		<ul>
			<xsl:apply-templates select="$current-keywords"/>
		</ul>
	</li>
</xsl:template>

<xsl:template match="all-keywords/entry">
	<li id="{name/@handle}">
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
	</li>
</xsl:template>

</xsl:stylesheet>