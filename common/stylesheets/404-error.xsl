<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="./common.xsl"/>

  <!-- ========================================================================= -->  
  <!-- Process an entire document into an HTML page -->
  <!-- ========================================================================= --> 
  <xsl:template match="document">
    
    <xsl:variable name="project" select="document($project-file)/project"/>
    <xsl:variable name="filename" select="properties/filename"/>
    <xsl:variable name="html-filename">
      <xsl:value-of select="substring-before($filename,'.xml')"/>
      <xsl:value-of select="$printable-html-suffix"/>
    </xsl:variable>
    <xsl:variable name="path-to-root" select="properties/pathtoroot"/>   
    
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
        <meta http-equiv="Content-Language" content="en"/>
        <title><xsl:value-of select="$project/title"/> - <xsl:value-of select="properties/title"/></title>
        <meta content="webmaster@objectweb.org" name="Reply-to"/>
        <meta content="ObjectWeb" name="Owner"/>
        <meta content="noindex, follow" name="Robots"/>

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

	<link rel="stylesheet" href="/common.css" />
      </head>
   
      <body>
	<a name="top"></a>

        <table summary="" border="0" width="100%" cellspacing="2" cellpadding="0">
	  <tr>
            <td align="left" valign="top" width="320">
              <a href="/index.html">
                <img src="/images/objectweb.gif" border="0" width="300" height="120" alt="ObjectWeb logo"/>
              </a>
	    </td>
	    
	    <td align="right" valign="middle" width="100%">
	      <form action="http://www.objectweb.org/htsearch" method="post">
		<input type="hidden" name="method" value="and" />
		<input type="hidden" name="format" value="builtin-long" />
		<input type="hidden" name="sort" value="score" />
		<input type="hidden" name="restrict" value="" />

		<table summary="" align="right" cellspacing="0" cellpadding="4" border="0">
		  <tr>
		    <td><input type="text" name="words" size="13" /></td>
		    <td><input type="submit" value="Search" name="submit" size="5" /></td>
		    <td rowspan="2"><a href="http://www.theserverside.com/"><img src="/images/theserverside.gif" border="0" width="140" height="41" alt="TheServerSide logo"/></a></td>
		    <td rowspan="2"><a href="http://validator.w3.org/check/referer"><img border="0" src="/images/valid-html401.png" alt="Valid HTML 4.01!" height="31" width="88" /></a></td>
		    <td rowspan="2"><a href="http://jigsaw.w3.org/css-validator/"><img border="0" src="/images/vcss.gif" alt="Valid CSS!" height="31" width="88" /></a></td>
		  </tr>

		  <tr>
		    <td colspan="2" class="small">[<a href="/resources/search{$html-suffix}">Advanced search</a>]</td>
		  </tr>
		</table>

	      </form>
	    </td>
	  </tr>
	</table>

	<table summary="" border="0" width="100%" cellspacing="0" cellpadding="10">
	  <tr>	
	  <td colspan="2" class="small"><strong><a href="http://www.objectweb.org/consortium/membership.jsp">Become a member of the ObjectWeb Consortium</a>! Membership is free for individuals.</strong></td>
	  </tr>

	  <tr>
	    <td class="menu" width="160" valign="top" nowrap="nowrap">
	      <xsl:apply-templates select="$project/body/menu">
		<xsl:with-param name="path-to-root"><xsl:value-of select="$path-to-root"/></xsl:with-param>
	      </xsl:apply-templates>
	    </td>
	    
	    <td valign="top" width="100%" align="left">
	      <xsl:apply-templates select="body/s1"/>
	    </td>
	  </tr> 
	</table>

	<div class="navig">[<a href="#top">Top</a>] [<a href="/resources/search{$html-suffix}">Advanced search</a>] [<a href="/index{$html-suffix}">Home</a>] [<a href="mailto:webmaster@objectweb.org">Webmaster</a>]</div>

	<hr noshade="noshade" size="1"/>

	<div class="signature"><center>Last modified at <xsl:value-of select="$last-modified"/> - Copyright &#169; 1999-2005, ObjectWeb Consortium</center></div>

      </body>
    </html>
  </xsl:template>

  <!-- ========================================================================= --> 
  <!-- menu for the navigation bar -->
  <!-- ========================================================================= --> 
  <xsl:template match="menu">
    
    <xsl:param name="path-to-root">.</xsl:param>

    <p>
      <strong>
	<xsl:apply-templates select="legend | a | connect">
	  <xsl:with-param name="path-to-root">
	    <xsl:value-of select="$path-to-root"/>
	  </xsl:with-param>      
	</xsl:apply-templates>
      </strong>
      <br />
      <span class="small">
      <xsl:apply-templates select="menuitem">
      	<xsl:with-param name="path-to-root">
	  <xsl:value-of select="$path-to-root"/>
	</xsl:with-param>      
      </xsl:apply-templates>
      </span>
    </p>
  </xsl:template>

  <!-- ========================================================================= --> 
  <!-- menuitem for the navigation bar -->
  <!-- ========================================================================= --> 
  <xsl:template match="menuitem">
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:apply-templates>	
      <xsl:with-param name="path-to-root">
	<xsl:value-of select="$path-to-root"/>
      </xsl:with-param>      
    </xsl:apply-templates>
  </xsl:template>

  <!-- ========================================================================= --> 
  <!-- menu/legend -->
  <!-- ========================================================================= --> 
  <xsl:template match="menu/legend">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- ========================================================================= --> 
  <!-- menu/connect -->
  <!-- ========================================================================= --> 
  <xsl:template match="menu/connect">
    
    <xsl:param name="path-to-root">.</xsl:param>
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
      
      <xsl:otherwise>
	<a href="{$path}/{$htmlref}"><xsl:apply-templates/></a>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <!-- ========================================================================= --> 
  <!-- menuitem/connect -->
  <!-- ========================================================================= --> 
  <xsl:template match="menuitem/connect">
    
    <xsl:param name="path-to-root">.</xsl:param>
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
	&#160;&#183;&#160;<a href="{$htmlref}"><xsl:apply-templates/></a><br />
      </xsl:when>
      
      <xsl:otherwise>
	&#160;&#183;&#160;<a href="{$path}/{$htmlref}"><xsl:apply-templates/></a><br />
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <!-- ========================================================================= --> 
  <!-- menu/a -->
  <!-- ========================================================================= --> 
  <xsl:template match="menu/a">
    
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:variable name="path">
      <xsl:value-of select="$path-to-root"/>
    </xsl:variable>
    
    <xsl:variable name="target">
      <xsl:choose>
	<xsl:when test="@fork='true'">_new</xsl:when>
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
  
  <!-- ========================================================================= --> 
  <!-- menuitem/a -->
  <!-- ========================================================================= --> 
  <xsl:template match="menuitem/a">
    
    <xsl:param name="path-to-root">.</xsl:param>
    <xsl:variable name="path">
      <xsl:value-of select="$path-to-root"/>
    </xsl:variable>
    
    <xsl:variable name="target">
      <xsl:choose>
	<xsl:when test="@fork='true'">_new</xsl:when>
	<xsl:otherwise>_self</xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="starts-with(@href,'/') or starts-with(@href,'http://') or starts-with(@href,'mailto:') or starts-with(@href,'ftp://')">
	&#160;&#183;&#160;<a href="{@href}" target="{$target}"><xsl:apply-templates/></a><br />
      </xsl:when>
      
      <xsl:otherwise>
	&#160;&#183;&#160;<a href="{$path}/{@href}" target="{$target}"><xsl:apply-templates/></a><br />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ========================================================================= --> 
  <!-- connect -->
  <!-- ========================================================================= --> 
  <xsl:template match="connect">
    
    <xsl:variable name="htmlref">
      <xsl:value-of select="substring-before(@href,'.xml')"/>
      <xsl:value-of select="$html-suffix"/>
      <xsl:value-of select="substring-after(@href,'.xml')"/>
    </xsl:variable>
    
    <a href="{$htmlref}"><xsl:apply-templates/></a>
  </xsl:template>
  
</xsl:stylesheet>
