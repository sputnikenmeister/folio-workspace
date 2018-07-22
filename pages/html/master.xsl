<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:exsl="http://exslt.org/common"
xmlns:date="http://exslt.org/dates-and-times"
extension-element-prefixes="exsl date">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<xsl:include href="inline-script.xsl"/>
<xsl:include href="favicon.xsl"/>
<xsl:include href="navigation.xsl"/>

<!-- Params & Variables -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<xsl:param name="url-force-debug" select="'false'"/>
<xsl:param name="url-force-nodebug" select="'false'"/>

<xsl:variable name="debug" select="boolean(not($url-force-debug = 'false')
		or /data/author-logged-in/author[@user-type = 'developer']
		and boolean($url-force-nodebug = 'false'))"/>

<xsl:variable name="is-xhtml" select="boolean(/data/params/page-types/item/@handle = 'xhtml')"/>
<xsl:variable name="tstamp">
	<xsl:if test="$debug">?<xsl:value-of select="date:seconds()"/></xsl:if>
</xsl:variable>

<xsl:variable name="app-classes">
	<xsl:text>app app-initial route-initial</xsl:text>
	<xsl:if test="$debug"><xsl:text> debug</xsl:text></xsl:if>
</xsl:variable>

<xsl:variable name="document-classes" select="$app-classes"/>
<xsl:variable name="body-classes" select="''"/>
<xsl:variable name="container-classes" select="''"/>

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- Root entry point -->
<!-- - - - - - - - - - - - - - - - - - - - - -->

<xsl:template match="/">
<!-- IE conditional comments BEGIN -->
<!-- <xsl:comment><![CDATA[[if lte IE 9]><html lang="en" class="ie ie9 ]]><xsl:value-of select="$document-classes"/><![CDATA["><![endif]]]></xsl:comment> -->
<!-- <xsl:comment><![CDATA[[if gt IE 9]><html lang="en" class="ie ]]><xsl:value-of select="$document-classes"/><![CDATA["><![endif]]]></xsl:comment> -->
<!-- <xsl:comment><![CDATA[[if !IE]><!]]></xsl:comment> -->
<html lang="en" class="{$document-classes}">
<!-- <xsl:comment><![CDATA[<![endif]]]></xsl:comment> -->
<!-- IE conditional comments END -->
	<head>
		<!-- <head profile="http://gmpg.org/xfn/11"> -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		<xsl:if test="/data/params/page-types/item[@handle='xhtml']">
			<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/>
		</xsl:if>
		<title><xsl:call-template name="page-title"/></title>
		<!-- <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1"/> -->
		<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1"/> -->
		<meta name="viewport" content="user-scalable=no, width=device-width, height=device-height, initial-scale=1, maximum-scale=1"/>
		<!-- <meta name="viewport" content="user-scalable=no, width=440, height=540, initial-scale=1, maximum-scale=1"/> -->

		<!-- <meta name="author" content="{$root}/humans.txt"/>-->
		<!-- <meta name="description" content="no description"/> -->

		<!-- cf. https://support.google.com/webmasters/answer/139066?hl=en#1 -->
		<!-- <link rel="canonical" href="{$root}/"/> -->
		<xsl:apply-templates select="data" mode="html-head"/>
	</head>
<!-- IE conditional comments BEGIN -->
<xsl:comment><![CDATA[[if lte IE 9]><body class="ie ie9 ]]><xsl:value-of select="$body-classes"/><![CDATA["><![endif]]]></xsl:comment>
<xsl:comment><![CDATA[[if gt IE 9]><body class="ie ]]><xsl:value-of select="$body-classes"/><![CDATA["><![endif]]]></xsl:comment>
<xsl:comment><![CDATA[[if !IE]><!]]></xsl:comment>
	<body class="{$body-classes}">
<xsl:comment><![CDATA[<![endif]]]></xsl:comment>
<!-- IE conditional comments END -->
		<xsl:apply-templates select="data" mode="html-body-first"/>
		<div id="container" class="{$container-classes}">
			<xsl:apply-templates select="data"/>
		</div>
		<xsl:apply-templates select="data" mode="html-body-last"/>
	</body>
</html>
</xsl:template>

<!-- Abstract -->
<xsl:template match="data" mode="html-head"></xsl:template>
<!-- Abstract -->
<xsl:template match="data" mode="html-body-first"></xsl:template>
<!-- Abstract -->
<xsl:template match="data"></xsl:template>
<!-- Abstract -->
<xsl:template match="data" mode="html-body-last"></xsl:template>


<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
	<xsl:text> &#8212; </xsl:text>
	<xsl:value-of select="$page-title"/>
</xsl:template>

</xsl:stylesheet>
