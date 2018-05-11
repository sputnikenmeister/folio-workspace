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
<!-- Google Analytics -->
<xsl:variable name="ga-tracking-id" select="'UA-9123564-7'"/>

<!-- Page Title -->
<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

<!-- Head Scripts -->
<xsl:template match="data" mode="html-head">

	<!-- Favicons -->
	<xsl:call-template name="favicon">
		<xsl:with-param name="url-prefix" select="concat($workspace, '/assets/images/favicons')"/>
	</xsl:call-template>

	<!-- Stylesheets -->
	<xsl:choose>
	<xsl:when test="$is-logged-in">
		<link id="folio" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio-debug.css?{$tstamp}"/>
	</xsl:when>
	<xsl:otherwise>
		<link id="fonts" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/fonts.css"/>
		<link id="folio" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio.css"/>
	</xsl:otherwise>
	</xsl:choose>

	<!-- IE conditional comments -->
<xsl:comment><![CDATA[[if lte IE 9]>
	<link rel="stylesheet" type="text/css" href="]]><xsl:value-of select="$workspace"/><![CDATA[/assets/css/ie.css"/>
<![endif]]]></xsl:comment>

	<!-- <xsl:call-template name="ga-inline-script"/> -->

	<!-- JS library bundles -->
	<xsl:choose>
	<xsl:when test="$is-logged-in">
		<script type="text/javascript" async="true" src="https://www.google-analytics.com/analytics_debug.js"></script>
		<script type="text/javascript" async="true" src="{$workspace}/assets/js/folio-debug-vendor.js"></script>
		<script type="text/javascript" async="true" src="{$workspace}/assets/js/folio-debug-client.js?{$tstamp}"></script>
	</xsl:when>
	<xsl:otherwise>
		<script type="text/javascript" async="true" src="https://www.google-analytics.com/analytics.js"></script>
		<script type="text/javascript" async="true" src="{$workspace}/assets/js/folio.js"></script>
	</xsl:otherwise>
	</xsl:choose>

	<!-- IE conditional comments -->
<xsl:comment><![CDATA[[if lt IE 9]>
	<script language="javascript" type="text/javascript" src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]]]></xsl:comment>

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
</xsl:template>


<xsl:template match="data" mode="html-body-first">
	<!-- Google Tag Manager -->
	<!-- <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NGTPHRB" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript> -->
</xsl:template>

<!-- Footer Scripts -->
<xsl:template match="data" mode="html-body-last">
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
			window.GA_ID = '<xsl:value-of select="$ga-tracking-id"/>';
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

<xsl:template name="ga-inline-script">
	<xsl:call-template name="inline-script">
		<xsl:with-param name="cdata" select="$is-xhtml"/>
		<xsl:with-param name="content">
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','https://www.google-analytics.com/analytics<xsl:if test="$is-logged-in">_debug</xsl:if>.js','ga');

		window.ga_debug = { trace: false<!-- <xsl:value-of select="$is-logged-in"/>--> };
		window.ga('create', '<xsl:value-of select="$ga-tracking-id"/>', 'auto');
		<!-- if (/(?:(localhost|\.local))$/.test(location.hostname)) window.ga('set', 'sendHitTask', null); -->
		<!-- ga('send', 'pageview'); -->
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
