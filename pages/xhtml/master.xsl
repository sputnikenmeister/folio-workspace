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
		<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> -->
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/>
		<title><xsl:call-template name="page-title"/></title>
		<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1"/>
		<meta name="author" content="{$root}/humans.txt"/>
		<!-- <meta name="description" content="no description"/> -->
		<link rel="canonical" href="{$root}/"/><!-- cf. https://support.google.com/webmasters/answer/139066?hl=en#1 -->
		<link rel="alternate" type="application/rss+xml" href="{$root}/rss"/>
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
			<p class="copyright">&#169; 1995-2014 Pablo Canillas</p>
		</div>

		<xsl:if test="$is-logged-in = 'true'">
		<div id="debug">
			<dl id="symphony-links">
				<dt>Tools</dt>
				<dd><a href="{$root}/symphony/">Backend</a></dd>
				<dd><a href="?debug=xml">Debug</a></dd>
			</dl>
		</div>
		</xsl:if>

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

<xsl:template match="types-all">
	<dl id="keyword-list" class="list selectable filterable grouped">
		<xsl:apply-templates select="entry"/>
	</dl>
</xsl:template>

<xsl:template match="types-all/entry">
	<dt id="t{@id}" class="list-group">
		<span><xsl:value-of select="name/text()"/></span>
	</dt>
	<xsl:apply-templates select="/data/keywords-all/entry[type/item/@id = current()/@id]"/>
</xsl:template>

<xsl:template match="keywords-all/entry">
	<dd id="k{@id}" class="list-item">
		<a href="{$root}/keywords/{name/@handle}">
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
