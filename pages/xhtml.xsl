<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/implode.xsl" />
<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<xsl:template match="data" mode="navigation">
	<xsl:apply-templates select="all-bundles"/>
	<div id="bd-nav">
		<script id="bd-nav_tmpl" type="text/template" class="template">
		<a id="preceding-bundle" class="preceding-button button" href="#preceding-bundle">{{preceding}}</a>
		<a id="following-bundle" class="following-button button" href="#following-bundle">{{following}}</a>
		<a id="close-bundle" class="close-button button" href="#close-bundle">Close</a>
		</script>
	</div>
</xsl:template>

<xsl:template match="data">
	<div id="bd-detail">
		<script id="bd-detail_tmpl" type="text/template" class="template">
		<!--<h2 class="bundle-name">{{name}}</h2>-->
		<div class="completed meta pubDate">{{completed}}</div>
		<div class="description">{{description}}</div>
		</script>
	</div>
	<div id="bd-images" class="pageable">
		<script id="bd-images_tmpl" type="text/template" class="template">
		<div id="bd-images-nav" class="pageable-ctls">
			<a id="preceding-image" class="preceding-button button" href="#preceding-image"></a>
			<a id="following-image" class="following-button button" href="#following-image"></a>
		</div>
		<ul style="width: 480px; height: 350px; overflow: hidden;">
		</ul>
		</script>
		<script id="bd-images-item_tmpl" type="text/template" class="template">
		<li>
			<img src="{$root}/image/bundle{{{{url}}}}" width="{{{{width}}}}" height="{{{{height}}}}" title="" alt="" />
			<div class="caption">{{description}}</div>
		</li>
		</script>
	</div>
</xsl:template>

<xsl:template match="all-bundles">
	<ul id="bundles" class="mapped">
		<xsl:apply-templates select="entry"/>	
	</ul>
</xsl:template>

<xsl:template match="all-bundles/entry">
	<li id="{name/@handle}" class="item">
		<span class="completed meta pubDate" data-datetime="{completed/text()}">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="completed"/>
				<xsl:with-param name="format" select="'%y+;'"/>
			</xsl:call-template>
		</span>
		<h2 class="bundle-name">
			<a href="{$root}/xhtml/bundles/{name/@handle}/">
				<!--<xsl:apply-templates select="display-name/*" mode="html"/>-->
				<xsl:copy-of select="name/text()"/>
			</a>
		</h2>
	</li>
</xsl:template>

<!-- Overrides -->
<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

</xsl:stylesheet>
