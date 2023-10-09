<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:include href="TEIBibliography.xsl" />
    <!--xsl:param
    name="fileId"/-->
    <xsl:output method="html" />

    <!-- St. Gall Stylesheet for the  Codicological Bibliography page of a manuscript-->
    <!-- written by Parinita Ghorpade, December 2009 -->
    <!-- edited by Lisa McAulay, July 2010 -->

    <xsl:template match="/">


        <table width="95%" border="0" align="center" cellpadding="3" cellspacing="0"
            bgcolor="#ffffff">
            <!-- manuscript header-->
            <tr>
                <td class="title">
                    <xsl:value-of
                        select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository" />
        : <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno" />
                </td>
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
                                >Manuscript
        Contents</a>
                            </td>
                            <td width="33%" class="subnav_on">Manuscript Codicological
                                Bibliography</td>
                            <!--
                            href="/stgallmss/viewFile.do?xmlstylesheet=TEIManuscriptDesc.xsl&amp;imageark={tei:TEI/tei:text/tei:body/tei:msDesc/tei:physDesc/tei:collation/@ark}&amp;fileId={$fileId}"-->
                            <td class="subnav_off">
                                <a href="javascript:void(0)"
                                    onclick="performXSLTTransformation('TEIManuscriptDesc.xsl');">Manuscript
        Codicological
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
                        The page numbers to the right are under span tags-->
                    <xsl:for-each
                        select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:additional/tei:listBibl">
                        <DIV class="tan_divider">

                            <b>
                                <xsl:value-of select="position()" /> . <xsl:value-of
                                    select="tei:head" /> :</b>
                            <ul>
                                <xsl:for-each select="tei:biblStruct">
                                    <!-- each citation gets its own paragraph -->
                                    <p>
                                        <xsl:call-template name="lisabibliography"></xsl:call-template>
                                    </p>
                                </xsl:for-each>

                                <xsl:for-each select="tei:bibl">
                                    <xsl:call-template name="lisaBibl"></xsl:call-template>
                                </xsl:for-each>


                            </ul>

                            <br />

                        </DIV>
                    </xsl:for-each>

                    <!-- Content table for left view frame END-->
                    <br />
                    <br />
                </td>
            </tr>

        </table>


    </xsl:template>

</xsl:stylesheet>