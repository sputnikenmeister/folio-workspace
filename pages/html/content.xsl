<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- HTML item templates -->
<!-- - - - - - - - - - - - - - - - - - - - - -->
<!-- article-view item -->
<xsl:template match="articles-all/entry">
	<article id="{name/@handle}" class="article-view" data-id="{@id}">
		<xsl:apply-templates select="text/*" mode="html"/>
		<!-- <xsl:copy-of select="text/* | text/text()" /> -->
	</article>
</xsl:template>

<!-- article-view item -->
<xsl:template match="articles-system/entry">
	<div id="{name/@handle}" class="system-view" data-id="{@id}">
		<h2 class="color-ln">
			<xsl:copy-of select="display-name/*[1]/* | display-name/*[1]/text()"/>
		</h2>
		<xsl:apply-templates select="text/* | text/text()" mode="html"/>
	</div>
</xsl:template>

</xsl:stylesheet>
