<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:exsl="http://exslt.org/common"
	 xmlns:date="http://exslt.org/dates-and-times"
	 extension-element-prefixes="exsl date">

<xsl:import href="xhtml/master.xsl"/>
<xsl:import href="json/output-short.xsl"/><!-- json -->
<xsl:include href="xhtml/inline-script.xsl"/>
<xsl:include href="xhtml/favicon.xsl"/>

<!-- $is-logged-in defined in xhtml/master.xsl -->
<xsl:variable name="is-xhtml" test="/data/params/page-types/item/@handle = 'xhtml'"/>
<xsl:variable name="tstamp" select="date:seconds()"/>

<!-- Page Title -->
<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

<!-- Head Scripts -->
<xsl:template match="data" mode="html-head-scripts">
<!--[if gt IE 8]><!-->
<!--<![endif]-->
	<!-- <script type="text/javascript" src="{$workspace}/assets/lib/modernizr.js"></script> -->
	<!-- <script type="text/javascript" src="http://modernizr.com/downloads/modernizr.js"></script> -->
	<xsl:call-template name="favicon">
		<xsl:with-param name="url-prefix" select="concat($workspace, '/assets/images/favicons')"/>
	</xsl:call-template>
	<!-- Stylesheets -->
	<xsl:choose>
	<xsl:when test="$is-logged-in">
		<link id="folio" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio-debug.css?{$tstamp}"/>
		<!-- <link id="fonts" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/fonts.css?{$tstamp}"/> -->
	</xsl:when>
	<xsl:otherwise>
		<link id="folio" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio.css"/>
		<link id="fonts" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/fonts.css"/>
	</xsl:otherwise>
	</xsl:choose>

	<!-- <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/webfont/1.5.10/webfont.js"></script> -->
	<!-- WebFont.load({ custom: { families: ['Franklin Gothic FS', 'fontello'] } }); -->
	<!-- <xsl:call-template name="inline-script">
		<xsl:with-param name="content">
			window.approot = "<xsl:value-of select="$root"/>/";
		</xsl:with-param>
	</xsl:call-template> -->

	<!-- Library bundle -->
	<xsl:choose>
	<xsl:when test="$is-logged-in">
		<script type="text/javascript" src="{$workspace}/assets/js/folio-debug-vendor.js"></script>
		<script type="text/javascript" src="{$workspace}/assets/js/folio-debug-client.js?{$tstamp}"></script>
	</xsl:when>
	<xsl:otherwise>
		<script type="text/javascript" src="{$workspace}/assets/js/folio.js"></script>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Container HTML -->
<xsl:template match="data">
	<div id="navigation" class="navigation">
		<div id="site-name-wrapper" class="transform-wrapper">
			<h1 id="site-name">
				<a href="{$root}/#"><xsl:value-of select="$website-name"/></a>
			</h1>
		</div>
		<div id="article-list-wrapper" class="transform-wrapper">
			<h2 id="about" class="article-button">
				<a href="{$root}/#about">About</a>
			</h2>
		</div>
		<!-- all bundles-->
		<div id="bundle-list-wrapper" class="transform-wrapper">
			<xsl:apply-templates select="bundles-all"/>
		</div>
		<!-- all types->keywords -->
		<div id="keyword-list-wrapper" class="transform-wrapper">
			<xsl:apply-templates select="types-all"/>
		</div>
	</div>
	<div id="content" class="content viewport">
	</div>
	<xsl:apply-templates select="articles-system/entry[name/@handle = 'unsupported']"/>
	<!-- <div id="unsupported">
		<h2 class="color-ln">Portfolio</h2>
		<p>A layout for mobile-sized screens is not yet ready… Please use a tablet or computer to view this website.</p>
		<p class="contact">You can reach me at <a href="mailto:blah@nowhere.tld">blah@nowhere.tld</a> or <a href="https://www.linkedin.com/in/pablo-canillas" rel="noopener noreferrer" target="_blank">view my profile on LinkedIn</a></p>
	</div> -->
</xsl:template>

<!-- Footer Scripts -->
<xsl:template match="data" mode="html-footer-scripts">
	<xsl:call-template name="inline-script">
		<!-- Bootstrap data -->
		<xsl:with-param name="cdata" select="$is-xhtml"/>
		<xsl:with-param name="content">
			window.DEBUG = <xsl:value-of select="$is-logged-in"/>;
			window.approot = '<xsl:value-of select="$root"/>/';
			window.mediadir = '<xsl:value-of select="$workspace"/>/uploads';
			window.bootstrap = {
			<xsl:apply-templates select="/data/types-all" mode="output-json"/>,
			<xsl:apply-templates select="/data/keywords-all" mode="output-json"/>,
			<xsl:apply-templates select="/data/bundles-all" mode="output-json"/>,
			<xsl:apply-templates select="/data/media-all" mode="output-json"/>,
			<xsl:apply-templates select="/data/articles-all" mode="output-json"/>
			};
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- article-view item -->
<xsl:template match="articles-all/entry">
	<article id="{name/@handle}" class="article-view" data-id="{@id}">
		<xsl:apply-templates select="text/*" mode="html"/>
		<!-- <xsl:copy-of select="text/* | text/text()" /> -->
	</article>
</xsl:template>

<!-- article-view item -->
<xsl:template match="articles-system/entry">
	<div id="{name/@handle}" class="system-view" data-id="{@id}">
		<h2 class="color-ln">
			<xsl:copy-of select="display-name/*[1]/* | display-name/*[1]/text()"/>
		</h2>
		<xsl:apply-templates select="text/* | text/text()" mode="html"/>
	</div>
</xsl:template>

<!-- bundle-list -->
<xsl:template match="bundles-all">
	<ul id="bundle-list" class="list selectable filterable">
		<xsl:apply-templates select="entry"/>
	</ul>
</xsl:template>

<!-- bundle-list item -->
<xsl:template match="bundles-all/entry">
	<li class="list-item" data-id="{@id}">
		<a href="{$root}/#bundles/{name/@handle}">
			<span class="completed meta pubDate" data-datetime="{completed/text()}">
				<xsl:value-of select="substring(completed/text(),1,4)"/>
			</span>
			<xsl:choose>
				<xsl:when test="display-name">
					<span class="name label display-name">
						<xsl:copy-of select="display-name/*[1]/* | display-name/*[1]/text()"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<span class="name label">
						<xsl:copy-of select="name/text()"/>
					</span>
				</xsl:otherwise>
			</xsl:choose>
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>
