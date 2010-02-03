<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- ========================================================================= --> 
  <!-- Output method -->
  <!-- ========================================================================= --> 
  <xsl:output method="html" encoding="iso-8859-1" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" />

  <!-- ========================================================================= --> 
  <!-- Defined parameters (overrideable) -->
  <!-- ========================================================================= --> 
  <xsl:param name="project-file"      select="'project.xml'"/>
  <xsl:param name="last-modified"     select="''"/>
  
  <!-- ========================================================================= --> 
  <!-- Defined variables (non-overrideable) -->
  <!-- ========================================================================= --> 
  <xsl:variable name="html-suffix"   select="'.html'"/>
  <xsl:variable name="printable-html-suffix"  select="'_print.html'"/>
    
 <!-- ========================================================================= --> 
 <!-- s1 -->
 <!-- ========================================================================= --> 
  <xsl:template match="s1">					      
    <h1><xsl:if test="string-length(@anchor)!=0"><a name="{@anchor}"></a></xsl:if><xsl:value-of select="@name" /></h1>
    <xsl:apply-templates/>
 </xsl:template>
					    
 <!-- ========================================================================= --> 
 <!-- s2 -->
 <!-- ========================================================================= --> 
 <xsl:template match="s2">    
    <h2><xsl:if test="string-length(@anchor)!=0"><a name="{@anchor}"></a></xsl:if><xsl:value-of select="@name" /></h2>
    <xsl:apply-templates/>
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- subtitle -->
 <!-- ========================================================================= --> 
 <xsl:template match="subtitle">
   <h3><xsl:if test="string-length(@anchor)!=0"><a name="{@anchor}"></a></xsl:if><xsl:apply-templates /></h3>
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- table -->
 <!-- ========================================================================= --> 
 <xsl:template match="table">
   <table summary="" cellspacing="0" cellpadding="5" border="{@border}">
     <xsl:for-each select="tr">     
     <tr>
       <xsl:apply-templates select="th"/>
       <xsl:apply-templates select="td"/>
     </tr>
     </xsl:for-each>
   </table>
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- th -->
 <!-- ========================================================================= --> 
 <xsl:template match="th">
   <th align="{@align}" valign="{@valign}" colspan="{@colspan}" rowspan="{@rowspan}">
     <xsl:apply-templates/>
   </th>
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- td -->
 <!-- ========================================================================= --> 
 <xsl:template match="td">   
   <td align="{@align}" valign="{@valign}" colspan="{@colspan}" rowspan="{@rowspan}">
     <xsl:apply-templates/>
   </td> 
 </xsl:template>
 
 <!-- ========================================================================= --> 
 <!-- copyright -->
 <!-- ========================================================================= --> 
 <xsl:template match="copyright">
   <p style="text-align: center"><em><xsl:apply-templates/></em></p>
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- hr -->
 <!-- ========================================================================= --> 
 <xsl:template match="hr">
   <hr size="1" noshade="noshade" />
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- a -->
 <!-- ========================================================================= --> 
 <xsl:template match="a">
     <xsl:choose>
       <xsl:when test="@fork='true'"><a href="{@href}" target="_new"><xsl:apply-templates/></a></xsl:when>
       <xsl:otherwise><a href="{@href}"><xsl:apply-templates/></a></xsl:otherwise>
     </xsl:choose>
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- anchor -->
 <!-- ========================================================================= --> 
 <xsl:template match="anchor">
   <a name="{@name}"></a>
 </xsl:template>

 <!-- ========================================================================= -->        
 <!-- source code -->
 <!-- ========================================================================= --> 
 <xsl:template match="source">
   <pre><xsl:value-of select="."/></pre>
 </xsl:template>

 <!-- ========================================================================= --> 
 <!-- Process everything else by just passing it through -->
 <!-- ========================================================================= --> 
  <xsl:template match="*|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
