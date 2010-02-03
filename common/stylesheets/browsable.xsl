<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:include href="./common.xsl"/>
  
  <!-- ======================================================================-->  
  <!-- Process an entire document into an HTML page -->
  <!-- ======================================================================--> 
  <xsl:template match="document">
    
    <xsl:variable name="project" select="document($project-file)/project"/>
    <xsl:variable name="filename" select="properties/filename"/>
    <xsl:variable name="html-filename">
      <xsl:value-of select="substring-before($filename,'.xml')"/>
      <xsl:value-of select="$printable-html-suffix"/>
    </xsl:variable>
    <xsl:variable name="projectname">
	  <xsl:value-of select="$project/title"/>
	</xsl:variable>
    <xsl:variable name="path-to-root" select="properties/pathtoroot"/>       
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
        <meta http-equiv="Content-Language" content="en"/>
        <title><xsl:value-of select="$project/title"/> - <xsl:value-of select="properties/title"/></title>
	<xsl:variable name="description">
	  <xsl:value-of select="$project/description"/>
	</xsl:variable>
        <meta content="{$description}" name="Description"/>
	<xsl:variable name="keywords">
	  <xsl:value-of select="$project/keywords"/>
	</xsl:variable>
        <meta content="{$keywords}" name="Keywords"/>
        <meta content="webmaster@ow2.org" name="Reply-to"/>
        <meta content="OW2" name="Owner"/>
        <meta content="index, follow" name="Robots"/>	
        <xsl:for-each select="properties/author">
          <xsl:variable name="name">
            <xsl:value-of select="."/>
          </xsl:variable>
          <xsl:variable name="email">
            <xsl:value-of select="@email"/>
          </xsl:variable>
          <meta name="author" content="{$name}"/>
          <meta name="email" content="{$email}"/>
        </xsl:for-each>
        <script type="text/javascript" src="{$path-to-root}/js/objectweb.js"></script>
        <link id="stylesheet" rel="stylesheet" href="{$path-to-root}/common.css" type="text/css" />
        <link rel="icon" href="{$path-to-root}/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" href="{$path-to-root}/images/favicon.ico" type="image/x-icon" />
      </head>

      <body>
       
        <div id="mainOuter">
          <div id="banner">
            <div id="bannersearch">
              <form target="_blank" action="http://www.google.com/custom" method="get">
                <input name="cof" value="S:http://www.ow2.org/;GL:0;AH:center;LH:70;L:http://www.ow2.org/xwiki/skins/ow2/logo.png;LW:500;AWFID:48faba182d01f379;" type="hidden"/>
                <input name="domains" value="ow2.org;mail-archive.ow2.org" type="hidden"/>
                <input name="sitesearch" value="ow2.org" type="hidden"/>
                <table rowspan="0" colspan="0">
                  <tr>
                    <td>
                      <input onblur="if (this.value=='') this.value='search'" onfocus="this.value=''" value="" maxlength="255" size="10" name="q" type="text"/>
                    </td>
                    <td>
                      <input alt="Submit" onmouseover="MM_swapImage('search','','./images/menu/boutonsearch2.gif',1)" onmouseout="MM_swapImgRestore()" src="./images/menu/boutonsearch1.gif" id="search" name="sa" type="image"/>
                    </td>
                    <td>
                      <a href="{$html-filename}" target="_blank" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('print','','{$path-to-root}/images/menu/boutonprint2.gif',1)" alt="Submit">
                        <img src="{$path-to-root}/images/menu/boutonprint1.gif" alt="Print" name="print" width="20" height="20" border="0" id="print"/>
                      </a>
                    </td>
                  </tr>
                </table>
                <p class="glose">
                  <strong><a href="http://www.google.com/advanced_search?q=+site:ow2.org" target="_blank" class="lienglose">Advanced Search</a></strong> - Powered by Google
                </p>
              </form>
            </div>
            <div id="bannerLeft">
              <img src="images/logoow2.png"/>
            </div>
            <div id="bannerlink">
              <a class="bannerlinkleft" href="http://www.ow2.org/">Consortium</a>
              <a class="bannerlinkleft" href="http://www.ow2.org/xwiki/bin/view/Activities/Fundamentals">Activities</a>
              <a class="bannerlinkleft" href="http://www.ow2.org/xwiki/bin/view/Activities/Projects">Projects</a>
              <a class="bannerlinkleft" href="http://forge.objectweb.org/">Forge</a>
              <a class="bannerlinkleft" href="http://www.ow2.org/view/Events/">Events</a>
            </div>
          </div>
            
          <div id="centerOuter">
            <!--content-->
            <div id="contentOuter">
              <xsl:apply-templates select="body/s1"/>
            </div>
            <!--~content-->               
            <div id="menuOuter">
              <ul>
                <li>
                  <div><xsl:value-of select="$project/title"/></div>
                  <ul>
                    <xsl:apply-templates select="$project/body/menu">
                      <xsl:with-param name="path-to-root"><xsl:value-of select="$path-to-root"/></xsl:with-param>
                      <xsl:with-param name="filename"><xsl:value-of select="$filename"/></xsl:with-param>
                    </xsl:apply-templates>
                  </ul>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div id="footerOuter">
          <span>
            Copyright &#169; 1999-2010, <a href="http://www.ow2.org/">OW2 Consortium</a> 
            | <a href="mailto:webmaster@ow2.org">webmaster</a> 
            | Last modified at <xsl:value-of select="$last-modified"/>
          </span>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ======================================================================-->
  <!-- menu for the navigation bar -->
  <!-- ======================================================================--> 
  <xsl:template match="menu">
    
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:param name="filename"/>
    <li>
      <xsl:apply-templates select="legend | a | connect">
        <xsl:with-param name="path-to-root">
          <xsl:value-of select="$path-to-root"/>
        </xsl:with-param>      
        <xsl:with-param name="filename">
          <xsl:value-of select="$filename"/>
        </xsl:with-param>      
      </xsl:apply-templates>
      <ul>
        <xsl:apply-templates select="menuitem">
          <xsl:with-param name="path-to-root">
            <xsl:value-of select="$path-to-root"/>
          </xsl:with-param>      
          <xsl:with-param name="filename">
            <xsl:value-of select="$filename"/>
          </xsl:with-param>      
        </xsl:apply-templates>
      </ul>
    </li>
  </xsl:template>

  <!-- ======================================================================--> 
  <!-- menuitem for the navigation bar -->
  <!-- ======================================================================--> 
  <xsl:template match="menuitem">
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:param name="filename"/>
    <li>
      <xsl:apply-templates>	
        <xsl:with-param name="path-to-root">
          <xsl:value-of select="$path-to-root"/>
        </xsl:with-param>      
        <xsl:with-param name="filename">
          <xsl:value-of select="$filename"/>
        </xsl:with-param>      
      </xsl:apply-templates>
    </li>
  </xsl:template>

  <!-- ======================================================================--> 
  <!-- menu/legend -->
  <!-- ======================================================================--> 
  <xsl:template match="menu/legend">
    <div><xsl:apply-templates/></div>
  </xsl:template>

  <!-- ======================================================================--> 
  <!-- menu/connect -->
  <!-- ======================================================================--> 
  <xsl:template match="menu/connect">
    
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:param name="filename"/>
    <xsl:variable name="path">
      <xsl:value-of select="$path-to-root"/>
    </xsl:variable>
    
    <xsl:variable name="htmlref">
      <xsl:value-of select="substring-before(@href,'.xml')"/>
      <xsl:value-of select="$html-suffix"/>
      <xsl:value-of select="substring-after(@href,'.xml')"/>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="starts-with(@href,'/') or starts-with(@href,'http://') or starts-with(@href,'mailto:') or starts-with(@href,'ftp://')">
        <a href="{$htmlref}"><xsl:apply-templates/></a>
      </xsl:when>
      
      <xsl:when test="@href=$filename">
        <div class="active"><xsl:apply-templates/></div>
      </xsl:when>

      <xsl:otherwise>
        <a href="{$path}/{$htmlref}"><xsl:apply-templates/></a>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <!-- ======================================================================--> 
  <!-- menuitem/connect -->
  <!-- ======================================================================--> 
  <xsl:template match="menuitem/connect">
    
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:param name="filename"/>
    <xsl:variable name="path">
      <xsl:value-of select="$path-to-root"/>
    </xsl:variable>
    
    <xsl:variable name="htmlref">
      <xsl:value-of select="substring-before(@href,'.xml')"/>
      <xsl:value-of select="$html-suffix"/>
      <xsl:value-of select="substring-after(@href,'.xml')"/>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="starts-with(@href,'/') or starts-with(@href,'http://') or starts-with(@href,'mailto:') or starts-with(@href,'ftp://')">
        <a href="{$htmlref}" class="menu"><xsl:apply-templates/></a>
      </xsl:when>
      
      <xsl:when test="@href=$filename">
        <div class="active"><xsl:apply-templates/></div>
      </xsl:when>

      <xsl:otherwise>
        <a href="{$path}/{$htmlref}" class="menu"><xsl:apply-templates/></a>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <!-- ======================================================================--> 
  <!-- menu/a -->
  <!-- ======================================================================--> 
  <xsl:template match="menu/a">
    
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:param name="filename"/>
    <xsl:variable name="path">
      <xsl:value-of select="$path-to-root"/>
    </xsl:variable>
    
    <xsl:variable name="target">
      <xsl:choose>
	<xsl:when test="@fork='true'">_blank</xsl:when>
	<xsl:otherwise>_self</xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="starts-with(@href,'/') or starts-with(@href,'http://') or starts-with(@href,'mailto:') or starts-with(@href,'ftp://')">
        <a href="{@href}" target="{$target}"><xsl:apply-templates/></a>
      </xsl:when>
      
      <xsl:otherwise>
        <a href="{$path}/{@href}" target="{$target}"><xsl:apply-templates/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- =========================================================================
