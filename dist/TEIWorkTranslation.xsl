<?xml version="1.0" encoding="UTF-8"?>

<!-- St. Gall Stylesheet for the  bibliography page of a work within a manuscript-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:param name="count" />
    <xsl:param name="fileId" />
    <xsl:output method="html" />
    <xsl:template match="/">


        <table width="95%" border="0" align="center" cellpadding="3" cellspacing="0"
            bgcolor="#ffffff">

            <tr>
                <td class="title"><xsl:value-of
                        select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository"></xsl:value-of>
        :  
            <xsl:value-of
                        select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno"></xsl:value-of>
                </td>
            </tr>
            <tr>
                <td>

                    <!-- sub nav table for left view frame-->
                    <table width="100%" border="0" cellspacing="5" cellpadding="5">
                        <tr>
                            <td width="33%" class="subnav_off">
                                <a
                                    href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptContents.xsl&amp;fileId={$fileId}">
        Content</a>
                            </td>
                            <td width="33%" class="subnav_off">
                                <a
                                    href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptBiblio.xsl&amp;fileId={$fileId}">Codicological
        Bibliography</a>
                            </td>
                            <td class="subnav_off">
                                <a
                                    href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptDesc.xsl&amp;imageark={tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:collation/@ark}&amp;fileId={$fileId}">Codicological
        Description</a>
                            </td>
                        </tr>
                    </table>
                    <!-- sub nav table for left view frame END  -->

                </td>
            </tr>
            <!--<tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td width="10%"  height="29" align="left" valign="middle" nowrap="nowrap">Legend:</td>
          <td width="20%"  align="left" valign="middle" nowrap="nowrap"><img
            src="/images/icon_bibliography.jpg" width="20" height="20" alt=" Bibliography" />
            Bibliography</td>
          <td width="19%"  align="left" valign="middle" nowrap="nowrap"><img
            src="/images/icon_translation.jpg" width="20" height="20" alt="Translation" />
            Translation</td>
          <td width="16%"  align="left" valign="middle" nowrap="nowrap"><img src="/images/icon_content.jpg"
            width="20" height="20" alt="Content" /> Content</td>
          <td width="35%"    align="left" valign="middle" nowrap="nowrap"><img src="/images/icon_text.jpg"
            width="20" height="20" alt="Text" /> Text </td>
        </tr>
    </table></td>
  </tr>-->
            <tr>
                <td align="left" valign="top">
                    <DIV class="tan_divider"> [<xsl:value-of select="$count" />] <b>
                            <xsl:value-of
                                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:locus" />
                        </b>
        :  
                <a target="_top"
                            href="/stgallmss/viewItem.do?count={$count}&amp;pageArk={tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:locus/@facs}&amp;fileId={$fileId}">

                            <i>
                                <xsl:value-of
                                    select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:title" />
                            </i>
                        </a>

                        <!--<p>
                <ol>
                <xsl:for-each
                        select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl">
                    <xsl:if test="tei:head[normalize-space(.) = 'Translation']">
                    <li>
                        <b> <xsl:value-of select="normalize-space(tei:head)"/>:</b>
                        
                        <ul style="list-style-type:disc">
                           <xsl:for-each select="tei:biblStruct">
                               
                               <p>
                                
                                       
                                       
                                       <xsl:if test="tei:monogr/tei:author">
                                           <xsl:value-of select="normalize-space(tei:monogr/tei:author)"/>.<xsl:text> </xsl:text>
                                       </xsl:if>
                                       
                                       <xsl:if test="tei:monogr/tei:title">
                                           <i><xsl:value-of select="normalize-space(tei:monogr/tei:title)"/></i>.<xsl:text> </xsl:text>
                                       </xsl:if>
                                       <xsl:if test="tei:monogr/tei:editor">
                                           edited by  <xsl:value-of select="normalize-space(tei:monogr/tei:editor)"/>.<xsl:text> </xsl:text>
                                       </xsl:if>
                                       
                                       <xsl:if test="tei:monogr/tei:respStmt/tei:resp">
                                           <xsl:value-of select="normalize-space(tei:monogr/tei:respStmt/tei:resp)"/><xsl:text> </xsl:text>
                                       </xsl:if>
                                       
                                       <xsl:if test="tei:monogr/tei:respStmt/tei:name">
                                           by  <xsl:value-of select="normalize-space(tei:monogr/tei:respStmt/tei:name)"/>.<xsl:text>
                        </xsl:text>
                                       </xsl:if>
                                       
                                       
                                       
                                       <xsl:if test="tei:monogr/tei:imprint/tei:pubPlace">
                                           <xsl:value-of select="normalize-space(tei:monogr/tei:imprint/tei:pubPlace)"/>:<xsl:text>
                        </xsl:text>  
                                       </xsl:if>
                                       
                                       <xsl:if test="tei:monogr/tei:imprint/tei:publisher">
                                           <xsl:value-of select="normalize-space(tei:monogr/tei:imprint/tei:publisher)"/>,<xsl:text>
                        </xsl:text> 
                                       </xsl:if>
                                       
                                       <xsl:if test="tei:monogr/tei:imprint/tei:date">
                                           <xsl:value-of select="normalize-space(tei:monogr/tei:imprint/tei:date)"/>.<xsl:text> </xsl:text>
                                       </xsl:if> 
                                       
                                       
                                       
                                       
                                           <xsl:if test="tei:note">
                                           <xsl:choose>
                                           <xsl:when test="tei:note/tei:ref">
                                               <a target= "_blank" href="{tei:note/tei:ref}"><xsl:value-of select="tei:note/tei:ref"/></a>
                                               </xsl:when>
                                               <xsl:otherwise>
                                                   <xsl:value-of select="normalize-space(tei:note)"/>
                                               </xsl:otherwise>
                                               </xsl:choose>
                                                                                               
                                           </xsl:if>
                                      
                                
                               </p>
                           </xsl:for-each> 
                            
                        </ul>
                    </li>
                    </xsl:if>
                </xsl:for-each>    
                </ol>
                
              
                </p><br />-->
                    </DIV>


                    <br />
                    <br />
                </td>
            </tr>
        </table>


    </xsl:template>

</xsl:stylesheet>