<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--<xsl:import href="../utilities/implode.xsl" />-->
<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="json/helpers.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<xsl:strip-space elements="*"/>

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

<xsl:template match="data" mode="html-head">
	<script src="{$workspace}/assets/lib/jquery-1.11.1.js"></script>
	<script src="{$workspace}/assets/lib/underscore.js"></script>
	<script src="{$workspace}/assets/lib/backbone.js"></script>
	<script src="{$workspace}/assets/js/backbone.folio.js"></script>
	<script>
		window.bootstrap = {<xsl:apply-templates select="all-bundles | all-keywords | all-types" mode="output-json"/>};
	</script>
</xsl:template>

<xsl:template match="data">
<div id="navigation">
	<!-- all keywords+types -->
	<xsl:apply-templates select="all-types"/>
	<!-- all bundles-->
	<xsl:apply-templates select="all-bundles"/>
	<!-- bundles pager -->
	<div id="bd-nav" class="nav rsquare-nav"></div>
	<!-- details -->
	<div id="bd-detail"></div>
</div>
<div id="main">
</div>
<script id="bd-nav_tmpl" type="text/template" class="template">
	<a id="preceding-bundle" class="preceding-button button" href="#/bundles/{{{{preceding_href}}}}/">{{preceding_name}}</a>
	<a id="following-bundle" class="following-button button" href="#/bundles/{{{{following_href}}}}/">{{following_name}}</a>
	<a id="close-bundle" class="close-button button" href="#/">Close</a>
</script>
<script id="bd-detail_tmpl" type="text/template" class="template">
	<h2 class="name">{{name}}</h2>
	<div class="completed meta pubDate">{{completed}}</div>
	<div class="description">{{description}}</div>
</script>
<script id="bd-images-nav_tmpl" type="text/template" class="template">
	<div id="bd-images-nav" class="pageable-ctls" style="display:none;">
		<a id="preceding-image" class="preceding-button button" href="#/preceding-image"></a>
		<a id="following-image" class="following-button button" href="#/following-image"></a>
	</div>
</script>
<script id="bd-images-item_tmpl" type="text/template" class="template">
	<li>
		<img src="{$root}/image{{{{url}}}}" width="{{{{width}}}}" height="{{{{height}}}}" title="" alt="" />
		<div class="caption sc">{{description}}</div>
	</li>
</script>
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
			<a href="#/bundles/{name/@handle}/" data-href="{$root}/xhtml/bundles/{name/@handle}/">
				<!--<xsl:apply-templates select="display-name/*" mode="html"/>-->
				<xsl:copy-of select="name/text()"/>
			</a>
		</span>
	</li>
</xsl:template>

</xsl:stylesheet>
