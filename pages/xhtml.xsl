<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="json/helpers.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<xsl:strip-space elements="*"/>

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>
	
<xsl:template match="data" mode="html-head-scripts">
<script src="{$workspace}/assets/lib/jquery-1.11.1.js"></script>
<script src="{$workspace}/assets/lib/underscore.js"></script>
<script src="{$workspace}/assets/lib/backbone.js"></script>
</xsl:template>
	
<xsl:template match="data" mode="html-footer-scripts">
<script type="text/javascript" >
	window.bootstrap = {<xsl:apply-templates select="/data/all-bundles | /data/all-keywords | /data/all-types | /data/params/root" mode="output-json"/>};
</script>
<script type="text/javascript" src="{$workspace}/assets/js/folio.js"></script>
</xsl:template>

<xsl:template match="data">
<div id="navigation">
	<!-- all keywords+types -->
	<xsl:apply-templates select="all-types"/>
	<!-- all bundles-->
	<xsl:apply-templates select="all-bundles"/>
	<!-- bundles pager -->
	<div id="bundle-pager" class="fontello-pager"></div>
</div>
<div id="main">
	<!-- details -->
	<div id="bundle-detail"></div>
</div>
<!--
	<script type="text/javascript" >
		window.bootstrap = {
			bundles: [<xsl:apply-templates select="/data/all-bundles/entry" mode="output-json"/>],
			keywords: [<xsl:apply-templates select="/data/all-keywords/entry" mode="output-json"/>],
			types: [<xsl:apply-templates select="/data/all-types/entry" mode="output-json"/>],
			params: {<xsl:apply-templates select="/data/params/root" mode="output-json"/>}
		};
	</script>
-->
<!-- javascript embedded templates -->
<!--
<xsl:call-template name="embedded-template">
	<xsl:with-param name="id" select="'pager-nav_tmpl'"/>
	<xsl:with-param name="xml">
	<a class="preceding-button button" href="{{{{preceding_href}}}}">{{preceding_label}}</a>
	<a class="following-button button" href="{{{{following_href}}}}">{{following_label}}</a>
	<a class="close-button button" href="{{{{close_href}}}}">{{close_label}}</a>
	</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="embedded-template">
	<xsl:with-param name="id" select="'bundle-detail_tmpl'"/>
	<xsl:with-param name="xml">
	<h2 class="name">{{name}}</h2>
	<div class="completed meta pubDate">{{completed}}</div>
	<div class="description">{{description}}</div>
	</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="embedded-template">
	<xsl:with-param name="id" select="'bundle-images-item_tmpl'"/>
	<xsl:with-param name="xml">
	<li>
		<img src="{$root}/image{{{{url}}}}" width="{{width}}" height="{{{{height}}}}" title="" alt="" />
		<div class="caption sc">{{description}}</div>
	</li>
	</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="embedded-template">
	<xsl:with-param name="id" select="'bundle-images-nav_tmpl'"/>
	<xsl:with-param name="xml">
	<div id="bundle-images-nav" class="pageable-ctls" style="display:none;">
		<a id="preceding-image" class="preceding-button button" href="#/preceding-image"></a>
		<a id="following-image" class="following-button button" href="#/following-image"></a>
	</div>
	</xsl:with-param>
</xsl:call-template>
-->
</xsl:template>

<xsl:template match="all-bundles">
	<ul id="bundles" class="nav mapped">
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
		<span class="name">
			<a href="#/bundles/{name/@handle}/" data-href="{$root}/bundles/{name/@handle}/">
				<!--<xsl:apply-templates select="display-name/*" mode="html"/>-->
				<xsl:copy-of select="name/text()"/>
			</a>
		</span>
	</li>
</xsl:template>

</xsl:stylesheet>
