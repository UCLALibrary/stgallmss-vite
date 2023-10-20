<?xml version="1.0" encoding="UTF-8"?>

<!-- St. Gall Stylesheet for the Main Contents page of a Manuscript -->
<!-- edits by Elizabeth McAulay, 5/25/10 -->
<!-- minor edits by Elizabeth McAulay, 9/24/10 -->
<!-- edited by Richard Pollard, 10/2010 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:param name="fileId" />
    <xsl:param name="countContent" select="1" />
    <xsl:output method="html" />
    <xsl:template match="/">
        <xsl:variable name="checkBibliography" />
        <xsl:variable name="checkTranslation" />

        <table width="95%" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#ffffff">
            <!-- manuscript  repository and idno-->
            <tr>
                <td class="title">
                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository"></xsl:value-of>
        :                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno"></xsl:value-of>
                </td>
            </tr>
            <!-- manuscript  repository and idno end-->
            <tr>
                <td>

                    <!-- sub nav table for left view frame-->
                    <table width="100%" border="0" cellspacing="5" cellpadding="5">
                        <tr>
                            <td width="33%" class="subnav_on">Manuscript Contents</td>
                            <!-- href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptBiblio.xsl&amp;fileId={$fileId}"-->
                            <td width="33%" class="subnav_off">
                                <a href="javascript:void(0)" onclick="performXSLTTransformation('TEIManuscriptBiblio.xsl');">Manuscript
        Codicological
                                    Bibliography</a>
                            </td>
                            <!-- href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptDesc.xsl&amp;imageark={tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:collation/@ark}&amp;fileId={$fileId}"-->
                            <td class="subnav_off">
                                <a href="javascript:void(0)" onclick="performXSLTTransformation('TEIManuscriptDesc.xsl');">Manuscript
        Codicological
                                    Description</a>
                            </td>
                        </tr>
                    </table>
                    <!-- sub nav table for left view frame END  -->

                </td>
            </tr>

            <tr width="100%">
                <td align="left" valign="top" width="100%">

                    <!-- Contents for left view frame copy paste the DIV tag section to add more
                    content.
                                The page numbers to the right are under span tags-->
                    <!-- manuscripts which dont have  table of contents-->
                    <xsl:if test="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:mini">
                        <b>
                            <xsl:text>Temporary Summary of Contents:</xsl:text>
                        </b>
                        <br></br>
                        <br></br>
                        <xsl:copy-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:mini" />
                    </xsl:if>
                    <!-- manuscripts which dont have  table of contents end-->
                    <!-- workGroup -->

                    <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem">

                        <xsl:if test="tei:workGroupHeading">
                            <p> heading for workGroupHeading <h4>[                                <b>
                                    <xsl:value-of select="tei:workGroupHeading/tei:locus" />
                                </b>
        ]                                <xsl:choose>
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

                        <xsl:value-of select="position()" />
 .                        <xsl:variable name="locusFacs" select="normalize-space(tei:locus/@target)" />
                        <!-- if title does not exist use rubric -->
                        <xsl:choose>

                            <xsl:when test="tei:title">
                                <a target="_top" href="{$locusFacs}">
                                    <xsl:value-of select="tei:title" />
                                </a>                                <!--
                                    This link should take the user to the Contents page for the work
                                    (generated by TEITranscription.xsl) -->
                            </xsl:when>
                            <xsl:otherwise>
                                <a target="_top" href="{$locusFacs}">
                                    <xsl:value-of select="tei:rubric" />
                                </a>
                            </xsl:otherwise>

                        </xsl:choose>

                        <!-- if title does not exist use rubric end -->
                        <span>
        &#160; <xsl:value-of select="tei:locus" />
                        </span>

                        <!-- rubric,incipit, explicit-->
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
                            <xsl:if test="tei:note">
                                <li>
                                    <b>Remarks: </b>
                                    <xsl:value-of select="tei:note" />
                                </li>
                            </xsl:if>
                        </ul>

                        <!-- rubric,incipit, explicit end-->

                        <!-- Bibliography -->
                        <xsl:if test="count(tei:listBibl) > 0">
                            <xsl:if test="count(tei:listBibl/tei:head[. = 'Related Texts'] | tei:listBibl/tei:head[. = 'Bibliography'] | tei:listBibl/tei:head[. = 'Editions']  |  tei:listBibl/tei:head[. = 'Edition']   | tei:listBibl/tei:head[. = 'Edition and Bibliography']  |   tei:listBibl/tei:head[. = 'Translation'])  > 0">
                                <xsl:if test="count(tei:listBibl/tei:head[. = 'Related Texts'] | tei:listBibl/tei:head[. = 'Bibliography'] | tei:listBibl/tei:head[. = 'Editions'] |  tei:listBibl/tei:head[. = 'Translation'] | tei:listBibl/tei:head[. = 'Edition and Bibliography'] | tei:listBibl/tei:head[. = 'Edition']/following-sibling::tei:biblStruct) > 0">
                                    <!-- href="/stgallmss/viewFile.do?xmlstylesheet=TEIWorkBibliography.xsl&amp;count={@n}&amp;fileId={$fileId}" -->
                                    <a style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEIWorkBibliography.xsl','{@n}');">
                                        <img src="/images/icon_bibliography.jpg" width="20" height="20" alt="Bibliography" />
                                    </a>
                                    <xsl:text></xsl:text>
                                </xsl:if>
                            </xsl:if>


                            <!-- Content -->
                        </xsl:if>
                        <xsl:if test="count(tei:msItem) > 0">

                            <!-- href="{$locusFacs}" locusFacs its th msitem target variable created in this xslt-->
                            <a target="_top" style="border-style:none" href="javascript:void(0)" onclick="performXSLTTransformation('TEIWorkContents.xsl','{@n}');">
                                <img src="/images/icon_content.jpg" width="20" height="20" alt="Content" style="" />
                            </a>
                            <xsl:text></xsl:text>
                        </xsl:if>
                        <!-- Transcription  -->
                        <xsl:choose>
                            <!-- dont remember why this condition was tested -->
                            <xsl:when test="count(tei:msItem) = 0">

                                <xsl:variable name="transcriptionFacs" select="normalize-space(tei:locus/@facs)" />
                                <a target="_top" style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEITranscription.xsl','{@n}','{$transcriptionFacs}')">
                                    <img src="/images/icon_text.jpg" width="20" height="20" alt="Text" style="" />
                                </a>
                                <xsl:text></xsl:text>
                            </xsl:when>

                            <!-- editionArk needs to be added above -->
                            <xsl:otherwise>

                                <xsl:variable name="transcriptionFacs" select="normalize-space(tei:locus/@facs)" />
                                <a target="_top" style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEITranscription.xsl','{@n}','{$transcriptionFacs}')">
                                    <img src="/images/icon_text.jpg" width="20" height="20" alt="Text" style="" />
                                </a>
                                <xsl:text></xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                        <br />

                    </DIV>


                </xsl:for-each>
                <!-- work end -->
            </td>
        </tr>
    </table>

</xsl:template>

</xsl:stylesheet>