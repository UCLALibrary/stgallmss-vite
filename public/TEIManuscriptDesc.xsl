<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:param name="fileID" />
  <xsl:param name="fileId" />
  <xsl:output method="html" />

  <!-- St. Gall Stylesheet for the  Codicological Description page of a manuscript-->
  <!-- written by Parinita Ghorpade, December 2009 -->
  <!-- edited by Elizabeth McAulay, 6/11/10, 8/13/10, 8/19/10, 9/3/10 -->

  <xsl:template match="/">


    <table class="textAndImage">
      <!-- manuscript header-->
      <tr>
        <td class="title">
          <xsl:value-of
            select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository" />: <xsl:value-of
            select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno" /></td>
      </tr>
      <tr>
        <td>

          <!-- sub nav table for left view frame-->
          <table width="100%" border="0" cellspacing="5" cellpadding="5">
            <tr>
              <td width="33%" class="subnav_off">
                <!--
                href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptContents.xsl&amp;fileId={$fileId}"-->
                <a
                  href="javascript:void(0)"
                  onclick="performXSLTTransformation('TEIManuscriptContents.xsl');"
                > Manuscript
    Contents</a>
              </td>
              <td width="33%" class="subnav_off">
                <!--
                href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptBiblio.xsl&amp;&amp;fileId={$fileId}"-->
                <a
                  href="javascript:void(0)"
                  onclick="performXSLTTransformation('TEIManuscriptBiblio.xsl');"
                > Manuscript
    Codicological Bibliography</a>
              </td>
              <td class="subnav_on">Manuscript Codicological Description</td>
            </tr>
          </table>
          <!-- sub nav table for left view frame END  -->

        </td>
      </tr>
      <tr>
        <td align="left" valign="top">


          <DIV class="tan_divider">

            <xsl:for-each
              select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:material">
              <p>
                <b>Material: </b>
                <xsl:text>  </xsl:text>
                <xsl:value-of select="." />
              </p>
            </xsl:for-each>

            <p>
              <b>Extent: </b>
              <xsl:text> </xsl:text>
              <xsl:value-of
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:extent/text()" />

            </p>
            <p>
              <b>Dimensions: </b>
              <xsl:apply-templates
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:extent"
              />
            </p>

            <p>


              <xsl:for-each
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:collation">

                <b>Collation: </b><span style="padding:2px;">
                  <xsl:apply-templates />
                </span>

                <!--  <xsl:for-each select="tei:list/tei:item">
                        <tr class="collation">
                          
                          <xsl:choose>
                            <xsl:when test="tei:graphic">
                              <td class="collation">
                                <xsl:variable name="img" select="tei:graphic/@url"/>
                                
                                <img src="/stgallmss/imageResize.do?imageark={$img}"/>
                              </td>
                            </xsl:when>
                            <xsl:otherwise>
                              <td>
                                <xsl:value-of select="substring-before(.,'=')"/>
                                
                              </td>
                            </xsl:otherwise>
                          </xsl:choose>
                          <td><xsl:text>= </xsl:text><xsl:value-of select="substring-after(.,'=')"/>
                            
                          </td>
                        </tr>
                      </xsl:for-each>-->

              </xsl:for-each>

            </p>

            <p>
              <b>Page Layout: </b>
              <xsl:text> </xsl:text>
              <xsl:value-of
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:objectDesc/tei:layoutDesc/tei:layout"
              > </xsl:value-of>
            </p>

            <p>
              <b>Script and Hand(s): </b>
              <xsl:text> </xsl:text>
              <xsl:value-of
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:handDesc/tei:p" />
            </p>
            <p>
              <b>Additional Information:</b>
              <xsl:text> </xsl:text>
              <xsl:value-of
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:additions/tei:p" />
            </p>
            <p>
              <b>Date: </b>
              <xsl:text> </xsl:text>
              <xsl:value-of
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:history/tei:origin/tei:origDate"
              />
            </p>

            <p>
              <b>Origin: </b>
              <xsl:text> </xsl:text>
              <xsl:value-of
                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:history/tei:origin/tei:origPlace"
              />
            </p>

            <br />


          </DIV>

          <!-- Content table for left view frame END-->
          <br />
          <br />
        </td>
      </tr>
    </table>


  </xsl:template>
  <xsl:template match="tei:hi">
    <xsl:if test="@rend = 'sup'">
      <sup>
        <xsl:apply-templates />
      </sup>
    </xsl:if>
  </xsl:template>
  <xsl:template
    match="tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:extent">
    <xsl:apply-templates select="tei:dimensions" />
  </xsl:template>

  <xsl:template match="tei:dimensions">
    <xsl:value-of select="tei:height" /> x <xsl:value-of select="tei:width" />
    <xsl:text> </xsl:text><xsl:value-of
      select="@unit" />
  </xsl:template>

  <xsl:template match="tei:collation">
    <xsl:for-each select="tei:list/tei:item">
      <xsl:value-of select="." />
      <br />
      <xsl:variable name="collationURL" select="tei:graphic/@url" />
      <xsl:if
        test="tei:graphic">
        <img src="/stgallmss/imageResize.do?imageark={$collationURL}"
          alt="Collation image from Holder's catalog" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>