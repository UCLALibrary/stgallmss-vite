<?xml version="1.0" encoding="UTF-8"?>
<!-- St. Gall Stylesheet for displaying the transcription of a single page in the manuscript-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:param name="count" />
    <xsl:param name="fileId" />
    <xsl:param name="ark" />
    <xsl:param name="nextark" />
    <xsl:param name="prevark" />
    <xsl:param name="found" select="false" />
    <xsl:output method="html" />
    <xsl:template match="/">
        <table width="95%" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="#ffffff">
            <tr>
                <td class="title">
                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:repository" />
        :                    
                    <xsl:value-of select="tei:TEI/tei:text/tei:body/tei:msDesc/tei:msIdentifier/tei:idno" />
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
            <!--<tr><td><table width="100%" border="0" cellspacing="0" cellpadding="3"><tr><td width="10%" height="29" align="left" valign="middle" nowrap="nowrap">Legend:</td><td width="20%" align="left" valign="middle" nowrap="nowrap"><img src="images/icon_bibliography.jpg" width="20" height="20" alt=" Bibliography" />
            Bibliography</td><td width="19%" align="left" valign="middle" nowrap="nowrap"><img src="images/icon_translation.jpg" width="20" height="20" alt="Translation" /> Translation</td><td width="16%" align="left" valign="middle" nowrap="nowrap"><img src="images/icon_content.jpg" width="20" height="20" alt="Content" /> Content</td><td width="35%" align="left" valign="middle" nowrap="nowrap"><img src="images/icon_text.jpg" width="20" height="20" alt="Text" /> Text </td></tr></table></td></tr>-->
            <tr>
                <td align="left" valign="top" width="100%">
                    <!-- Contents for left view frame copy paste the DIV tag section to add more
                    content.
                                The page numbers to the right are under span tags-->
                    <DIV class="tan_divider">
                        <table>
                            <tr>
                                <td width="100%">
                                    <!-- previous link this is not working anymore-->
                                    <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div">
                                        <xsl:value-of select="tei:ab/tei:pb" />
                                        <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$prevark]">
                                            <a target="_top" href="/stgallmss/viewItem.do?pageArk={$prevark}&amp;fileId={$fileId}&amp;count={@n}">
                                                <img src="/images/back24x22.gif" style="border:none" alt="Back" />
                                            </a>
                                        </xsl:if>
                                    </xsl:for-each>
                                </td>
                                <td width="100%">
                                    <!-- next link this is not working anymore-->
                                    <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div">
                                        <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id) = $nextark]">
                                            <span align="right">
                                                <a target="_top" href="/stgallmss/viewItem.do?pageArk={$nextark}&amp;fileId={$fileId}&amp;count={@n}">
                                                    <img src="/images/next24x22.gif" style="border:none" alt="Next" />
                                                </a>
                                            </span>
                                        </xsl:if>
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <div class="transcriptionSource">
                            <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div">
                                <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$ark]">
                                    <xsl:variable name="workCount" select="@n" />
                                    <!--span>workcount = <xsl:value-of select="$workCount"/></span>
                                    <br/>
                                    <span>count = <xsl:value-of select="$count"/></span-->
                                    <xsl:if test="$workCount &lt; $count">
                                        <div class="transcription-title">
                                            <!-- work bibliography image and link-->
                                            <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl) > 0">
                                                <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Edition'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Translation'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Edition and Bibliography']   | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Bibliography'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Editions']) > 0">
                                                    <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Bibliography'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Edition'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Translation'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Edition and Bibliography']   | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$count]/tei:listBibl/tei:head[. = 'Editions']/following-sibling::tei:biblStruct) > 0">
                                                        <a style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEIWorkBibliography.xsl','{$count}');">
                                                            <img src="images/icon_bibliography.jpg" width="20" height="20" alt="Bibliography" />
                                                        </a>
                                                        <xsl:text></xsl:text>
                                                    </xsl:if>
                                                </xsl:if>
                                            </xsl:if>
                                            <!-- work title-->
                                            <span class="count"> 
                                                [                                                
                                                <xsl:value-of select="$count" />
                                                ] 
                                            </span>
                                            <b>
                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:locus" />
 
                                                :                                                
                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:title" />
                                            </b>
                                        </div>

                                        <!-- below added by RMP 10/3/2011 to identify the edition of
                                        the transcription in question -->
                                        <div class="transcription-text">

                                            <xsl:if test="not(contains($count, '_'))">
                                                <!-- to the left is the beginning of a fix for sub-item
                                                transcription tags begun by RMP 6/4/11 -->
                                                <xsl:choose>
                                                    <xsl:when test="not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:msItem)">
                                                        <xsl:choose>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'PL')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'AASS')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'MGH')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:if test="../tei:biblStruct[@type='transcriptionSource']">
                                                                    <xsl:text> (ed. </xsl:text>
                                                                </xsl:if>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:choose>
                                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']">
                                                                        <i>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                        </i>
                                                                        <xsl:text>, </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']">
                                                                            <xsl:text></xsl:text>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'])">
                                                                        <i>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                        </i>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']">
                                                                            <xsl:text>, </xsl:text>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                </xsl:choose>
                                                                <xsl:if test="../tei:biblStruct[@type='transcriptionSource']">
                                                                    <xsl:text>)</xsl:text>
                                                                </xsl:if>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:msItem">
                                                        <xsl:choose>
                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']">
                                                                <xsl:choose>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'PL')">
                                                                        (ed. 
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'AASS')">
                                                                        (ed. 
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'MGH')">
                                                                        <xsl:text> (ed. </xsl:text>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor">
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                            <xsl:text>, </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text> (ed. </xsl:text>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor">
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                            <xsl:text>, </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:choose>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']">
                                                                                <i>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                                </i>
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                                <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']">
                                                                                    <xsl:text></xsl:text>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                                </xsl:if>
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'])">
                                                                                <i>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                                </i>
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $count]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                            </xsl:when>
                                                                        </xsl:choose>
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:text> (For transcription source, see bibliography)</xsl:text>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:if>

                                            <xsl:if test="contains($count, '_')">
                                                are we in this
                                                <div class="transcription-title">
                                                    <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl) > 0">
                                                        <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Translation'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition and Bibliography']   | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Bibliography'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Editions']) > 0">
                                                            <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Bibliography'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Translation'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition and Bibliography']   | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Editions']/following-sibling::tei:biblStruct) > 0">
                                                                <a style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEIWorkBibliography.xsl','{$workCount}');">
                                                                    <img src="images/icon_bibliography.jpg" width="20" height="20" alt="Bibliography" />
                                                                </a>
                                                                <xsl:text></xsl:text>
                                                            </xsl:if>
                                                        </xsl:if>
                                                    </xsl:if>
                                                    <b>
                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:locus" />
                                                        :                                
                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:title" />
                                                    </b>
                                                </div>
                                                <xsl:choose>
                                                    <xsl:when test="not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:msItem)">
                                                        <xsl:choose>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'PL')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'AASS')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'MGH')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:text> (ed. </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:choose>
                                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']">
                                                                        <i>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                        </i>
                                                                        <xsl:text>, </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']">
                                                                            <xsl:text></xsl:text>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'])">
                                                                        <i>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                        </i>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']">
                                                                            <xsl:text>, </xsl:text>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                </xsl:choose>
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:msItem">
                                                        <xsl:choose>
                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']">
                                                                <xsl:choose>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'PL')">
                                                                        (ed. 
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'AASS')">
                                                                        (ed. 
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'MGH')">
                                                                        <xsl:text> (ed. </xsl:text>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor">
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                            <xsl:text>, </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:text> (ed. </xsl:text>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor">
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                            <xsl:text>, </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:choose>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']">
                                                                                <i>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                                </i>
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                                <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']">
                                                                                    <xsl:text></xsl:text>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                                </xsl:if>
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'])">
                                                                                <i>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                                </i>
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                            </xsl:when>
                                                                        </xsl:choose>
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:text> (For transcription source, see bibliography)</xsl:text>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:if>
                                        </div>
                                        <!-- above added by RMP 10/3/2011 to identify the edition of
                                        the transcription in question -->
                                        <br />
                                        <!-- Transcription section starts here-->
                                        <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div[@n = $workCount]"></xsl:apply-templates>
                                        <!-- overlaping text in 2 works-->
                                        <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div[@n = $count]" mode="forward"></xsl:apply-templates>
                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']">
                                            <xsl:if test="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']/tei:div[@n = $workCount]/tei:ab/tei:pb[normalize-space(@facs) = $ark]">
                                                <br />
                                                <b>TRANSLATION:</b>
                                                <br />
                                            </xsl:if>
                                            <!-- Translation section starts here-->
                                            <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']/tei:div[@n = $workCount]" mode="Translation"></xsl:apply-templates>
                                            <!-- overlaping text in 2 works-->
                                            <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']/tei:div[@n = $count]" mode="Translationforward"></xsl:apply-templates>
                                        </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="$count = '' or $workCount = $count">

                                        <div class="transcription-title">
                                            <!-- work bibliography image and link-->
                                            <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl) > 0">
                                                <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Translation'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition and Bibliography']   | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Bibliography'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Editions']) > 0">
                                                    <xsl:if test="count(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Bibliography'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Translation'] | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Edition and Bibliography']   | /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n=$workCount]/tei:listBibl/tei:head[. = 'Editions']/following-sibling::tei:biblStruct) > 0">
                                                        <a style="" href="javascript:void(0)" onclick="performXSLTTransformation('TEIWorkBibliography.xsl','{$workCount}');">
                                                            <img src="images/icon_bibliography.jpg" width="20" height="20" alt="Bibliography" />
                                                        </a>
                                                        <xsl:text></xsl:text>
                                                    </xsl:if>
                                                </xsl:if>
                                            </xsl:if>
                                            <!-- work title-->
                                            <span> 
                                                [        
                                                <xsl:value-of select="@n" />
                                                ] 
                                            </span>
                                            <b>
                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:locus" />
                                                :        
                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:title" />
                                            </b>
                                        </div>
                                        <div class="transcription-text">
                                            <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl or /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:msItem/tei:listBibl">
                                                <xsl:choose>
                                                    <xsl:when test="not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:msItem)">
                                                        <xsl:choose>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'PL')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'AASS')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'MGH')">
                                                                (ed. 
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                <xsl:text></xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                <xsl:text>: </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:text> (ed. </xsl:text>
                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                <xsl:text>, </xsl:text>
                                                                <xsl:choose>
                                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']">
                                                                        <i>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                        </i>
                                                                        <xsl:text>, </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']">
                                                                            <xsl:text></xsl:text>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'])">
                                                                        <i>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                        </i>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']">
                                                                            <xsl:text>, </xsl:text>
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                        </xsl:if>
                                                                    </xsl:when>
                                                                </xsl:choose>
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:msItem">
                                                        <xsl:choose>
                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']">
                                                                <xsl:choose>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'PL')">
                                                                        (ed. 
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'AASS')">
                                                                        (ed. 
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:when test="contains(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'],'MGH')">
                                                                        <xsl:text> (ed. </xsl:text>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor">
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                            <xsl:text>, </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                        <xsl:text></xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                        <xsl:text>: </xsl:text>
                                                                        <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource'] or /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:msItem/tei:listBibl/tei:biblStruct[@type='transcriptionSource']">
                                                                            <xsl:text> (ed. </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor">
                                                                            <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:editor" />
                                                                            <xsl:text>, </xsl:text>
                                                                        </xsl:if>
                                                                        <xsl:choose>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']">
                                                                                <i>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                                </i>
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s']" />
                                                                                <xsl:if test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']">
                                                                                    <xsl:text></xsl:text>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='vol']" />
                                                                                </xsl:if>
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m'] and not(/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='s'])">
                                                                                <i>
                                                                                    <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:title[@level='m']" />
                                                                                </i>
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='col']" />
                                                                            </xsl:when>
                                                                            <xsl:when test="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']">
                                                                                <xsl:text>, </xsl:text>
                                                                                <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $workCount]/tei:listBibl/tei:biblStruct[@type='transcriptionSource']/tei:monogr/tei:imprint/tei:biblScope[@type='pp']" />
                                                                            </xsl:when>
                                                                        </xsl:choose>
                                                                        <xsl:text>)</xsl:text>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:text> (For transcription source, see bibliography)</xsl:text>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:if>
                                        </div>
                                        <!-- above added by RMP 10/3/2011 to identify the edition of
                                        the transcription in question -->
                                        <br />
                                        <!-- Transcription section starts here-->
                                        <div class="transcription-text">
                                            <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div[@n = $workCount]"></xsl:apply-templates>
                                            <!-- overlaping text in 2 works-->

                                            <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$ark] and ( not($count ) or @n = $count ) ">
                                                <xsl:variable select="@n + 1" name="nextCount" />
                                                <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$ark]/@n  =  /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = @n]/tei:locus/@to and tei:ab/tei:pb[normalize-space(@xml:id)=$ark]/@n  =  /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $nextCount]/tei:locus/@from">
                                                    <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div[@n = $nextCount]" mode="forward"></xsl:apply-templates>
                                                </xsl:if>
                                            </xsl:if>
                                        </div>
                                        <xsl:if test="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']">
                                            <xsl:if test="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']/tei:div[@n = $workCount]/tei:ab/tei:pb[normalize-space(@facs) = $ark]">
                                                <br />
                                                <b>TRANSLATION:</b>
                                                <br />
                                            </xsl:if>
                                            <!-- Translation section starts here-->
                                            <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']/tei:div[@n = $workCount]" mode="Translation"></xsl:apply-templates>
                                            <!-- overlaping text in 2 works-->
                                            <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$ark] and ( not($count ) or @n = $count ) ">
                                                <xsl:variable select="@n + 1" name="nextCount" />
                                                <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$ark]/@n  =  /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = @n]/tei:locus/@to and tei:ab/tei:pb[normalize-space(@xml:id)=$ark]/@n  =  /tei:TEI/tei:text/tei:body/tei:msDesc/tei:msContents/tei:msItem[@n = $nextCount]/tei:locus/@from">
                                                    <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@type = 'translation']/tei:div[@n = $nextCount]" mode="Translationforward"></xsl:apply-templates>
                                                </xsl:if>
                                            </xsl:if>
                                        </xsl:if>
                                    </xsl:if>
                                </xsl:if>
                            </xsl:for-each>
                            <br />
                            <table>
                                <tr>
                                    <td width="100%">
                                        <!-- previous link-->
                                        <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div">
                                            <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$prevark]">
                                                <a target="_top" href="/stgallmss/viewItem.do?pageArk={$prevark}&amp;fileId={$fileId}&amp;count={@n}">
                                                    <img src="/images/back24x22.gif" style="border:none" alt="Back" />
                                                </a>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </td>
                                    <td width="100%">
                                        <!-- next link-->
                                        <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div[@type = 'transcription']/tei:div">
                                            <xsl:if test="tei:ab/tei:pb[normalize-space(@xml:id)=$nextark]">
                                                <span align="right">
                                                    <a target="_top" href="/stgallmss/viewItem.do?pageArk={$nextark}&amp;fileId={$fileId}&amp;count={@n}">
                                                        <img src="/images/next24x22.gif" style="border:none" alt="Next" />
                                                    </a>
                                                </span>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </DIV>
                    <!-- Content table for left view frame END-->
                    <br />
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
        </table>
    </xsl:template>
    <xsl:template match="tei:TEI/tei:text/tei:body/tei:div/tei:div">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="tei:ab">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="tei:lb">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@xml:id) = $ark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:cb">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@xml:id) = $ark] ) = 1">
            <br />
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@xml:id) = $ark] ) = 1">
            <br />
            <xsl:if test="@rend='red'">
                <span style="color:red">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
            <xsl:if test="@rend='green'">
                <span style="color:green">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:pb">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@xml:id) = $ark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@xml:id) = $ark] ) = 1">
            <xsl:value-of select="." />
        </xsl:if>
    </xsl:template>
    <xsl:template match="comment()"></xsl:template>
    <xsl:template match="tei:TEI/tei:text/tei:body/tei:div/tei:div" mode="Translation">
        <xsl:apply-templates mode="Translation" />
    </xsl:template>
    <xsl:template match="tei:ab" mode="Translation">
        <xsl:apply-templates mode="Translation" />
    </xsl:template>
    <xsl:template match="tei:lb" mode="Translation">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@facs) = $ark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:cb" mode="Translation">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@facs) = $ark] ) = 1">
            <br />
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:hi" mode="Translation">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@facs) = $ark] ) = 1">
            <br />
            <xsl:if test="@rend='red'">
                <span style="color:red">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
            <xsl:if test="@rend='green'">
                <span style="color:green">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:pb" mode="Translation">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@facs) = $ark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="text()" mode="Translation">
        <xsl:if test="count(./preceding-sibling::tei:pb[1][normalize-space(@facs) = $ark] ) = 1">
            <xsl:value-of select="." />
        </xsl:if>
    </xsl:template>
    <xsl:template match="comment()" mode="Translation"></xsl:template>
    <xsl:template match="tei:TEI/tei:text/tei:body/tei:div/tei:div" mode="forward">
        <xsl:apply-templates mode="forward" />
    </xsl:template>
    <xsl:template match="tei:ab" mode="forward">
        <xsl:apply-templates mode="forward" />
    </xsl:template>
    <xsl:template match="tei:lb" mode="forward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@xml:id) = $nextark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:cb" mode="forward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@xml:id) = $nextark] ) = 1">
            <br />
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:hi" mode="forward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@xml:id) = $nextark] ) = 1">
            <br />
            <xsl:if test="@rend='red'">
                <span style="color:red">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
            <xsl:if test="@rend='green'">
                <span style="color:green">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:pb" mode="forward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@xml:id) = $nextark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="text()" mode="forward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@xml:id) = $nextark] ) = 1">
            <xsl:value-of select="." />
        </xsl:if>
    </xsl:template>
    <xsl:template match="comment()" mode="forward"></xsl:template>
    <xsl:template match="tei:TEI/tei:text/tei:body/tei:div/tei:div" mode="Translationforward">
        <xsl:apply-templates mode="Translationforward" />
    </xsl:template>
    <xsl:template match="tei:ab" mode="Translationforward">
        <xsl:apply-templates mode="Translationforward" />
    </xsl:template>
    <xsl:template match="tei:lb" mode="Translationforward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@facs) = $nextark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:cb" mode="Translationforward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@facs) = $nextark] ) = 1">
            <br />
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:hi" mode="Translationforward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@facs) = $nextark] ) = 1">
            <br />
            <xsl:if test="@rend='red'">
                <span style="color:red">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
            <xsl:if test="@rend='green'">
                <span style="color:green">
                    <xsl:value-of select="." />
                </span>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:pb" mode="Translationforward">
        <xsl:if test="count(./following-sibling::tei:pb[1][normalize-space(@facs) = $nextark] ) = 1">
            <br />
        </xsl:if>
    </xsl:template>
    <xsl:template match="text()" mode="forward">
        <xsl:if test="count(./following-sibling::tei:pb[1][@xml:id = $nextark] ) = 1">
            <xsl:value-of select="." />
        </xsl:if>
    </xsl:template>
    <xsl:template match="comment()" mode="Translationforward"></xsl:template>
</xsl:stylesheet>