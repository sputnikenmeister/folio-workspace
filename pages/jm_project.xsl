<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/typography.xsl"/>
<xsl:import href="../utilities/date-time-extended.xsl"/>

<xsl:output method="html" omit-xml-declaration="yes" indent="yes" encoding="UTF-8" />


<xsl:template match="/">
	<div id="content" class="projects">
		<xsl:apply-templates select="data/bundles-by-handle/entry[position() = 1]"/>
	</div>
</xsl:template>

<xsl:template match="bundles-by-handle/entry">
	<div id="subnav"></div>
	<div id="cache"></div>
	
	<!--	Images	-->
	<div id="visuels" class="scrollable">
		<xsl:apply-templates select="images/item[published/text() = 'Yes']"/>
	</div>
	
	<!-- Project Nav -->
	<div id="infos">
		<div id="subnav-2">
			<!-- Preceding -->
			<xsl:variable name="prev" select="//all-bundles/entry[@id = current()/@id]/preceding-sibling::entry[1]"/>
			<a id="prevProject" class="int"
			   href="/project/{$prev/name/@handle}.html"
			   data-href="/project/{$prev/name/@handle}"
			   data-key="{$prev/@id}"
			   data-pos="NaN">
				<span>Previous project</span>
			</a>
			<!-- Following -->
			<xsl:variable name="next" select="//all-bundles/entry[@id = current()/@id]/following-sibling::entry[1]"/>
			<a id="nextProject" class="int"
				data-href="/project/{$next/name/@handle}"
				href="/project/{$next/name/@handle}.html"
				data-key="{$next/@id}"
				data-pos="NaN">
				<span>Next Project</span></a>
			<!-- Back -->
			<a data-href="/home" href="index.html" class="int" id="closeProject"><span>Close Project</span></a>
		</div>
		<!-- Name -->
		<h3>
			<xsl:value-of select="name/text()"/>
		</h3>
		<!--- Date -->
		<h5>
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="completed"/>
				<xsl:with-param name="format" select="'%m+; %y+;'"/>
			</xsl:call-template>
		</h5>
		<!-- Keywords -->
		<p class="tags">
			<span class="shortdesc"><xsl:value-of select="name/text()"/><br/>~</span>
			<xsl:apply-templates select="keywords/item[published/text() = 'Yes']"/>
		</p>
		<!-- Description -->
		<!--<xsl:apply-templates select="description/*" mode="html"/>-->
		
		<!--<h6>10 sur 20</h6>-->
		<!--<a class="visit" href="http://hostname" target="_blank">Visit</a>-->
		<!--<a class="share" href="">+ Tweet</a>-->
	</div>
</xsl:template>

<xsl:template match="images/item">
	<!-- Image width variable -->
	<xsl:variable name="w" select="716" />
	<xsl:variable name="h" select="floor(($w div file/meta/@width) * file/meta/@height)" />
	
	<img id="visuel-{position()}" width="{$w}" height="{$h}"/>
	<div id="legend-{position()}" class="visuel-legend"> </div>
	<span class="name">
		<xsl:value-of select="concat($root,'/image/1/',$w,'/0',file/@path,'/',file/filename)"/>
	</span>
</xsl:template>

<xsl:template match="keywords/item">
	<xsl:value-of select="name/text()"/>
	<xsl:if test="position() != last()">
		<br/><!--<xsl:text>, </xsl:text>-->
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
