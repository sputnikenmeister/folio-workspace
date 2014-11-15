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
	<script type="text/javascript" src="{$workspace}/assets/js/vendor.js"></script>
	<!-- <script type="text/javascript" src="{$workspace}/assets/lib/jquery.js"></script> -->
	<!-- <script type="text/javascript" src="{$workspace}/assets/lib/hammer.js"></script> -->
	<!-- <script type="text/javascript" src="{$workspace}/assets/lib/underscore.js"></script> -->
	<!-- <script type="text/javascript" src="{$workspace}/assets/lib/backbone.js"></script> -->
	<!-- <script type="text/javascript" src="{$workspace}/assets/lib/modernizr.js"></script> -->
</xsl:template>

<!-- Footer Scripts -->
<xsl:template match="data" mode="html-footer-scripts">
	<!-- Bootstrap data -->
	<xsl:call-template name="inline-script">
	<xsl:with-param name="content">
	window.approot = "<xsl:value-of select="$root"/>";
	window.bootstrap = {
		<xsl:apply-templates select="/data/all-types" mode="output-json"/>,
		<xsl:apply-templates select="/data/all-keywords" mode="output-json"/>,
		<xsl:apply-templates select="/data/all-bundles" mode="output-json"/>,
		<xsl:apply-templates select="/data/all-images" mode="output-json"/>,
		<!-- <xsl:apply-templates select="/data/params/root" mode="output-json"/> -->
	};
	</xsl:with-param>
	</xsl:call-template>
	<!-- Application -->
	<script type="text/javascript" src="{$workspace}/assets/js/folio.js"></script>
</xsl:template>

<!-- Container HTML -->
<xsl:template match="data">
	<div id="navigation" class="navigation">
		<!-- all keywords+types -->
		<xsl:apply-templates select="all-types"/>
		<!-- all bundles-->
		<xsl:apply-templates select="all-bundles"/>
	</div>
	<div id="content" class="content viewport"></div>
</xsl:template>

<!-- bundle-list -->
<xsl:template match="all-bundles">
	<ul id="bundle-list" class="list selectable filterable">
		<xsl:apply-templates select="entry"/>
	</ul>
</xsl:template>

<!-- bundle-list item -->
<xsl:template match="all-bundles/entry">
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
