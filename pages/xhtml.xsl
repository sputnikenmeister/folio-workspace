<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/implode.xsl" />
<xsl:import href="../utilities/date-time-extended.xsl"/>
<xsl:import href="xhtml/master.xsl"/>

<xsl:template match="data" mode="navigation">
	<xsl:apply-templates select="all-bundles"/>
	<div id="bd-nav" class="template">
		<script id="bd-nav_tmpl" type="text/template" class="template">
			<a id="preceding-bundle" class="button" href="javascript:void(0)">{{preceding}}</a>
			<a id="following-bundle" class="button" href="javascript:void(0)">{{following}}</a>
			<a id="close-bundle" class="button" href="javascript:void(0)">Close</a>
		</script>
	</div>
	<div id="bd-detail">
		<script id="bd-detail_tmpl" type="text/template" class="template">
			<!--<h2 class="bundle-name">{{name}}</h2>-->
			<div class="completed meta pubDate">{{completed}}</div>
			<div class="description">{{description}}</div>
		</script>
	</div>
</xsl:template>

<xsl:template match="data">
	<div class="bd-content">
		<script id="bd-images_tmpl" type="text/template" class="template">
			<div id="bd-images" class="pageable" style="width: 480px; height: 350px;">
				<ul>
					<li class="template">
						<img src="" width="480" height="350" title="" alt="" />
						<div class="caption">{{image.description}}</div>
					</li>
				</ul>
				<div class="pageable-ctls template">
					<a class="preceding-button button" href="javascript:void(0)"></a>
					<a class="following-button button" href="javascript:void(0)"></a>
				</div>
			</div>
		</script>
	</div>
</xsl:template>

<xsl:template match="all-bundles">
	<ul id="bundles" class="mapped">
		<xsl:apply-templates select="entry"/>	
	</ul>
</xsl:template>

<xsl:template match="all-bundles/entry">
	<li id="{name/@handle}" class="item">
		<span class="completed meta pubDate">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="completed"/>
				<xsl:with-param name="format" select="'%y+;'"/>
			</xsl:call-template>
		</span>
		<h2 class="bundle-name">
			<a href="{$root}/xhtml/bundles/{name/@handle}/">
				<!--<xsl:apply-templates select="display-name/*" mode="html"/>-->
				<xsl:copy-of select="name/text()"/>
			</a>
		</h2>
	</li>
</xsl:template>

<!-- Overrides -->
<xsl:template name="page-title">
	<xsl:value-of select="$website-name"/>
</xsl:template>

</xsl:stylesheet>
