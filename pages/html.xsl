<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:e="http://exslt.org/common"
	extension-element-prefixes="e">

<!-- import and overrides -->
<xsl:import href="html/master.xsl"/>
<xsl:import href="html/webfonts.xsl"/>
<xsl:include href="json/output-items.xsl"/>

<!-- <xsl:strip-space elements="url"/> -->

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Params & Variables -->
<!-- - - - - - - - - - - - - - - - - - - - - -->

<!-- Override variables -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- NOTE: $tstamp $debug $is-xhtml defined in html/master.xsl -->
<xsl:variable name="body-id" select="'container'"/>
<!-- <xsl:variable name="body-classes" select="''"/> -->
<!-- <xsl:variable name="container-id" select="''"/> -->
<!-- <xsl:variable name="container-classes" select="''"/> -->

<!-- Async script loading -->
<xsl:variable name="js-attrs">
	<xsl:if test="$is-xhtml">
		<xsl:attribute name="type">text/javascript</xsl:attribute>
	</xsl:if>
	<xsl:attribute name="async">true</xsl:attribute>
</xsl:variable>

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override main -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<xsl:template match="data">
	<div id="navigation" class="navigation">
		<div id="site-name-wrapper" class="transform-wrapper">
			<h1 id="site-name">
				<a href="{$root}/#">
					<span class="label"><xsl:value-of select="$website-name"/></span>
				</a>
			</h1>
		</div>
		<div id="article-list-wrapper" class="transform-wrapper">
			<h2 id="about-button" class="article-button" data-handle="about">
				<a href="{$root}/#about">
					<span class="label">About</span>
				</a>
			</h2>
		</div>
		<!-- all bundles-->
		<div id="bundle-list-wrapper" class="transform-wrapper">
			<xsl:apply-templates select="bundles-all" mode="navigation"/>
		</div>
		<!-- all types->keywords -->
		<div id="keyword-list-wrapper" class="transform-wrapper">
			<xsl:apply-templates select="types-all" mode="navigation"/>
		</div>
	</div>
	<div id="content" class="content"></div>

<!-- Google Analytics -->
<!-- <xsl:variable name="ga-tracking-id" select="'UA-9123564-7'"/> -->
<xsl:variable name="ga-tracking-id" select="'UA-0000000-0'"/>
<xsl:call-template name="inline-script">
	<!-- Bootstrap data -->
	<xsl:with-param name="id" select="'bootstrap-data'"/>
	<xsl:with-param name="cdata" select="$is-xhtml"/>
	<xsl:with-param name="content">
	window.DEBUG = <xsl:value-of select="$debug"/>;
	window.approot = '<xsl:value-of select="$root"/>/';
	window.mediadir = '<xsl:value-of select="$workspace"/>/uploads';
	window.GA_ID = '<xsl:value-of select="$ga-tracking-id"/>';
	window.bootstrap = {<xsl:apply-templates select="/data" mode="output-json"/>};
	</xsl:with-param>
</xsl:call-template>

<!-- <xsl:apply-templates select="articles-system/entry[name/@handle = 'unsupported']"/> -->
</xsl:template>

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override HTML Head -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<xsl:template match="data" mode="html-head">
	<!-- Favicons -->
	<xsl:choose>
		<xsl:when test="$debug">
		<xsl:call-template name="favicon">
			<xsl:with-param name="url-prefix" select="concat($workspace, '/assets/images/favicons/white')"/>
			<xsl:with-param name="bg-color" select="'#FFFFFF'"/>
			<xsl:with-param name="prevent-cache" select="true()"/>
			<xsl:with-param name="output-comments" select="true()"/>
		</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
		<xsl:call-template name="favicon">
			<xsl:with-param name="url-prefix" select="concat($workspace, '/assets/images/favicons/black')"/>
			<xsl:with-param name="bg-color" select="'#000000'"/>
		</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>

	<!-- RSS -->
	<link rel="alternate" type="application/rss+xml" href="{$root}/rss"/>

	<!-- Stylesheets -->
	<xsl:choose>
	<xsl:when test="$debug">
		<xsl:apply-templates select="document(concat($workspace, '/assets/fonts/data.xml', $tstamp))/webfonts" mode="webfonts"/>
		<!-- <link id="fonts" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/fonts-debug.css{$tstamp}"/> -->
		<link id="folio" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio-debug.css{$tstamp}"/>
	</xsl:when>
	<xsl:otherwise>
		<xsl:apply-templates select="document(concat($workspace, '/assets/fonts/data.xml', $tstamp))/webfonts" mode="webfonts"/>
		<!-- <link id="fonts" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/fonts.css"/> -->
		<link id="folio" rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio.css"/>
	</xsl:otherwise>
	</xsl:choose>

	<!-- IE conditional comments -->
	<xsl:comment><![CDATA[[if lte IE 9]><link rel="stylesheet" type="text/css" href="]]><xsl:value-of select="$workspace"/><![CDATA[/assets/css/folio-ie.css"/><![endif]]]></xsl:comment>
	<!-- <xsl:comment><![CDATA[[if lt IE 9]><script language="javascript" type="text/javascript" src="https://raw.githubusercontent.com/jonathantneal/html5shim/master/html5shiv.js"></script><![endif]]]></xsl:comment> -->

	<!-- Scripts -->
	<xsl:choose>
	<xsl:when test="$debug">
		<!-- <script type="text/javascript" async="true" src="https://www.google-analytics.com/analytics_debug.js"></script> -->
		<script src="{$workspace}/assets/js/folio-debug-vendor.js{$tstamp}">
			<xsl:copy-of select="$js-attrs"/>
		</script>
		<script src="{$workspace}/assets/js/folio-debug-client.js{$tstamp}">
			<xsl:copy-of select="$js-attrs"/>
		</script>
	</xsl:when>
	<xsl:otherwise>
		<!-- <script type="text/javascript" async="true" src="https://www.google-analytics.com/analytics.js"></script> -->
		<script src="{$workspace}/assets/js/folio.js">
			<xsl:copy-of select="$js-attrs"/>
		</script>
	</xsl:otherwise>
	</xsl:choose>

	<script src="https://www.google-analytics.com/analytics.js" async="true">
		<xsl:if test="$is-xhtml">
			<xsl:attribute name="type">text/javascript</xsl:attribute>
		</xsl:if>
	</script>

</xsl:template>


<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override html-body-first -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- <xsl:template match="data" mode="html-body-first"></xsl:template> -->

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override html-body-last -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- <xsl:template match="data" mode="html-body-last"></xsl:template> -->

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override page-title -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override Webfonts -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<xsl:template match="src" mode="webfonts">
	<xsl:choose>
		<!-- if inline base64 data available -->
		<xsl:when test="url[@scheme = 'data'] and (
				../font-style/text() = 'normal' or
				../font-style/text() = 'italic'
			) and (
				format/text() = 'woff' or
				format/text() = 'woff2'
			)">
			<xsl:apply-templates select="url[@scheme = 'data'][1]" mode="webfonts"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="url[not(@scheme = 'data')][1]" mode="webfonts"/>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates select="format" mode="webfonts"/>
	<xsl:if test="position() != last()">
		<xsl:text>,</xsl:text>
		<xsl:text>&#xa;&#9;&#9;&#9;</xsl:text>
	</xsl:if>
</xsl:template>

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- HTML item templates -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
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

</xsl:stylesheet>
