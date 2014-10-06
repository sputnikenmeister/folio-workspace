<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="jm/bundle-item.xsl"/>
<xsl:output method="html" omit-xml-declaration="yes" indent="yes" encoding="UTF-8" />

<xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Otto Cualquiera</title>
        <link rel="shortcut icon" href="{$workspace}/assets-jm/images/favicon.ico"/>
        <meta name="description" content="Personal portfolio of Art director and Graphic designer Otto Cualquiera"/>
        <meta name="keywords" content="Otto Cualquiera, Art director, Graphic designer, Webdesigner, Senior Art Director"/>
        <!-- Javascript -->
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/jquery-ui-1.8.18.min.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/jquery.easing.1.3.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/jquery.color.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/smartpreload.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/jquery.mousewheel.min.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/jquery.address.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/lib/winresize.js"></script>
        <script type="text/javascript" src="{$workspace}/assets-jm/js/jm.js?time=1364581444"></script>
        <!-- Css -->
        <link rel="stylesheet" type="text/css" href="{$workspace}/assets-jm/css/jm.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="{$workspace}/assets-jm/css/jm-responsive.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="{$workspace}/assets-jm/fonts/CalibreWeb.css" media="screen"/>
    </head>

    <body>
		<!-- <div id="awwwards" class="dark"><a href="http://www.awwwards.com/" target="_blank"></a></div> -->
        <!-- <script type="text/javascript">

          var _gaq = _gaq || [];
          _gaq.push(['_setAccount', 'UA-21270433-1']);
          _gaq.push(['_trackPageview']);
        //gaq.push(['_trackPageview', document.location.pathname +     document.location.hash.replace("#!/","")])

          (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
          })();

        </script>
        -->
        <div id="top">
            <div id="nav">
                <div id="logo">
                    <div><img src="{$workspace}/assets-jm/images/logo-large-ju.png"/></div>
                    <h4>Otto Cualquiera</h4>
                    <h5>Art Director, Graphic Designer</h5>
                </div>
                <div id="menu">
                    <ul>
                        <li><a class="int" id="link-home" href="index.html" data-href="/home">Index</a></li>
                        <li><a class="int" id="link-play" href="play.html" data-href="/play">Play</a></li>
                        <li><a class="int" id="link-annex" href="annex.html" data-href="/annex">Annex</a></li>
                        <li><a class="int" id="link-contact" href="contact.html" data-href="/contact">Contact</a></li>
                    </ul>
                </div>
            </div>
            <div id="header">
                <h1>
                    <span class="first">Otto </span>
                    <span class="second">Cualquiera</span>
                </h1>
                <h2></h2>
            </div>
            <div id="preloading">
                <div id="totalBytes"><div id="loadedBytes"></div></div>
                <span class="current"></span>
                <span class="total"></span>
            </div>
        </div>
        <div id="scrollContainer">
            <div id="scrollBar">
            </div>
        </div>
        <div id="preloadPage">Loading</div>
        <div id="container">
            <div id="content" class="index scrollable">
    			<div id="projects">
    				<xsl:apply-templates select="//bundles-by-id/entry"/>
    				<xsl:apply-templates select="//bundles-by-id/error"/>
                </div>
			</div>
        </div>
        <div id="footer">
            <div id="path">
                <h4>Location</h4>
                <h5>index of <a class="int" href="#">cualquiera.com</a>  / home</h5>
            </div>
            <div id="connect">
                <h4>Connect</h4>
                <h5><a href="mailto:otto@cualquiera.com">otto@cualquiera.com</a>  •  <a href="https://plus.google.com/" target="_blank">Google+</a>  •  <a href="https://twitter.com/" target="_blank">Follow Me !</a>  •  <a href="http://www.linkedin.com/" target="_blank">LinkedIn</a></h5>
            </div>
        </div>
    </body>
</html>
</xsl:template>

</xsl:stylesheet>