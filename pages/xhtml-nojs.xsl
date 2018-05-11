<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:exsl="http://exslt.org/common"
	 extension-element-prefixes="exsl">

<xsl:import href="xhtml/master.xsl"/>
<xsl:include href="xhtml/favicon.xsl"/>
<!-- $is-logged-in defined in xhtml/master.xsl -->

<!-- Page Title -->
<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

<!-- Head Scripts -->
<xsl:template match="data" mode="html-head">
	<xsl:call-template name="favicon">
		<xsl:with-param name="url-prefix" select="concat($workspace, '/assets/images/favicon')"/>
	</xsl:call-template>
	<link rel="stylesheet" type="text/css" href="{$workspace}/assets/css/folio-compat.css"/>
</xsl:template>

<!-- Footer Scripts -->
<xsl:template match="data" mode="html-body-last">
	<!-- Library bundle -->
	<script type="text/javascript" src="{$workspace}/assets/js/folio-compat.js"></script>
</xsl:template>

<!-- Container HTML -->
<xsl:template match="data">
	<div id="navigation" class="navigation">
		<h1 id="site-name">
			<a href="{$root}/"><xsl:value-of select="$website-name"/></a>
		</h1>
		<!-- all bundles-->
		<xsl:apply-templates select="bundles-all"/>
		<!-- all keywords+types -->
		<xsl:apply-templates select="types-all"/>
	</div>
	<div id="content" class="content viewport"></div>
</xsl:template>

<!-- bundle-list -->
<xsl:template match="bundles-all">
	<ul id="bundle-list" class="list selectable filterable">
		<xsl:apply-templates select="entry"/>
	</ul>
</xsl:template>

<!-- bundle-list item -->
<xsl:template match="bundles-all/entry">
	<li class="list-item" data-id="{@id}">
		<a href="{$root}/bundles/{name/@handle}">
			<span class="completed meta pubDate" data-datetime="{completed/text()}">
				<xsl:value-of select="substring(completed/text(),1,4)"/>
			</span>
			<xsl:choose>
				<xsl:when test="display-name">
					<span class="name display-name">
						<xsl:copy-of select="display-name/*[1]/* | display-name/*[1]/text()"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<span class="name">
						<xsl:copy-of select="name/text()"/>
					</span>
				</xsl:otherwise>
			</xsl:choose>
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>