--> 
  <!-- menuitem/a -->
  <!-- =========================================================================
--> 
  <xsl:template match="menuitem/a">
    
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:param name="filename"/>
    <xsl:variable name="path">
      <xsl:value-of select="$path-to-root"/>
    </xsl:variable>
    
    <xsl:variable name="target">
      <xsl:choose>
        <xsl:when test="@fork='true'">_blank</xsl:when>
        <xsl:otherwise>_self</xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="starts-with(@href,'/') or starts-with(@href,'http://') or starts-with(@href,'mailto:') or starts-with(@href,'ftp://')">
        <a href="{@href}" target="{$target}"><xsl:apply-templates/></a>
      </xsl:when>
      
      <xsl:otherwise>
        <a href="{$path}/{@href}" target="{$target}"><xsl:apply-templates/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

 <!-- =======================================================================--> 
 <!-- connect -->
 <!-- =======================================================================--> 
 <xsl:template match="connect">

   <xsl:variable name="htmlref">
     <xsl:value-of select="substring-before(@href,'.xml')"/>
     <xsl:value-of select="$html-suffix"/>
     <xsl:value-of select="substring-after(@href,'.xml')"/>
   </xsl:variable>
 
   <a href="{$htmlref}"><xsl:apply-templates/></a>
 </xsl:template>

</xsl:stylesheet>
