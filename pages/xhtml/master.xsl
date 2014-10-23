<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:variable name="is-logged-in" select="'true'"/>
<!--<xsl:variable name="is-logged-in" select="/data/events/login-info/@logged-in"/>-->

<xsl:template match="/">
<html lang="en">
	<head profile="http://gmpg.org/xfn/11">
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><xsl:call-template name="page-title"/></title>
		<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1"/>
		<meta name="author" content="{$root}/humans.txt"/>
		<meta name="description" content="no description"/>
		<link rel="canonical" href="{$root}/"/><!-- cf. https://support.google.com/webmasters/answer/139066?hl=en#1 -->
		<link rel="alternate" type="application/rss+xml" href="{$root}/rss"/>
		<!-- <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,200italic,300,300italic,400,400italic,600,600italic,700,700italic,900,900italic" /> -->
		<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio.css"/>
		<xsl:apply-templates select="data" mode="html-head-scripts"/>
	</head>
<!--[if lt IE 7 ]>
	<body class="ie ie6 {$current-page}-page">
<![endif]--><!--[if IE 7 ]>
	<body class="ie ie7 {$current-page}-page">
<![endif]--><!--[if IE 8 ]>
	<body class="ie ie8 {$current-page}-page">
<![endif]--><!--[if IE 9 ]>
	<body class="ie ie9 {$current-page}-page">
<![endif]--><!--[if gt IE 9]>
	<body class="ie {$current-page}-page">
<![endif]--><!--[if !IE]><!-->
	<body class="{$current-page}-page">
<!--<![endif]-->
		<div id="container">
			<div id="header" class="header">
				<h1 id="site-name">
					<a href="{$root}/"><xsl:value-of select="$website-name"/></a>
				</h1>
			</div>
			<xsl:apply-templates select="data"/>
			<div id="container-footer"></div>
		</div>
		<div id="footer" class="footer">
			<xsl:if test="$is-logged-in = 'true'">
			<dl class="admin">
				<dt>Tools</dt>
				<dd><a href="{$root}/symphony/">Backend</a></dd>
				<dd><a href="?debug=xml">Debug</a></dd>
			</dl>
			<p>Copyright 1995-2014 Pablo Canillas. All rights reserved.</p>
			</xsl:if>
		</div>
		<xsl:apply-templates select="data" mode="html-footer-scripts"/>
	</body>
</html>
</xsl:template>

<!-- Abstract -->
<xsl:template match="data"></xsl:template>

<!-- Abstract -->
<xsl:template match="data" mode="html-head-scripts"></xsl:template>

<!-- Abstract -->
<xsl:template match="data" mode="html-footer-scripts"></xsl:template>

<xsl:template match="all-types">
	<dl id="keyword-list" class="selectable-list">
		<xsl:apply-templates select="entry"/>
	</dl>
</xsl:template>

<xsl:template match="all-types/entry">
	<dt id="{name/@handle}" class="group"><xsl:value-of select="name/text()"/></dt>
	<xsl:apply-templates select="//all-keywords/entry[type/item/@id = current()/@id]"/>
</xsl:template>

<xsl:template match="all-keywords/entry">
	<dd id="{name/@handle}" class="item">
		<a href="#/keywords/{name/@handle}/" data-href="{$root}/keywords/{name/@handle}/">
			<xsl:value-of select="name/text()"/>
		</a>
	</dd>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
	<xsl:text> &#8212; </xsl:text>
	<xsl:value-of select="$page-title"/>
</xsl:template>

</xsl:stylesheet>
