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
<xsl:variable name="body-id" select="''"/>
<!-- <xsl:variable name="body-classes" select="''"/> -->
<xsl:variable name="container-id" select="'container'"/>
<!-- <xsl:variable name="container-classes" select="''"/> -->

<!-- Async script loading -->
<xsl:variable name="js-attrs">
	<xsl:if test="$is-xhtml">
		<xsl:attribute name="type">text/javascript</xsl:attribute>
	</xsl:if>
	<xsl:attribute name="async">true</xsl:attribute>
</xsl:variable>

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override HTML Head -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<xsl:template name="html-head">
	<!-- <meta name="viewport" content="user-scalable=1, width=device-width, initial-scale=1.0, maximum-scale=1.0"/> -->
	<!-- <meta name="viewport" content="user-scalable=no, width=440, height=540, initial-scale=1, maximum-scale=1"/> -->
	<!-- <meta name="viewport" content="user-scalable=no, width=device-width, height=device-height, initial-scale=1, maximum-scale=1"/> -->
	<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1"/>

	<!-- <meta name="author" content="{$root}/humans.txt"/>-->
	<!-- <meta name="description" content="no description"/> -->

	<!-- cf. https://support.google.com/webmasters/answer/139066?hl=en#1 -->
	<!-- <link rel="canonical" href="{$root}/"/> -->
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
	<!-- <xsl:comment><![CDATA[[if (lt IE 9)]><link rel="stylesheet" type="text/css" href="]]><xsl:value-of select="$workspace"/><![CDATA[/assets/css/folio-ie.css"/><![endif]]]></xsl:comment> -->
	<!-- <xsl:comment><![CDATA[[if (gte IE 9)&(lt IE 11)]><link rel="stylesheet" type="text/css" href="]]><xsl:value-of select="$workspace"/><![CDATA[/assets/css/folio-ie.css"/><![endif]]]></xsl:comment> -->
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
	<!-- <xsl:apply-templates select="articles-system/entry[name/@handle = 'unsupported']"/> -->
</xsl:template>


<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override html-body-first -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- <xsl:template name="html-body-first"></xsl:template> -->

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Override html-body-last -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<xsl:template name="html-body-last">
	<!-- Google Analytics -->
	<!-- <xsl:variable name="ga-tracking-id" select="'UA-9123564-7'"/> -->
	<xsl:variable name="ga-tracking-id" select="'UA-0000000-0'"/>
	<xsl:call-template name="inline-script">
		<!-- Bootstrap data -->
		<xsl:with-param name="id" select="'bootstrap-data'"/>
		<xsl:with-param name="cdata" select="$is-xhtml"/>
		<xsl:with-param name="content">
		window.DEBUG = <xsl:value-of select="$debug"/>;
		window.GA_ID = '<xsl:value-of select="$ga-tracking-id"/>';
		window.approot = '<xsl:value-of select="$root"/>/';
		window.mediadir = '<xsl:value-of select="$workspace"/>/uploads';
		window.bootstrap = {<xsl:apply-templates select="/data" mode="output-json"/>};
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

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

</xsl:stylesheet>
