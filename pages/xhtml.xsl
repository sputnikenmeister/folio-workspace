<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	 xmlns:exsl="http://exslt.org/common"
	 extension-element-prefixes="exsl">

<xsl:import href="json/output-short.xsl"/>
<xsl:import href="xhtml/master.xsl"/>
<xsl:include href="xhtml/inline-script.xsl"/>

<!-- Page Title -->
<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

<!-- Head Scripts -->
<xsl:template match="data" mode="html-head-scripts">
	<!-- Library bundle -->
	<!-- <script type="text/javascript" src="{$workspace}/assets/lib/modernizr.js"></script> -->
	<!-- <script type="text/javascript" src="http://modernizr.com/downloads/modernizr.js"></script> -->
</xsl:template>

<!-- Footer Scripts -->
<xsl:template match="data" mode="html-footer-scripts">
	<!-- Bootstrap data -->
	<xsl:call-template name="inline-script">
	<xsl:with-param name="content">
	window.DEBUG = <xsl:value-of select="$is-logged-in"/>;<!-- $is-logged-in defined in xhtml/master.xsl -->
	window.approot = "<xsl:value-of select="$root"/>";
	window.bootstrap = {
	<xsl:apply-templates select="/data/types-all" mode="output-json"/>,
	<xsl:apply-templates select="/data/keywords-all" mode="output-json"/>,
	<xsl:apply-templates select="/data/bundles-all" mode="output-json"/>,
	<xsl:apply-templates select="/data/images-all" mode="output-json"/>
	};
	document.body.className = "app-init";
	</xsl:with-param>
	</xsl:call-template>
	<!-- Application -->
	<script type="text/javascript" src="{$workspace}/assets/js/folio-vendor.min.js"></script>
	<script type="text/javascript" src="{$workspace}/assets/js/folio-client.js"></script>
<!--	<script type="text/javascript" src="{$workspace}/assets/js/folio.js"></script>-->
</xsl:template>

<!-- Container HTML -->
<xsl:template match="data">
	<div id="navigation" class="navigation">
		<!-- all keywords+types -->
		<xsl:apply-templates select="types-all"/>
		<!-- all bundles-->
		<xsl:apply-templates select="bundles-all"/>
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
	<li id="b{@id}" class="list-item">
		<span class="completed meta pubDate" data-datetime="{completed/text()}">
			<xsl:value-of select="substring(completed/text(),1,4)"/>
		</span>
		<a class="name" href="{$root}/bundles/{name/@handle}">
			<xsl:choose>
				<xsl:when test="display-name">
					<xsl:apply-templates select="display-name/*[1]/*" mode="html"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="name/text()"/>
				</xsl:otherwise>
			</xsl:choose>
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>
