<?xml version="1.0" encoding="UTF-8"?>

<!-- St. Gall Stylesheet for the Expanded Contents page of a work within a manuscript-->
<!-- edited by Richard Pollard to include bibliography 10/2010 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:param name="count" />
    <xsl:param name="fileId" />
    <xsl:param name="ark" />
    <!-- line below only used for testing 
        <xsl:param name="count" select="4"/>  -->
    <xsl:include href="TEIBibliography.xsl" />
    <xsl:output method="html" />
    <xsl:template match="/">


        <table width="95%" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#ffffff">

            <tr>
                <td class="title">
                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository"></xsl:value-of>
        :                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno"></xsl:value-of>
                </td>
            </tr>
            <tr>
                <td>
                    <!-- sub nav table for left view frame-->
                    <table width="100%" border="0" cellspacing="5" cellpadding="5">
                        <tr>
                            <td width="33%" class="subnav_off">
                                <a href="javascript:void(0)" onclick="performXSLTTransformation('TEIManuscriptContents.xsl');">
        Manuscript Contents</a>
                            </td>                            <!-- href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptBiblio.xsl&amp;fileId={$fileId}"-->
                            <td width="33%" class="subnav_off">
                                <a href="javascript:void(0)" onclick="performXSLTTransformation('TEIManuscriptBiblio.xsl');">
        Manuscript Codicological
                                    Bibliography</a>
                            </td>
                            <!-- href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptDesc.xsl&amp;imageark={tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:collation/@ark}&amp;fileId={$fileId}"-->
                            <td class="subnav_off">
                                <a href="javascript:void(0)" onclick="performXSLTTransformation('TEIManuscriptDesc.xsl');">Manuscript
        Description</a>
                            </td>
                        </tr>
                    </table>
                    <!-- sub nav table for left view frame END  -->

                </td>
            </tr>

            <tr>
                <td align="left" valign="top">

                    <!-- Contents for left view frame copy paste the DIV tag section to add more
                    content.
    The page numbers to the right are under span tags--> [                    <xsl:value-of select="$count" />
]                    <b>
                        <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:locus" />
                    </b>
        :                    <i>
                        <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:title" />
                    </i>

                    <br />


                    <DIV class="tan_divider">
                        <br />
                        <!--<img src="images/icon_content.jpg" width="20" height="20" alt="Content" />:-->

                        <tr>
                            <td align="left" valign="top">                                <!-- Book-Level -->
                                <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:msItem">
                                    <xsl:if test="tei:workGroupHeading">
                                        <p>
                                            <h4>[                                                <b>
                                                    <xsl:value-of select="tei:workGroupHeading/tei:locus" />
                                                </b>
        ]                                                <xsl:choose>
                                                    <xsl:when test="tei:workGroupHeading/tei:title">

                                                        <xsl:value-of select="tei:workGroupHeading/tei:title" />

                                                    </xsl:when>

                                                    <xsl:otherwise>
                                                        <xsl:value-of select="tei:workGroupHeading/tei:rubric" />
                                                    </xsl:otherwise>
                                                </xsl:choose>

                                            </h4>
                                        </p>
                                    </xsl:if>

                                    <DIV class="tan_divider">

                                        <xsl:value-of select="$count" />
