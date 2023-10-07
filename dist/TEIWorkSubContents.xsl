<?xml version="1.0" encoding="UTF-8"?>

<!-- St. Gall Stylesheet for the Expanded Contents page of a work within a manuscript-->
<!-- edited by Richard Pollard to include bibliography 10/2010 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:param name="count" />
    <xsl:param name="fileId" />
    <xsl:param name="ark" />
    <!-- line below only used for testing  
        <xsl:param name="count" select="4.3"></xsl:param> -->
    <xsl:include href="TEIBibliography.xsl" />
    <xsl:output method="html" />
    <xsl:template match="/">


        <table width="95%" border="0" align="center" cellpadding="3" cellspacing="0"
            bgcolor="#ffffff">

            <tr>
                <td class="title">
                    <xsl:value-of
                        select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository"></xsl:value-of>
        :  
                    <xsl:value-of
                        select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno"></xsl:value-of>
                </td>
            </tr>
            <tr>
                <td>

                    <!-- sub nav table for left view frame-->

                    <table width="100%" border="0" cellspacing="5" cellpadding="5" bgcolor="#ffffff">
                        <tr>
                            <td width="33%" class="subnav_on">
                                <a href="javascript:void(0)"
                                    onclick="fetchFile('TEIManuscriptContents.xsl','{$fileId}');">
        Contents</a>
                            </td>
                            <!--
                            href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptBiblio.xsl&amp;fileId={$fileId}"-->
                            <td width="33%" class="subnav_off">
                                <a href="javascript:void(0)"
                                    onclick="fetchFile('TEIManuscriptBiblio.xsl','{$fileId}');">Codicological
        Bibliography</a>
                            </td>
                            <!--
                            href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptDesc.xsl&amp;imageark={tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:collation/@ark}&amp;fileId={$fileId}"-->
                            <td class="subnav_off">
                                <a href="javascript:void(0)"
                                    onclick="fetchFile('TEIManuscriptDesc.xsl','{$fileId}','{tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:collation/@ark}');">Codicological
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
          <td width="10%" height="29" align="left" valign="middle" nowrap="nowrap">Legend:</td>
          <td width="20%" align="left" valign="middle" nowrap="nowrap"><img
            src="/images/icon_bibliography.jpg" width="20" height="20" alt=" Bibliography" />
            Bibliography</td>
          <td width="19%" align="left" valign="middle" nowrap="nowrap"><img
            src="/images/icon_translation.jpg" width="20" height="20" alt="Translation" />
            Translation</td>
          <td width="16%" align="left" valign="middle" nowrap="nowrap"><img src="/images/icon_content.jpg"
            width="20" height="20" alt="Content" /> Content</td>
          <td width="35%" align="left" valign="middle" nowrap="nowrap"><img src="/images/icon_text.jpg"
            width="20" height="20" alt="Text" /> Text </td>
        </tr>
    </table></td>
  </tr>-->
            <tr>
                <td align="left" valign="top">

                    <!-- Contents for left view frame copy paste the DIV tag section to add more
                    content.
    The page numbers to the right are under span tags--> [ <xsl:value-of select="$count" /> ] <b>
                        <xsl:value-of
                            select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem/tei:msItem[@n = $count]/tei:locus" />
                    </b>
        :  
                    <i>
                        <xsl:value-of
                            select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem/tei:msItem[@n = $count]/tei:title" />
                    </i>

                    <br />
                    <!--<ul>
                    <xsl:choose>
                        <xsl:when test="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n =
                    $count]/tei:rubric">
                           <xsl:choose>
                                <xsl:when test="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n =
                    $count]/tei:rubric[@rend='red']">
                                    <li>Rubric:  <span style="color:#ff0000"><xsl:value-of
                    select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n =
                    $count]/tei:rubric"/></span></li>                             
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Rubric:  <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n
                    = $count]/tei:rubric"/></li>
                               </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                    <li>Incipit: <xsl:value-of
                    select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n =
                    $count]/tei:incipit"/></li>
                    <li>Explicit: <xsl:value-of
                    select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n =
                    $count]/tei:explicit"/></li>
					
                <br/>
                <br/>
                <a
                    href="/stgallmss/viewFile.do?xmlstylesheet=http://www.stgallplan.org/stgallmss/xslt/workbibliography.xsl&amp;count={$count}&amp;fileId={$fileId}"><img
                    src="/images/icon_bibliography.jpg" width="20" height="20" alt="Bibliography"
                    /></a> &nbsp;
                <a target="_top"
                    href="/stgallmss/viewItem.do?xmlstylesheet=http://www.stgallplan.org/stgallmss/xslt/transcription.xsl&amp;count={$count}&amp;ark={text/body/msDesc/msContents/msItem[@n
                    = $count]/locus/@ark}&amp;fileId={$fileId}"><img src="/images/icon_text.jpg"
                    width="20" height="20" alt="Text" /></a>&nbsp;
                
          <img src="/images/icon_translation.jpg" width="20" height="20" alt="Translation" />
          </ul>-->

                    <DIV
                        class="tan_divider">
                        <br />
                        <!--<img
                        src="images/icon_content.jpg" width="20" height="20" alt="Content" />:-->

                        <ul style="list-style-type:none">                            <!-- Book-Level -->
                            <xsl:for-each
                                select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem/tei:msItem[@n = $count]">
                                <li>
                                    <xsl:value-of select="$count" />
                                    <!-- This link goes to the page of the transcription that is the
                                    first for this section -->
                                    <span class="float">
                                        <xsl:value-of select="tei:locus" />
                                    </span>


                                    <xsl:choose>
                                        <xsl:when test="tei:title">

                                            <p>
                                                <a target="_top"
                                                    href="/stgallmss/viewItem.do?xmlstylesheet=TEITranscription.xsl&amp;count={@n}&amp;pageArk={tei:locus/@facs}&amp;fileId={$fileId}">
                                                    <xsl:value-of select="tei:title" />
                                                </a>
                                            </p>



                                            <xsl:if
                                                test="tei:rubric">
                                                <li>
                                                    <b>Rubric: </b>
                                                    <xsl:value-of select="tei:rubric" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:incipit">
                                                <li>
                                                    <b>Incipit: </b>
                                                    <xsl:value-of select="tei:incipit" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:explicit">
                                                <li>
                                                    <b>Explicit: </b>
                                                    <xsl:value-of select="tei:explicit" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:incipit2">
                                                <br></br>
                                                <li>
                                                    <b>Incipit: </b>
                                                    <xsl:value-of select="tei:incipit2" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:explicit2">
                                                <li>
                                                    <b>Explicit: </b>
                                                    <xsl:value-of select="tei:explicit2" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:note">
                                                <li>
                                                    <b>Remarks: </b>
                                                    <xsl:apply-templates select="tei:note" />
                                                </li>
                                            </xsl:if>

                                            <p>
                                                <xsl:if test="tei:listBibl">
                                                    <xsl:for-each select="tei:listBibl">
                                                        <li>
                                                            <!-- print in bold the listBibl heading -->
                                                            <b>
                                                                <xsl:value-of
                                                                    select="normalize-space(tei:head)" />
        :</b>
                                                            <!-- for each citation, do the following -->
                                                            <xsl:for-each select="tei:biblStruct">
                                                                <!-- each citation gets its own
                                                                paragraph -->
                                                                <p>
                                                                    <xsl:call-template
                                                                        name="lisabibliography" />
                                                                </p>
                                                            </xsl:for-each>

                                                            <xsl:for-each select="tei:bibl">
                                                                <p>
                                                                    <xsl:call-template
                                                                        name="lisaBibl" />
                                                                </p>
                                                            </xsl:for-each>
                                                            <!-- end citation -->
                                                        </li>
                                                    </xsl:for-each>
                                                </xsl:if>
                                            </p>

                                        </xsl:when>

                                        <xsl:otherwise>
                                            <br></br>
                                            <xsl:if test="tei:rubric">
                                                <li>
                                                    <b>Rubric: </b>
                                                    <xsl:value-of select="tei:rubric" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:incipit">
                                                <li>
                                                    <b>Incipit: </b>
                                                    <xsl:value-of select="tei:incipit" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:explicit">
                                                <li>
                                                    <b>Explicit: </b>
                                                    <xsl:value-of select="tei:explicit" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:incipit2">
                                                <br></br>
                                                <li>
                                                    <b>Incipit: </b>
                                                    <xsl:value-of select="tei:incipit2" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:explicit2">
                                                <li>
                                                    <b>Explicit: </b>
                                                    <xsl:value-of select="tei:explicit2" />
                                                </li>
                                            </xsl:if>
                                            <xsl:if
                                                test="tei:note">
                                                <li>
                                                    <b>Remarks: </b>
                                                    <xsl:apply-templates select="tei:note" />
                                                </li>
                                            </xsl:if>

                                            <p>
                                                <xsl:if test="tei:listBibl">
                                                    <xsl:for-each select="tei:listBibl">
                                                        <li>
                                                            <!-- print in bold the listBibl heading -->
                                                            <b>
                                                                <xsl:value-of
                                                                    select="normalize-space(tei:head)" />
        :</b>
                                                            <!-- for each citation, do the following -->


                                                            <xsl:for-each select="tei:biblStruct">
                                                                <!-- each citation gets its own
                                                                paragraph -->
                                                                <p>
                                                                    <xsl:call-template
                                                                        name="lisabibliography" />
                                                                </p>
                                                            </xsl:for-each>

                                                            <xsl:for-each select="tei:bibl">
                                                                <p>
                                                                    <xsl:call-template
                                                                        name="lisaBibl" />
                                                                </p>
                                                            </xsl:for-each>
                                                            <!-- end citation -->
                                                        </li>
                                                    </xsl:for-each>
                                                </xsl:if>
                                            </p>

                                        </xsl:otherwise>
                                    </xsl:choose>
                                </li>

                                <ul
                                    style="list-style-type:none">                                    <!--Chapter-Level-->

                                    <xsl:for-each select="tei:msItem">
                                        <li>

                                            <a target="_top"
                                                href="/stgallmss/viewItem.do?xmlstylesheet=TEITranscription.xsl&amp;count={@n}&amp;pageArk={tei:locus/@facs}&amp;fileId={$fileId}">
                                                <xsl:value-of select="tei:locus" />
                                            </a>
        :                                                                                          <!--
                                            This link goes to the page of the transcription that is
                                            the first for this sub-section-->

                                            <xsl:choose>
                                                <xsl:when test="tei:title">
                                                    <br />
                                                    <xsl:value-of select="tei:title" />
                                                    <xsl:if
                                                        test="tei:rubric">
                                                        <ul style="list-style-type:none">

                                                            <b>Rubric: </b>
                                                            <xsl:value-of select="tei:rubric" />
                                                            <br />

                                                        </ul>
                                                    </xsl:if>
                                                    <xsl:if
                                                        test="tei:incipit">
                                                        <ul style="list-style-type:none">

                                                            <b>Incipit: </b>
                                                            <xsl:value-of select="tei:incipit" />
                                                            <br />

                                                        </ul>
                                                    </xsl:if>
                                                    <xsl:if
                                                        test="tei:explicit">
                                                        <ul style="list-style-type:none">

                                                            <b>Explicit: </b>
                                                            <xsl:value-of select="tei:explicit" />
                                                            <br />

                                                        </ul>
                                                    </xsl:if>

                                                    <p>
                                                        <xsl:if test="tei:listBibl">
                                                            <xsl:for-each select="tei:listBibl">
                                                                <li>
                                                                    <!-- print in bold the listBibl
                                                                    heading -->
                                                                    <b>
                                                                        <xsl:value-of
                                                                            select="normalize-space(tei:head)" />
        :</b>
                                                                    <!-- for each citation, do the
                                                                    following -->


                                                                    <xsl:for-each
                                                                        select="tei:biblStruct">
                                                                        <!-- each citation gets its
                                                                        own paragraph -->
                                                                        <p>
                                                                            <xsl:call-template
                                                                                name="lisabibliography" />
                                                                        </p>
                                                                    </xsl:for-each>

                                                                    <xsl:for-each select="tei:bibl">
                                                                        <p>
                                                                            <xsl:call-template
                                                                                name="lisaBibl" />
                                                                        </p>
                                                                    </xsl:for-each>
                                                                    <!-- end citation -->
                                                                </li>
                                                            </xsl:for-each>
                                                        </xsl:if>
                                                    </p>

                                                </xsl:when>

                                                <xsl:otherwise>

                                                    <xsl:value-of select="tei:rubric" />

                                                    <p>
                                                        <xsl:if test="tei:listBibl">
                                                            <xsl:for-each select="tei:listBibl">
                                                                <li>
                                                                    <!-- print in bold the listBibl
                                                                    heading -->
                                                                    <b>
                                                                        <xsl:value-of
                                                                            select="normalize-space(tei:head)" />
        :</b>
                                                                    <!-- for each citation, do the
                                                                    following -->


                                                                    <xsl:for-each
                                                                        select="tei:biblStruct">
                                                                        <!-- each citation gets its
                                                                        own paragraph -->
                                                                        <p>
                                                                            <xsl:call-template
                                                                                name="lisabibliography" />
                                                                        </p>
                                                                    </xsl:for-each>

                                                                    <xsl:for-each select="tei:bibl">
                                                                        <p>
                                                                            <xsl:call-template
                                                                                name="lisaBibl" />
                                                                        </p>
                                                                    </xsl:for-each>
                                                                    <!-- end citation -->
                                                                </li>
                                                            </xsl:for-each>
                                                        </xsl:if>
                                                    </p>


                                                </xsl:otherwise>

                                            </xsl:choose>
                                        </li>
                                        <br />
                                    </xsl:for-each>
                                </ul>
                                <br />


                            </xsl:for-each>
                        </ul>


                    </DIV>

                    <!-- Content table for left view frame END-->
                    <br />
                    <br />
                </td>
            </tr>
        </table>

    </xsl:template>

</xsl:stylesheet>