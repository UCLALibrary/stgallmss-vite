<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">

    <xsl:param name="count"/>
    <!-- below commented-out by RMP; only for testing -->
    <!-- <xsl:param name="count" select="1"></xsl:param> -->
    <xsl:param name="fileId"/>
    <xsl:output method="html"/>
    <xsl:include href="TEIBibliography.xsl"/>
    <!-- <xsl:param name="count" select="8"></xsl:param>lisa needs to delete before uploading to subversion -->

    <!-- St. Gall Stylesheet for the  bibliography page of a work within a manuscript-->
    <!-- written by Parinita Ghorpade, December 2009 -->
    <!-- edited by Lisa McAulay, June - July 2010 -->
    <!-- some edits by Richard Pollard, 10/2010 -->

    <xsl:template match="/">

        <table class="textAndImage">
            <tr>
                <td>

                    <!-- sub nav table for left view frame-->
                    <table width="100%" border="0" cellspacing="5" cellpadding="5">
                        <tr>
                            <td width="33%" class="subnav_off">
                                <a href="javascript:void(0)" onclick="performXSLTTransformation('TEIManuscriptContents.xsl');">
                Manuscript Contents</a>
                            </td>
                            <!-- href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptBiblio.xsl&amp;fileId={$fileId}"-->
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

                    <DIV class="tan_divider">

                        <!-- heading information; manuscript number, etc. -->

                        <span>
                            <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository" />
:                            <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno"/>
                            <br/>
                            <b>
                                <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem/tei:msItem[@n=$count]/tei:locus" />
                            </b>:                            <a target="_top" href="/stgallmss/viewItem.do?count={$count}&amp;pageArk={tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem/tei:msItem[@n=$count]/tei:locus/@facs}&amp;fileId={$fileId}">

                                <i>
                                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem/tei:msItem[@n=$count]/tei:title" />
                                </i>
                            </a>
                        </span>
                        <p>
                            <!-- begin an ordered list -->
                            <ol style="list-style-type:none" id="WorkBibiliography">

                                <!-- for each listBibl element under the msItem, do the following -->
                                <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem/tei:msItem[@n=$count]/tei:listBibl">
                                    <li>
                                        <xsl:if test="tei:nobib">
                                            <xsl:text>See </xsl:text>
                                            <a target="_top" style="border-style:none" href="javascript:void(0)" onclick="performXSLTTransformation('TEIWorkContents.xsl',{@n},{tei:locus/@facs})">here.</a>
                                            <xsl:text></xsl:text>

                                        </xsl:if>
                                        <!-- /stgallmss/viewItem.do?xmlstylesheet=TEIWorkContents.xsl&amp;count={@n}&amp;pageArk={tei:locus/@facs}&amp;fileId={$fileId} -->
                                        <!-- print in bold the listBibl heading -->
                                        <b>
                                            <xsl:value-of select="normalize-space(tei:head)" />
                                        </b>
                                        <!-- for each citation, do the following -->
                                        <xsl:for-each select="tei:biblStruct">
                                            <!-- each citation gets its own paragraph -->
                                            <p>
                                                <xsl:call-template name="lisabibliography"/>
                                            </p>

                                            <!-- end citation -->
                                        </xsl:for-each>


                                        <xsl:for-each select="tei:bibl">
                                            <p>
                                                <xsl:call-template name="lisaBibl"/>
                                            </p>
                                        </xsl:for-each>
                                    </li>
                                </xsl:for-each>
                            </ol>
                        </p>
                        <br/>
                        <br/>
                    </DIV>
                </td>
            </tr>
        </table>

    </xsl:template>


</xsl:stylesheet>