_<xsl:value-of select="position()" />
                                    <xsl:text></xsl:text>



                                    <xsl:choose>

                                        <xsl:when test="tei:title">
                                            <!-- TODO what should be link  -->
                                            <!-- href="/stgallmss/viewItem.do?count={@n}&amp;pageArk={tei:locus/@facs}&amp;fileId={$fileId}"-->
                                            <a target="_top">
                                                <xsl:value-of select="tei:title" />
                                            </a>                                            <!--
                                                This link should take the user to the Contents page
                                                for the work (generated by workcontents.xsl) -->

                                        </xsl:when>
                                        <xsl:otherwise>
                                            <!-- TODO LINK href="/stgallmss/viewItem.do?xmlstylesheet=TEITranscription.xsl&amp;count={@n}&amp;ark={tei:locus/@facs}&amp;fileId={$fileId}" -->
                                            <a target="_top">
                                                <xsl:value-of select="tei:rubric" />
                                            </a>
                                        </xsl:otherwise>

                                    </xsl:choose>
                                    <span
                                           >
                                            &#160; <xsl:value-of select="tei:locus" />
                                    </span>
                                    <ul style="list-style-type:none">
                                        <xsl:choose>
                                            <xsl:when test="tei:rubric">

                                                <li>
                                                    <b>Rubric: </b>
                                                    <xsl:value-of select="tei:rubric" />
                                                </li>

                                            </xsl:when>
                                            <xsl:otherwise></xsl:otherwise>
                                        </xsl:choose>
                                        <xsl:if test="tei:incipit">
                                            <li>
                                                <b>Incipit: </b>
                                                <xsl:value-of select="tei:incipit" />
                                            </li>
                                        </xsl:if>
                                        <xsl:if test="tei:explicit">
                                            <li>
                                                <b>Explicit: </b>
                                                <xsl:value-of select="tei:explicit" />
                                            </li>
                                        </xsl:if>
                                        <xsl:if test="tei:incipit2">
                                            <br></br>
                                            <li>
                                                <b>Incipit: </b>
                                                <xsl:value-of select="tei:incipit2" />
                                            </li>
                                        </xsl:if>
                                        <xsl:if test="tei:explicit2">
                                            <li>
                                                <b>Explicit: </b>
                                                <xsl:value-of select="tei:explicit2" />
                                            </li>
                                        </xsl:if>
                                        <xsl:if test="tei:note">
                                            <li>
                                                <b>Remarks: </b>
                                                <xsl:value-of select="tei:note" />
                                            </li>
                                        </xsl:if>
                                    </ul>

                                    <xsl:if test="count(tei:listBibl) > 0">
                                        <xsl:if test="count(tei:listBibl/tei:head[. = 'Related Texts'] | tei:listBibl/tei:head[. = 'Bibliography'] | tei:listBibl/tei:head[. = 'Editions']  |  tei:listBibl/tei:head[. = 'Edition']   | tei:listBibl/tei:head[. = 'Edition and Bibliography']  |   tei:listBibl/tei:head[. = 'Translation'])  > 0">
                                            <xsl:if test="count(tei:listBibl/tei:head[. = 'Related Texts'] | tei:listBibl/tei:head[. = 'Bibliography'] | tei:listBibl/tei:head[. = 'Editions'] |  tei:listBibl/tei:head[. = 'Translation'] | tei:listBibl/tei:head[. = 'Edition and Bibliography'] | tei:listBibl/tei:head[. = 'Edition']/following-sibling::tei:biblStruct) > 0">
                                                <!-- href="/stgallmss/viewFile.do?xmlstylesheet=TEISubWorkBibliography.xsl&amp;count={@n}&amp;fileId={$fileId}"-->
                                                <a style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEISubWorkBibliography.xsl','{@n}');">
                                                    <img src="images/icon_bibliography.jpg" width="20" height="20" alt="Bibliography" />
                                                </a>
                                                <xsl:text></xsl:text>
                                            </xsl:if>
                                        </xsl:if>


                                    </xsl:if>
                                    <xsl:if test="count(tei:msItem) > 0">
                                        <!-- /stgallmss/viewItem.do?xmlstylesheet=TEIWorkSubContents.xsl&amp;count={@n}&amp;pageArk={tei:locus/@facs}&amp;fileId={$fileId} -->

                                        <a target="_top" style="border-style:none" href="javascript:void(0)" onclick="performXSLTTransformation('TEIWorkSubContents.xsl','{@n}', '{tei:locus/@facs}');">
                                            <img src="/images/icon_content.jpg" width="20" height="20" alt="Content" style="" />
                                        </a>
                                        <xsl:text></xsl:text>
                                    </xsl:if>
                                    <!-- href="/stgallmss/viewItem.do?xmlstylesheet=TEITranscription.xsl&amp;count={@n}&amp;pageArk={tei:locus/@facs}&amp;fileId={$fileId}" -->
                                    <a target="_top" style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEITranscription.xsl','{@n}', '{tei:locus/@facs}');">
                                        <img src="/images/icon_text.jpg" width="20" height="20" alt="Text" style="" />
                                    </a>
                                    <xsl:text></xsl:text>
                                    <br />
                                </DIV>


                            </xsl:for-each>
                            <!-- </ul> -->
                        </td>
                    </tr>


                </DIV>

                <!-- Content table for left view frame END-->
                <br />
                <br />
            </td>
        </tr>
    </table>

</xsl:template>

</xsl:stylesheet>