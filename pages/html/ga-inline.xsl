<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:s="http://exslt.org/strings"
	extension-element-prefixes="s">

<xsl:include href="inline-script.xsl"/>

<xsl:template name="ga-inline">
	<xsl:param name="tracking-id" select="'GA-00000-X'"/>
	<xsl:param name="debug" select="'false'"/>
	<xsl:param name="trace" select="'false'"/>
	<xsl:param name="send-pageview" select="'false'"/>
	<xsl:param name="ignore-regex" select="'(?:(localhost|\.local))$'"/>
	<xsl:param name="output-cdata" select="'false'"/>

	<xsl:variable name="content">
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','https://www.google-analytics.com/analytics<xsl:if test="$debug">_debug</xsl:if>.js','ga');

		<xsl:if test="$debug">
		window.ga_debug = {
			trace: <xsl:value-of select="$trace"/>
		};
		</xsl:if>

		window.ga('create', '<xsl:value-of select="$tracking-id"/>', 'auto');

		<xsl:if test="$ignore-regex">
		if (/<xsl:value-of select="$ignore-regex"/>/.test(location.hostname))
			window.ga('set', 'sendHitTask', null);
		</xsl:if>

		<xsl:if test="$send-pageview">
		ga('send', 'pageview');
		</xsl:if>
	</xsl:variable>

	<xsl:call-template name="inline-script">
		<xsl:with-param name="cdata" select="$output-cdata"/>
		<xsl:with-param name="content" select="s:replace(normalize-space($content), ' ', '')"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
