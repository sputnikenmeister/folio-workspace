<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
