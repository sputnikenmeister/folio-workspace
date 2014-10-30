<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../../utilities/date-time-extended.xsl" />
<xsl:import href="../../utilities/implode.xsl" />
<xsl:import href="../../utilities/cdata-value.xsl" />

<!-- Label with no markup -->

<xsl:template name="csv-attribute">
	<xsl:param name="items" />
	<xsl:param name="attribute-name" select="'values'"/>
	<xsl:param name="separator" select="','"/>
	<xsl:if test="count($items) &gt; 0">
		<xsl:attribute name="{string($attribute-name)}">
			<xsl:call-template name="implode">
				<xsl:with-param name="items" select="$items" />
				<xsl:with-param name="separator" select="$separator" />
			</xsl:call-template>
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~ -->

<xsl:template match="name">
	<xsl:if test="(string-length(text()) &gt; 0) or (count(*) &gt; 0)">
		<label>
			<xsl:call-template name="cdata-value">
				<xsl:with-param name="item" select="." />
			</xsl:call-template>
		</label>
	</xsl:if>
</xsl:template>

<xsl:template match="description">
	<xsl:if test="(string-length(text()) &gt; 0) or (count(*) &gt; 0)">
		<description>
			<xsl:call-template name="cdata-value">
				<xsl:with-param name="item" select="." />
			</xsl:call-template>
		</description>
	</xsl:if>
</xsl:template>

<xsl:template match="attributes">
	<!-- attributes as csv -->
	<xsl:call-template name="csv-attribute">
		<xsl:with-param name="attribute-name" select="'attrs'" />
		<xsl:with-param name="items" select="item/text()" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="entry/completed">
	<!-- date -->
	<xsl:attribute name="completed">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="./text()" />
			<xsl:with-param name="format" select="'%0d;/%0m;/%y+;'" />
		</xsl:call-template>
	</xsl:attribute>
</xsl:template>

<!-- ~~~~~~~~~~~~~~~~~~~ -->

<!-- bundles -->
<xsl:template match="find-bundles/entry" mode="items">
	<bundle ID="{@id}" name="{name/@handle}">
		<!-- attributes as json -->
		<xsl:apply-templates select="attributes | completed" />
		<!-- keywords as csv -->
		<xsl:call-template name="csv-attribute">
			<xsl:with-param name="attribute-name" select="'keywordIDs'" />
			<xsl:with-param name="items" select="keywords/item[published = 'Yes']/@id" />
		</xsl:call-template>
		<!-- images as csv -->
		<xsl:call-template name="csv-attribute">
			<xsl:with-param name="attribute-name" select="'imageIDs'" />
			<xsl:with-param name="items" select="images/item[published = 'Yes']/@id" />
		</xsl:call-template>
		<!-- label -->
		<xsl:apply-templates select="name | description" />
	</bundle>
</xsl:template>

<xsl:template match="find-bundles/entry">
	<bundle ID="{@id}" name="{name/@handle}">
		<!-- attributes as json -->
		<xsl:apply-templates select="attributes | completed" />
		<!-- keywords as csv -->
		<xsl:call-template name="csv-attribute">
			<xsl:with-param name="attribute-name" select="'keywordIDs'" />
			<xsl:with-param name="items" select="keywords/item[published = 'Yes']/@id" />
		</xsl:call-template>
		<!-- label -->
		<xsl:apply-templates select="name | description" />
		<!-- images -->
		<xsl:apply-templates select="images/item[published = 'Yes']" />
	</bundle>
</xsl:template>

<!-- images -->
<xsl:template match="find-images/entry | images/item">
	<image ID="{@id}" width="{file/meta/@width}" height="{file/meta/@height}" source="{$root}/image/{{0}}{file/@path}/{file/filename/text()}">
		<xsl:apply-templates select="attributes" />
		<xsl:apply-templates select="description" />
	</image>
</xsl:template>

<!-- keywords -->
<xsl:template match="find-keywords/entry">
	<keyword ID="{@id}" name="{name/@handle}" typeID="{type/item/@id}">
		<!-- bundles as csv -->
		<xsl:call-template name="csv-attribute">
			<xsl:with-param name="attribute-name" select="'bundleIDs'" />
			<xsl:with-param name="items" select="//find-bundles/entry[keywords/item/@id = current()/@id]/@id" />
		</xsl:call-template>
		<!-- label -->
		<xsl:apply-templates select="name" />
	</keyword>
</xsl:template>

<!-- types -->
<xsl:template match="find-types/entry">
	<type ID="{@id}" name="{name/@handle}" order="{position()}">
		<!-- keywords as csv -->
		<xsl:call-template name="csv-attribute">
			<xsl:with-param name="attribute-name" select="'keywordIDs'" />
			<xsl:with-param name="items" select="//find-keywords/entry[type/item/@id = current()/@id]/@id" />
		</xsl:call-template>
		<!-- label -->
		<xsl:apply-templates select="name" />
	</type>
</xsl:template>

</xsl:stylesheet>