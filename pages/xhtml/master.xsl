<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="../json/helpers.xsl"/>

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />

<!--<!DOCTYPE html [
  <!ENTITY % htmlDTD
    PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "DTD/xhtml1-strict.dtd">
  %htmlDTD;
  <!ENTITY % globalDTD
    SYSTEM "chrome://global/locale/global.dtd">
  %globalDTD;
  <!ENTITY % feedDTD
    SYSTEM "chrome://browser/locale/feeds/subscribe.dtd">
  %feedDTD;
]>-->

<xsl:variable name="is-logged-in" select="'true'"/>
<!--<xsl:variable name="is-logged-in" select="/data/events/login-info/@logged-in"/>-->

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
	<xsl:text> &#8212; </xsl:text>
	<xsl:value-of select="$page-title"/>
</xsl:template>

<xsl:template match="/">
<html lang="en" class="no-js">
	<head profile="http://gmpg.org/xfn/11">
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
		<title><xsl:call-template name="page-title"/></title>
		<meta name="author" content="{$root}/humans.txt" />
		<meta name="description" content=""/>
		<link rel="alternate" type="application/rss+xml" href="{$root}/rss/" />
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/common.css" />
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio.css" />
<!--		<script src="{$workspace}/assets/lib/head-0.9.min.js"></script>-->
<!--		<script src="{$workspace}/assets/lib/jquery.cycle.all.2.88.js"></script>-->
<!--		<script src="{$workspace}/assets/js/folio.js"></script>-->
		<script src="{$workspace}/assets/lib/jquery-1.11.1.js"></script>
		<script src="{$workspace}/assets/lib/underscore.js"></script>
		<script src="{$workspace}/assets/lib/backbone.js"></script>
		<script src="{$workspace}/assets/js/backbone.folio.js"></script>
	</head>
<!--[if lt IE 7 ]>
	<body class="ie ie6 {$current-page}">
<![endif]--><!--[if IE 7 ]>
	<body class="ie ie7 {$current-page}">
<![endif]--><!--[if IE 8 ]>
	<body class="ie ie8 {$current-page}">
<![endif]--><!--[if IE 9 ]>
	<body class="ie ie9 {$current-page}">
<![endif]--><!--[if gt IE 9]>
	<body class="ie {$current-page}">
<![endif]--><!--[if !IE]><!-->
	<body class="{$current-page}-page">
<!--<![endif]-->
		<div id="container">
			<div id="header">
				<h1 id="site-name">
					<a href="{$root}"><xsl:value-of select="$website-name"/></a>
				</h1>
				<!-- <h2><xsl:value-of select="$page-title"/></h2> -->
				<!--<xsl:apply-templates select="data/navigation"/>-->
			</div>
			<div id="nav-sidebar">
				<xsl:apply-templates select="data/all-types"/>
			</div>
			<div id="navigation">
				<xsl:apply-templates select="data" mode="navigation"/>
			</div>
			<div id="main">
				<xsl:apply-templates select="data"/>
			</div>
			<div id="footer">
				<xsl:if test="$is-logged-in = 'true'">
				<dl class="admin">
					<dt>Tools</dt>
					<dd><a href="{$root}/symphony/">Backend</a></dd>
					<dd><a href="?debug=xml">Debug</a></dd>
				</dl>
				<p>Copyright 2010-2013 Pablo Gª Canillas. All rights reserved.</p>
				</xsl:if>
			</div>
		</div>
	<script>
		window.bootstrap = {<xsl:apply-templates select="data" mode="output-json"/>};
	</script>
<!--	head.js("<xsl:value-of select="concat($workspace, '/assets/lib/jquery-1.7.2.min.js')" />"-->
<!--		,"<xsl:value-of select="concat($workspace, '/assets/lib/jquery.cycle.all.2.88.js')" />"-->
<!--		,"<xsl:value-of select="concat($workspace, '/assets/js/folio.js')" />"-->
<!--		,"<xsl:value-of select="concat($workspace, '/assets/lib/font-friend/font-friend-3.2.js')" />"-->
<!--		,"http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.js"-->
<!--		,"http://www.google-analytics.com/ga.js"-->
<!--	);-->
	</body>
</html>
</xsl:template>

<xsl:template match="data" mode="navigation">
</xsl:template>

<xsl:template match="data">
</xsl:template>

<xsl:template match="all-types">
	<ul id="keywords" class="mapped">
		<xsl:apply-templates select="entry"/>
	</ul>
</xsl:template>

<xsl:template match="all-types/entry">
	<li id="{name/@handle}" class="group">
		<h3><xsl:value-of select="name/text()"/></h3>
		<ul>
			<xsl:apply-templates select="//all-keywords/entry[type/item/@id = current()/@id]"/>
		</ul>
	</li>
</xsl:template>

<xsl:template match="all-keywords/entry">
	<li id="{name/@handle}" class="item">
		<a href="#{name/@handle}" data-href="{$root}/xhtml/keywords/{name/@handle}">
			<xsl:value-of select="name/text()"/>
		</a>
	</li>
</xsl:template>

<xsl:template match="data" mode="output-json">
	<xsl:apply-templates select="all-bundles | all-keywords | all-types" mode="output-json"/>
</xsl:template>

</xsl:stylesheet>
