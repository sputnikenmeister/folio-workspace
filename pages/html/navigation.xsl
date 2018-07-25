<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- bundle-list list -->
<xsl:template match="bundles-all" mode="navigation">
	<ul id="bundle-list" class="list selectable filterable">
		<xsl:apply-templates select="entry" mode="navigation"/>
	</ul>
</xsl:template>

<!-- bundle-list list-item -->
<xsl:template match="bundles-all/entry" mode="navigation">
	<li class="list-item" data-id="{@id}" data-handle="{name/@handle}">
		<a href="{$root}/#bundles/{name/@handle}">
			<span class="completed meta pubDate" data-datetime="{completed/text()}">
				<xsl:value-of select="substring(completed/text(),1,4)"/>
			</span>
			<xsl:choose>
				<xsl:when test="display-name">
					<span class="name label display-name">
						<xsl:copy-of select="display-name/*[1]/* | display-name/*[1]/text()"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<span class="name label">
						<xsl:copy-of select="name/text()"/>
					</span>
				</xsl:otherwise>
			</xsl:choose>
		</a>
	</li>
</xsl:template>

<!-- keyword-list list -->
<xsl:template match="types-all" mode="navigation">
	<dl id="keyword-list" class="list selectable filterable grouped">
		<xsl:apply-templates select="entry" mode="navigation"/>
	</dl>
</xsl:template>

<!-- keyword-list list-group -->
<xsl:template match="types-all/entry" mode="navigation">
	<dt class="list-group" data-id="{@id}" data-handle="{name/@handle}">
		<span class="name label">
			<span>
				<xsl:value-of select="name/text()"/>
			</span>
		</span>
	</dt>
	<xsl:apply-templates select="/data/keywords-all/entry[type/item/@id = current()/@id]" mode="navigation"/>
</xsl:template>

<!-- keyword-list list-item -->
<xsl:template match="keywords-all/entry" mode="navigation">
	<dd class="list-item" data-id="{@id}" data-handle="{name/@handle}">
		<!-- <a data-href="{$root}/#keywords/{name/@handle}"> -->
		<a href="">
			<span class="name label">
				<xsl:value-of select="name/text()"/>
			</span>
		</a>
		<!-- </a> -->
	</dd>
</xsl:template>

</xsl:stylesheet>
