<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:include href="./common.xsl"/>
  
  <!-- ========================================================================= -->  
  <!-- Process an entire document into an HTML page -->
  <!-- ========================================================================= --> 
  <xsl:template match="document">
    
    <xsl:variable name="project" select="document($project-file)/project"/>
    <xsl:variable name="path-to-root" select="properties/pathtoroot"/>   
    
    <html>   
      <head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
	<meta http-equiv="Content-Language" content="en"/>
	<title><xsl:value-of select="$project/title"/> - <xsl:value-of select="properties/title"/></title>
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

        <link id="stylesheet" rel="stylesheet" href="{$path-to-root}/common.css" type="text/css" />
        <link rel="icon" href="{$path-to-root}/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" href="{$path-to-root}/images/favicon.ico" type="image/x-icon" />
      </head>

      <body bgcolor="white">
        <table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td colspan="2"><img src="{$path-to-root}/images/pix.gif" width="1" height="15" alt=" "/></td>
          </tr>
          
          <tr>
            <td colspan="2" align="center"><span style="font-size: 22px; font-weight: bold;"><xsl:value-of select="$project/title"/> - <xsl:value-of select="properties/title"/></span></td>
          </tr>
          
          <!-- Main content -->
          <tr>
            <td width="15" valign="top"><img src="{$path-to-root}/images/pix.gif" width="15" height="1" alt=" "/></td>
            <td valign="top" class="contenu">
	      <xsl:apply-templates select="body/s1"/>
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td width="15" valign="top"><img src="{$path-to-root}/images/pix.gif" width="15" height="1" alt=" "/></td>
            <td valign="top"><img src="{$path-to-root}/images/pix.gif" width="465" height="1" alt=" "/><address>Copyright &#169; 1999-2005, <a href="http://www.objectweb.org/">ObjectWeb Consortium</a> | <a href="mailto:contact@objectweb.org">contact</a> | <a href="mailto:webmaster@objectweb.org">webmaster</a> | Last modified at <xsl:value-of select="$last-modified"/></address></td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>

 <!-- ========================================================================= --> 
 <!-- connect -->
 <!-- ========================================================================= --> 
 <xsl:template match="connect">

   <xsl:variable name="htmlref">
     <xsl:value-of select="substring-before(@href,'.xml')"/>
     <xsl:value-of select="$printable-html-suffix"/>
     <xsl:value-of select="substring-after(@href,'.xml')"/>
   </xsl:variable>

   <a href="{$htmlref}"><xsl:apply-templates/></a>
 </xsl:template>

</xsl:stylesheet>
