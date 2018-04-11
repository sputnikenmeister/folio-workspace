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

<!-- <xsl:variable name="is-logged-in" select="true()"/> -->
<xsl:variable name="is-logged-in" select="boolean(/data/author-logged-in/author[@user-type = 'developer'])"/>

<xsl:variable name="page-class" select="concat($current-page, '-page')"/>
<xsl:variable name="layout-class">
	<xsl:choose>
		<xsl:when test="count(/data/params/url-layout) = 0">
			<xsl:value-of select="'left-layout'"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat(/data/params/url-layout/text(), '-layout')"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="document-classes" select="'app-initial'"/>
<xsl:variable name="body-classes" select="concat($page-class,' ', $layout-class,' app-initial')"/>

<xsl:template match="/">
<html lang="en">
	<head>
		<!-- <head profile="http://gmpg.org/xfn/11"> -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		<xsl:if test="/data/params/page-types/item[@handle='xhtml']">
			<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/>
		</xsl:if>
		<title><xsl:call-template name="page-title"/></title>
		<!-- <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1"/> -->
		<meta name="viewport" content="user-scalable=no, width=device-width, height=device-height, initial-scale=1, maximum-scale=1"/>
		<!-- <meta name="author" content="{$root}/humans.txt"/>-->
		<!-- <meta name="description" content="no description"/> -->
		<!-- <link rel="canonical" href="{$root}/"/>--><!-- cf. https://support.google.com/webmasters/answer/139066?hl=en#1 -->
		<link rel="alternate" type="application/rss+xml" href="{$root}/rss"/>
		<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
		<xsl:apply-templates select="data" mode="html-head-scripts"/>
	</head>
<!--[if lt IE 9 ]>
	<body class="ie ie8 {$body-classes}">
<![endif]--><!--[if IE 9 ]>
	<body class="ie ie9 {$body-classes}">
<![endif]--><!--[if gt IE 9]>
	<body class="ie {$body-classes}">
<![endif]--><!--[if !IE]><!-->
	<body class="{$body-classes}">
<!--<![endif]-->
		<div id="container">
			<!--<div id="header" class="header"><h3>Subheader</h3></div>-->
			<xsl:apply-templates select="data"/>
			<!--<div id="container-footer"></div>-->
			<div id="unsupported">
				<h2 class="color-ln">Portfolio</h2>
				<p>A layout for mobile-sized screens is not yet ready… Please use a tablet or computer to view this website.</p>
				<p class="contact">You can reach me at <a href="mailto:blah@nowhere.tld">blah@nowhere.tld</a> or <a href="https://www.linkedin.com/in/pablo-canillas" rel="noopener noreferrer" target="_blank">view my profile on LinkedIn</a></p>
			</div>
		</div>
		<!--
		<div id="footer" class="footer">
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
		</dl>
		-->
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
		<span class="name label">
			<span>
				<xsl:value-of select="name/text()"/>
			</span>
		</span>
	</dt>
	<xsl:apply-templates select="/data/keywords-all/entry[type/item/@id = current()/@id]"/>
</xsl:template>

<xsl:template match="keywords-all/entry">
	<dd class="list-item" data-id="{@id}">
		<a href="{$root}/#keywords/{name/@handle}">
			<span class="name label">
				<xsl:value-of select="name/text()"/>
			</span>
		</a>
	</dd>
</xsl:template>

<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
	<xsl:text> &#8212; </xsl:text>
	<xsl:value-of select="$page-title"/>
</xsl:template>

</xsl:stylesheet>
