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

<xsl:variable name="is-logged-in" select="true()"/>
<!--<xsl:variable name="is-logged-in" select="/data/author-logged-in/author/@user-type = 'developer'"/>-->
<!-- <xsl:variable name="body-classes" select="concat($current-page, '-page')"/> -->
<xsl:variable name="document-classes" select="'app-initial'"/>
<xsl:variable name="body-classes">
	<!-- <xsl:value-of select="concat($current-page, '-page')"/>
	<xsl:if test="$url-layout">
		<xsl:value-of select="concat(' ', $url-layout, '-layout')"/>
	</xsl:if> -->
	<xsl:choose>
		<xsl:when test="$url-layout">
			<xsl:value-of select="concat($current-page, '-page ', $url-layout, '-layout')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($current-page, '-page default-layout')"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template match="/">
<html lang="en" class="{$document-classes}">
	<head>
	<!-- <head profile="http://gmpg.org/xfn/11"> -->
		<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> -->
		<xsl:if test="/data/params/page-types/item[@handle='xhtml']">
			<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/>
		</xsl:if>
		<title><xsl:call-template name="page-title"/></title>
		<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1"/>
		<!-- <meta name="viewport" content="user-scalable=no, width=device-width, height=device-height, initial-scale=1, maximum-scale=1"/>-->
		<!-- <meta name="author" content="{$root}/humans.txt"/>-->
		<!-- <meta name="description" content="no description"/> -->
		<!-- <link rel="canonical" href="{$root}/"/>--><!-- cf. https://support.google.com/webmasters/answer/139066?hl=en#1 -->
		<link rel="alternate" type="application/rss+xml" href="{$root}/rss"/>
		<xsl:apply-templates select="data" mode="html-head-scripts"/>
	</head>
<!--[if lt IE 7 ]>
	<body class="ie ie6 {$body-classes}">
<![endif]--><!--[if IE 7 ]>
	<body class="ie ie7 {$body-classes}">
<![endif]--><!--[if IE 8 ]>
	<body class="ie ie8 {$body-classes}">
<![endif]--><!--[if IE 9 ]>
	<body class="ie ie9 {$body-classes}">
<![endif]--><!--[if gt IE 9]>
	<body class="ie {$body-classes}">
<![endif]--><!--[if !IE]><!-->
	<body class="{$body-classes}">
<!--<![endif]-->
		<div id="container">
			<!--<div id="header" class="header">
				<h3>Subheader</h3>
			</div>-->
			<xsl:apply-templates select="data"/>
			<!--<div id="container-footer"></div>-->
		</div>
		<!--<div id="footer" class="footer">
			<p class="copyright">&#169; 1995-2014 Pablo Canillas</p>
		</div>
 		<dl id="debug-toolbar" class="toolbar">
			<dt>Debug</dt>
			<xsl:if test="$is-logged-in = 'true'">
			<dd><a id="edit-backend" href="{$root}/symphony/" target="_blank">Edit Backend</a></dd>
			<dd><a id="source" href="?debug=xml" target="_blank">Source</a></dd>
			</xsl:if>
			<dd><a id="show-grid" href="javascript:(void 0)">Grid</a></dd>
			<dd><a id="show-blocks" href="javascript:(void 0)">Blocks</a></dd>
		</dl>-->
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
	<dt class="list-group" data-id="{@id}">
		<span class="name"><xsl:value-of select="name/text()"/></span>
	</dt>
	<xsl:apply-templates select="/data/keywords-all/entry[type/item/@id = current()/@id]"/>
</xsl:template>

<xsl:template match="keywords-all/entry">
	<dd class="list-item" data-id="{@id}">
		<a href="{$root}/keywords/{name/@handle}">
			<span class="name"><xsl:value-of select="name/text()"/></span>
		</a>
	</dd>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
	<xsl:text> &#8212; </xsl:text>
	<xsl:value-of select="$page-title"/>
</xsl:template>

</xsl:stylesheet>
