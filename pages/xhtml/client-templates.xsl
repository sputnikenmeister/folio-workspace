<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl">

<xsl:template name="embedded-template">
	<xsl:param name="id"/>
	<xsl:param name="content"/>
	<xsl:param name="type" select="'text/template'"/>
	<xsl:param name="class" select="'template'"/>
	<script id="{$id}" type="{$type}" class="{$class}">
		<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
		<xsl:copy-of select="exsl:node-set($content)"/>
		<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
	</script>
</xsl:template>

<!-- underscore.js embedded templates -->
<xsl:template name="client-templates">
	<xsl:call-template name="embedded-template">
		<xsl:with-param name="id" select="'pager-nav_tmpl'"/>
		<xsl:with-param name="content">
		<a class="preceding-button button" href="{{{{preceding_href}}}}">{{preceding_label}}</a>
		<a class="following-button button" href="{{{{following_href}}}}">{{following_label}}</a>
		<a class="close-button button" href="{{{{close_href}}}}">{{close_label}}</a>
		</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="embedded-template">
		<xsl:with-param name="id" select="'bundle-detail_tmpl'"/>
		<xsl:with-param name="content">
		<h2 class="name">{{name}}</h2>
		<div class="completed meta pubDate">{{completed}}</div>
		<div class="description">{{description}}</div>
		</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="embedded-template">
		<xsl:with-param name="id" select="'bundle-images-item_tmpl'"/>
		<xsl:with-param name="content">
		<li>
			<img src="{$root}/image{{{{url}}}}" width="{{width}}" height="{{{{height}}}}" title="" alt="" />
			<div class="caption sc">{{description}}</div>
		</li>
		</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="embedded-template">
		<xsl:with-param name="id" select="'bundle-images-nav_tmpl'"/>
		<xsl:with-param name="content">
		<div id="bundle-images-nav" class="pageable-ctls" style="display:none;">
			<a id="preceding-image" class="preceding-button button" href="#/preceding-image"></a>
			<a id="following-image" class="following-button button" href="#/following-image"></a>
		</div>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
