<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">

<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="json/helpers.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<xsl:strip-space elements="*"/>

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

<!-- Head Scripts -->
<xsl:template match="data" mode="html-head-scripts">
	<script src="{$workspace}/assets/lib/jquery.js"></script>
	<script src="{$workspace}/assets/lib/hammer.js"></script>
	<script src="{$workspace}/assets/lib/jquery.hammer.js"></script>
	<script src="{$workspace}/assets/lib/underscore.js"></script>
	<script src="{$workspace}/assets/lib/backbone.js"></script>
</xsl:template>

<!-- Footer Scripts -->
<xsl:template match="data" mode="html-footer-scripts">
	<!-- Bootstrap data -->
	<xsl:call-template name="inline-script">
		<xsl:with-param name="content">window.bootstrap = {<xsl:apply-templates select="/data/all-bundles | /data/all-keywords | /data/all-types | /data/params/root" mode="output-json"/>};</xsl:with-param>
	</xsl:call-template>
	<!-- Application -->
	<script type="text/javascript" src="{$workspace}/assets/js/folio.js"></script>
</xsl:template>

<!-- Body HTML -->
<xsl:template match="data">
	<div id="navigation">
		<!-- all keywords+types -->
		<xsl:apply-templates select="all-types"/>
		<!-- all bundles-->
		<xsl:apply-templates select="all-bundles"/>
		<!-- bundles pager -->
		<!-- <div id="bundle-pager" class="fontello-pill-pager"></div> -->
		<!-- details -->
		<!-- <div id="bundle-detail"></div> -->
	</div>
	<!-- <div id="content"></div> -->
</xsl:template>

<!-- Bundle List -->
<xsl:template match="all-bundles">
	<ul id="bundle-list" class="selectable-list">
		<xsl:apply-templates select="entry"/>
	</ul>
</xsl:template>

<!-- Bundle Item -->
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
				<xsl:choose>
					<xsl:when test="display-name">
						<xsl:apply-templates select="display-name/*" mode="html"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="name/text()"/>
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</span>
	</li>
</xsl:template>

<!-- JavaScript CDATA script wrapper -->
<xsl:template name="inline-script">
	<xsl:param name="id"/>
	<xsl:param name="type" select="'text/javascript'"/>
	<xsl:param name="content" />
	<xsl:element name="script">
		<xsl:if test="$id">
			<xsl:attribute name="id">
				<xsl:value-of select="$id"/>
			</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="type">
			<xsl:value-of select="$type"/>
		</xsl:attribute>
		<!-- newline: &#xa;, fwd slash :&#47; -->
		<xsl:text disable-output-escaping="yes">&#xa;&#47;&#47;&lt;![CDATA[&#xa;</xsl:text>
		<xsl:copy-of select="exsl:node-set($content)"/>
		<xsl:text disable-output-escaping="yes">&#xa;&#47;&#47;]]&gt;</xsl:text>
	</xsl:element>
</xsl:template>

<!-- underscore.js embedded templates -->
<!--
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
	<xsl:with-param name="xml">
	<div id="bundle-images-nav" class="pageable-ctls" style="display:none;">
		<a id="preceding-image" class="preceding-button button" href="#/preceding-image"></a>
		<a id="following-image" class="following-button button" href="#/following-image"></a>
	</div>
	</xsl:with-param>
</xsl:call-template>
-->

</xsl:stylesheet>
