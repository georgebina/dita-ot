<?xml version="1.0" encoding="UTF-8" ?>
<!-- This file is part of the DITA Open Toolkit project hosted on 
     Sourceforge.net. See the accompanying license.txt file for 
     applicable licenses.-->
<!-- (c) Copyright IBM Corp. 2004, 2005 All Rights Reserved. -->

<!--  specialize.xsl
 | Convert "generalized" DITA topics back into specialized form
 *-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <xsl:output method="xml" indent="no"/>
     <!--Find the class attribute within the XML instance document. -->
     <xsl:template match="*[@class]">
          <xsl:variable name="specialized" select="normalize-space(tokenize(@class, '/')[last()])"/>
          <xsl:element name="{$specialized}">
               <xsl:apply-templates select="node()|@*"/>
          </xsl:element>
     </xsl:template>
     
     <!--pick up everything from the element -->
     <xsl:template match="node() | @*">
          <xsl:copy>
               <xsl:apply-templates select="node() | @*"/>
          </xsl:copy>
     </xsl:template>
     
     <xsl:template match="*[contains(@class,' topic/object ')][@data and not(@data='')][@type='DITA-foreign']" priority="10">
          <xsl:apply-templates select="document(@data,/)/*/*" mode="specialize-foreign-unknown"/> 
     </xsl:template>
     
     <xsl:template match="node()|@*" mode="specialize-foreign-unknown">
          <xsl:copy>
               <xsl:apply-templates select="node()|@*" mode="specialize-foreign-unknown"/>
          </xsl:copy>
     </xsl:template>
     
</xsl:stylesheet>

