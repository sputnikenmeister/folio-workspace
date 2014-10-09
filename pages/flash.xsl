<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="no"
	encoding="UTF-8"
	indent="yes" />

<xsl:variable name="approot">
	<xsl:choose>
		<xsl:when test="$url-debug = 'flash'">
			<xsl:value-of select="concat($workspace,'/assets/flash/debug')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($workspace,'/assets/flash/release')"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="installswf" select="concat($workspace,$approot,'/playerProductInstall.swf')">

<xsl:template match="/" mode="swfobject-dyn">
<html lang="en" xml:lang="en" class="flash">
<head>
	<title><xsl:value-of select="$website-name"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/flash.min.css" />
	<link rel="stylesheet" type="text/css" href="{$approot}/history/history.css" />	
	<script type="text/javascript" src="{$approot}/history/history.js"></script>
	<script type="text/javascript" src="{$approot}/swfobject.js"></script>
	<script type="text/javascript">
		swfobject.registerObject("FolioApp", "10.2.0", "<xsl:value-of select="$installswf"/>");
	</script>
<!--
<xsl:comment>
	<xsl:copy-of disable-output-escaping="yes" select="data/params" />
</xsl:comment>
-->
</head>
<body>
	<div id="flash">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			width="100%" height="100%" id="FolioApp" name="FolioApp" align="middle">
			<param name="movie" value="{$approot}/FolioApp.swf" />
			<param name="menu" value="false" />
			<param name="scale" value="noscale" />
			<param name="wMode" value="opaque" />
			<param name="bgcolor" value="#FFFFFF" />
			<param name="swLiveConnect" value="true" />
			<param name="allowScriptAccess" value="sameDomain"/>
			<param name="allowfullscreen" value="true" />
			<!--[if !IE]>-->
			<object type="application/x-shockwave-flash" data="{$approot}/FolioApp.swf"
				width="100%" height="100%" align="middle">
				<param name="menu" value="false" />
				<param name="scale" value="noscale" />
				<param name="wMode" value="opaque" />
				<param name="bgcolor" value="#FFFFFF" />
				<param name="swLiveConnect" value="true" />
				<param name="allowScriptAccess" value="sameDomain"/>
				<param name="allowfullscreen" value="true" />
			<!--<![endif]-->
				<div id="alt" class="noflash">
					<span class="flash-logo"> </span>
					<span><strong>Flash Player version 10.2 or greater</strong> is required to view this page. It is a free download at <a href="http://www.adobe.com/go/getflashplayer">Adobe's website</a>.</span>
				</div>
			<!--[if !IE]>-->
			</object>
			<!--<![endif]-->
			<xsl:comment><![CDATA[[[if !IE]>]]></xsl:comment>
			<!-- sooo?-->
			<xsl:comment><![CDATA[[<![endif]]]></xsl:comment>
		</object>
	</div>
</body>
</html>
</xsl:template>
	
<xsl:template match="/">
<html lang="en" xml:lang="en" class="flash">
<head>
	<title><xsl:value-of select="$website-name"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/flash.min.css" />	
	<link rel="stylesheet" type="text/css" href="{$approot}/history/history.css" />
	<script type="text/javascript" src="{$approot}/history/history.js"></script>
	<script type="text/javascript" src="{$approot}/swfobject.js"></script>
</head>
<body>
	<div id="flash">
		<div id="alt" class="noflash">
			<span class="flash-logo"> </span>
			<span><strong>Flash Player version 10.2 or greater</strong> is required to view this page. It is a free download at <a href="http://www.adobe.com/go/getflashplayer">Adobe's website</a>.</span>
		</div>
	</div>
	<script type="text/javascript">
	var xpinst 		= "<xsl:value-of select="$installswf"/>";
	var swf_url 	= "<xsl:value-of select="$approot"/>/FolioApp.swf";
	var swf_vars 	= {};
	var swf_attrs 	= { id: "FolioApp", name: "FolioApp", align: "middle" };
	var swf_params 	= { menu: "false", quality: "high", bgcolor: "#FFFFFF", allowfullscreen: "true", swliveconnect: "true" };
	
	/** swfobject callback (swfobject.embedSWF), exec'd after the swf is created and initialized */
	var swfobject_completeHandler = function (status) {
		if (status.success) {
			//status.ref.tabIndex = 0;
			status.ref.focus();
		}
	};
	swfobject.embedSWF(swf_url, "flash", "100%", "100%", "10.2.0", xpinst, swf_vars, swf_params, swf_attrs, swfobject_completeHandler);
	</script>
</body>
</html>
</xsl:template>

</xsl:stylesheet>