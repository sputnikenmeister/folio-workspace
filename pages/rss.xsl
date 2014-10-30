<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
		 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		 xmlns:content="http://purl.org/rss/1.0/modules/content/"
		 xmlns:wfw="http://wellformedweb.org/CommentAPI/"
		 xmlns:dc="http://purl.org/dc/elements/1.1/"
		 xmlns:atom="http://www.w3.org/2005/Atom"
		 xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
		 xmlns:slash="http://purl.org/rss/1.0/modules/slash/">

<xsl:import href="../utilities/date-time-simple.xsl" />
<xsl:import href="../utilities/cdata-value.xsl" />

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:template match="data">
	<rss version="2.0" >
		<channel>
			<title><xsl:value-of select="$website-name"/></title>
			<atom:link href="{$root}/rss/" rel="self" type="application/rss+xml" />
			<link><xsl:value-of select="$root"/></link>
			<description><xsl:value-of select="$website-name"/> Feed</description>
			<dc:creator>Pablo Canillas</dc:creator>
			<!--
			<lastBuildDate>
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="$now"/>
				<xsl:with-param name="format" select="'w, d m Y T'"/>
			</xsl:call-template>
			</lastBuildDate>
			-->
			<language>en</language>
			<sy:updatePeriod>weekly</sy:updatePeriod>
			<sy:updateFrequency>1</sy:updateFrequency>
			<generator>Symphony (build <xsl:value-of select="$symphony-version"/>)</generator>
			<xsl:apply-templates select="find-bundles/entry" />
		</channel>
	</rss>
</xsl:template>

<xsl:template match="find-bundles/entry" >
	<item>
		<title><xsl:value-of select="name"/></title>
		<link><xsl:value-of select="$root"/>/bundles/<xsl:value-of select="name/@handle"/>/</link>
		<pubDate>
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="completed"/>
				<xsl:with-param name="format" select="'w, d m Y T'"/>
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="translate($timezone,':','')"/>
		</pubDate>
		<guid isPermaLink="false"><xsl:value-of select="concat($root,'/bundles/',name/@handle,'/')" /></guid>
		
		<description>
			<xsl:call-template name="cdata-value">
				<xsl:with-param name="item" select="description" />
			</xsl:call-template>
		</description>
		
		<xsl:apply-templates select="keywords/item" />
		
		<content:encoded></content:encoded>
	</item>
</xsl:template>
	
<xsl:template match="keywords/item" >
	<!--<xsl:if test="(string-length(text()) &gt; 0) or (count(*) &gt; 0)">-->
		<category>
			<xsl:call-template name="cdata-value">
				<xsl:with-param name="item" select="name" />
			</xsl:call-template>
		</category>
	<!--</xsl:if>-->
</xsl:template>

<xsl:template match="*" mode="cdata">
	<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
	<xsl:copy-of select="* | text()" />
	<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
</xsl:template>

</xsl:stylesheet>