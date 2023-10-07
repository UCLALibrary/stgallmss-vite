<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
    <!-- <xsl:param name="fileId"/>-->
    <!--I don't think I need this, but I'm not sure; lisa 6/10/10-->
    <xsl:output method="html"/>
    <!-- St. Gall Stylesheet for the Bibliography -->
    <!-- written by Lisa McAulay, 7/13/10, edited 7/22/10, 7/23/10, 7/27/10, 7/28/10/, 7/29/10 -->
    <!-- edited and much enlarged by Richard Pollard 10/2010 -->
    
    
    <xsl:template name="lisabibliography">
        
        <xsl:choose>
            
            <xsl:when test="tei:analytic">
                
                <xsl:for-each select="tei:analytic/tei:author">
                    <xsl:call-template name="author"/>
                </xsl:for-each>
                
                <xsl:for-each select="tei:analytic/tei:title">
                    <xsl:call-template name="title"/>
                </xsl:for-each>
                
            </xsl:when>
            
            <!-- for cases where there is no "analytic" section to the citation -->
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="tei:monogr/tei:author">
                        <xsl:for-each select="tei:monogr/tei:author">
                            <xsl:call-template name="author"/>
                        </xsl:for-each>
                    </xsl:when>
                    
                </xsl:choose>
                
                
                <xsl:for-each select="tei:monogr/tei:title">
                    <xsl:call-template name="title"/>
                </xsl:for-each>
                
                
                
                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="lisaBibl" match="tei:bibl" mode="bibliography">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:note">
        <!-- This section provides for the line-breaking and punctuation of <note> fields.  I wasn't quite sure about the first 'when' condition but everything seems to work. RMP  -->
        <xsl:choose>
            
            <xsl:when test="substring(normalize-space(.),string-length(normalize-space(.))) ='.'">          
                <xsl:apply-templates/>
                <xsl:text>. </xsl:text> 
            </xsl:when> 
            <xsl:when test="tei:ref">                 
                <xsl:apply-templates/>
                <xsl:text>. </xsl:text>
            </xsl:when>          
            <xsl:otherwise>                                
                <xsl:apply-templates/>
                <xsl:text>. </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <xsl:text> </xsl:text>        
        <a target="_new" href="{@target}">
            <xsl:value-of select="normalize-space(text())"/>
        </a>        
    </xsl:template>
    
    <xsl:template name="author">
        <xsl:choose>
            <xsl:when test="substring(normalize-space(.),string-length(normalize-space(.))) = '.' ">
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space()"/>
                <xsl:text>. </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="editor">
        <xsl:choose>
            <xsl:when test="substring(../tei:title[@level='s']/text(),1,3)='MGH'"> </xsl:when>
            <xsl:when test="not(../tei:author)">
                <xsl:value-of select="."/>
                <xsl:text>, ed. </xsl:text> 
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> ed.  </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
            </xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    
    
    
    <xsl:template name="title">
        
        <!-- for article titles and other titles to appear in quotation marks -->
        <xsl:if test="@level = 'a'">
            <xsl:text>"</xsl:text>
            <xsl:call-template name="titleText"/>
            <xsl:text>"</xsl:text>
            
            <xsl:if test="../tei:note">
                <xsl:value-of select="../tei:note"/>
            </xsl:if>     
            
            <xsl:if test="../../tei:monogr/tei:respStmt">
                <xsl:text>, </xsl:text>
                <xsl:choose>
                    <xsl:when test="normalize-space(../../tei:monogr/tei:respStmt/tei:resp/text())='Trans.'">
                        <xsl:text>trans.</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="../../tei:monogr/tei:respStmt/tei:resp"/>
                    </xsl:otherwise>
                    
                </xsl:choose>
                <xsl:text> </xsl:text>
                <xsl:for-each select="../../tei:monogr/tei:respStmt">
                    <xsl:variable name="countOfPeople" select="count(tei:name)"/>
                    
                    <xsl:for-each select="tei:name">
                        <xsl:choose>
                            <xsl:when test="not(position()=$countOfPeople)">
                                
                                <xsl:value-of select="normalize-space(.)"/>
                                <xsl:text>, </xsl:text>
                                
                            </xsl:when>
                            
                            <xsl:otherwise>
                                
                                <xsl:choose>
                                    <xsl:when test="not(position()=(1))">
                                        <xsl:text>and </xsl:text>
                                        <xsl:value-of select="normalize-space(.)"/>
                                        
                                        <xsl:text> </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="normalize-space(.)"/>
                                        <xsl:text></xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    
                </xsl:for-each>
                
            </xsl:if>
            
            <xsl:choose>
                <!-- for articles in a monograph (i.e. titlelevel="m") -->
                <xsl:when test="../../tei:monogr/tei:title/@level='m'">
                    <xsl:text>, in </xsl:text>
                    <i>
                        <xsl:value-of select="normalize-space(../../tei:monogr/tei:title[@level='m'])"/>
                        <!-- <xsl:value-of select="../../tei:monogr/tei:title[@level='m']"/> -->
                    </i>
                    
                    <!-- if the book that the article is in has an editor -->
                    <xsl:if test="../../tei:monogr/tei:editor">
                        
                        <xsl:for-each select="../../tei:monogr">
                            <xsl:variable name="countOfPeople" select="count(tei:editor)"/>
                            <xsl:text>, </xsl:text>
                            <xsl:text>ed. </xsl:text>
                            <xsl:for-each select="tei:editor">
                                
                                <xsl:choose>
                                    <xsl:when test="not(position()=$countOfPeople)">
                                        
                                        <xsl:value-of select="normalize-space(.)"/>
                                        <xsl:if test="$countOfPeople>2">
                                            <xsl:text>,</xsl:text>
                                        </xsl:if>
                                        <xsl:text></xsl:text>
                                    </xsl:when>
                                    
                                    <xsl:otherwise>
                                        
                                        <xsl:choose>
                                            <xsl:when test="not(position()=(1))">
                                                <xsl:text>and </xsl:text>
                                                <xsl:value-of select="normalize-space(.)"/>
                                                
                                                <xsl:text></xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="normalize-space(.)"/>
                                                <xsl:text></xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    
                    
                    
                    <xsl:if test="../../tei:monogr/tei:title/@level='s'">
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="../../tei:monogr/tei:title[@level='s']"/>                        
                        
                        <xsl:if test="../../tei:monogr/tei:imprint/tei:biblScope/@type='vol'">                        
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:imprint/tei:biblScope[@type='vol']"/>
                        </xsl:if>
                        <xsl:text>)</xsl:text>                                            
                    </xsl:if>
                    
                    
                    <xsl:if test="../../tei:monogr/tei:imprint/tei:biblScope/@type='vol'">
                        <xsl:if test="not(../../tei:monogr/tei:title/@level='s')">
                            <xsl:text> </xsl:text>
                            <xsl:text>(Vol. </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:imprint/tei:biblScope[@type='vol']"/>
                            <xsl:text>)</xsl:text>
                        </xsl:if>
                    </xsl:if>
                    
                    <xsl:if test="(../../tei:monogr/tei:imprint/tei:pubPlace)|(../../tei:monogr/tei:imprint/tei:publisher)|(../../tei:monogr/tei:imprint/tei:date)">
                        <xsl:text>. </xsl:text>
                    </xsl:if>
                    
                    <xsl:if test="../../tei:monogr/tei:imprint/tei:pubPlace">
                        <xsl:value-of select="../../tei:monogr/tei:imprint/tei:pubPlace"/>
                        
                    </xsl:if>
                    <xsl:if test="../../tei:monogr/tei:imprint/tei:publisher">
                        <xsl:if test="../../tei:monogr/tei:imprint/tei:pubPlace">
                            <xsl:text>: </xsl:text>
                        </xsl:if>
                        <xsl:value-of select="../../tei:monogr/tei:imprint/tei:publisher"/>
                    </xsl:if>
                    
                    <xsl:if test="../../tei:monogr/tei:imprint/tei:date">
                        <xsl:if test="(../../tei:monogr/tei:imprint/tei:pubPlace)|(../../tei:monogr/tei:imprint/tei:publisher)">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                        
                        <xsl:value-of select="../../tei:monogr/tei:imprint/tei:date"/>
                    </xsl:if>
                    
                    <xsl:choose>   
                        <xsl:when test="../../tei:monogr/tei:imprint/tei:biblScope/@type='pp'">
                            <xsl:text>, </xsl:text>
                            <xsl:text> p. </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:imprint/tei:biblScope[@type='pp']"/>
                            <xsl:text>.</xsl:text>
                            
                            <xsl:if test="../../tei:note">
                                <xsl:text> </xsl:text>
                                <xsl:apply-templates select="../../tei:note"/>
                                <xsl:text> </xsl:text>
                            </xsl:if>
                            
                        </xsl:when>
                        
                        <xsl:when test="../../tei:monogr/tei:imprint/tei:biblScope/@type='col'">                             
                            <xsl:text>: </xsl:text>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:imprint/tei:biblScope[@type='col']"/>
                            <xsl:text>.</xsl:text> 
                            
                            <xsl:if test="../../tei:note">
                                <xsl:text> </xsl:text>
                                <xsl:apply-templates select="../../tei:note"/>
                                <xsl:text> </xsl:text>
                            </xsl:if>
                            
                        </xsl:when>
                        
                        <xsl:when test="../../tei:monogr/tei:imprint/tei:biblScope/@type='chap'">                            
                            <xsl:text>: </xsl:text>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:imprint/tei:biblScope[@type='chap']"/>
                            <xsl:text>.</xsl:text> 
                            
                            <xsl:if test="../../tei:note">
                                <xsl:text> </xsl:text>
                                <xsl:apply-templates select="../../tei:note"/>
                                <xsl:text> </xsl:text>
                            </xsl:if>
                            
                        </xsl:when>
                        
                        <xsl:when test="../../tei:monogr/tei:imprint/tei:biblScope/@type='number'">
                            <xsl:text>no. </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:imprint/tei:biblScope[@type='number']"/>
                            <xsl:text>.</xsl:text>
                            
                            <xsl:if test="../../tei:note">
                                <xsl:text> </xsl:text>
                                <xsl:apply-templates select="../../tei:note"/>
                                <xsl:text> </xsl:text>
                            </xsl:if>
                            
                        </xsl:when>
                        
                        
                        
                        <xsl:otherwise>
                            <xsl:text>.</xsl:text>
                        </xsl:otherwise>
                        
                    </xsl:choose>
                    
                </xsl:when>
                
                <!-- if a title in analytic appears in a series that doesn't have a monograph title (i.e. only titlelevel="s") -->
                <xsl:when test="../../tei:monogr/tei:title/@level='s'">
                    
                    
                    
                    <!-- if the book that the article is in has an editor -->
                    <xsl:if test="../../tei:monogr/tei:editor">
                        <xsl:text>, </xsl:text>
                        <xsl:for-each select="../../tei:monogr">
                            <xsl:variable name="countOfPeople" select="count(tei:editor)"/>
                            <xsl:text>ed. </xsl:text>
                            <xsl:for-each select="tei:editor">
                                
                                <xsl:choose>
                                    <xsl:when test="not(position()=$countOfPeople)">
                                        
                                        <xsl:value-of select="normalize-space(.)"/>
                                        <xsl:if test="$countOfPeople>2">
                                            <xsl:text></xsl:text>
                                        </xsl:if>
                                        <xsl:text></xsl:text>
                                    </xsl:when>
                                    
                                    <xsl:otherwise>
                                        
                                        <xsl:choose>
                                            <xsl:when test="not(position()=(1))">
                                                <xsl:text>and </xsl:text>
                                                <xsl:value-of select="normalize-space(.)"/>
                                                
                                                <xsl:text></xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="normalize-space(.)"/>
                                                <xsl:text></xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    
                    
                    
                    <xsl:if test="../../tei:monogr/tei:title/@level='s'">
                        <xsl:if test="not(../../tei:monogr/tei:imprint/tei:biblScope[@type='vol'])">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:title[@level='s']"/>
                            <xsl:text>)</xsl:text>
                        </xsl:if>
                    </xsl:if>                              
                    
                    <xsl:if test="../../tei:monogr/tei:title/@level='s'">                         
                        <xsl:if test="../../tei:monogr/tei:imprint/tei:biblScope[@type='vol']">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:title[@level='s']"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../../tei:monogr/tei:imprint/tei:biblScope[@type='vol']"/>
                            <xsl:text></xsl:text> 
                        </xsl:if>
                    </xsl:if>
                    
                    <xsl:choose>
                        <xsl:when test="contains(../tei:title[@level='s'],'PL')"> 
                            <xsl:text>: </xsl:text>
                        </xsl:when>   
                        
                        <xsl:otherwise>
                            <xsl:text>. </xsl:text>    
                        </xsl:otherwise>
                    </xsl:choose>       
                    
                    
                    <xsl:if test="../../tei:monogr/tei:imprint/tei:pubPlace">
                        <xsl:value-of select="../../tei:monogr/tei:imprint/tei:pubPlace"/>
                        
                        
                        <xsl:text>: </xsl:text>
                        
                        <xsl:value-of select="../../tei:monogr/tei:imprint/tei:publisher"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="../../tei:monogr/tei:imprint/tei:date"/>
                    </xsl:if>
                    <xsl:if test="../../tei:monogr/tei:imprint/tei:biblScope/@type='pp'">
                        <xsl:text>, p. </xsl:text>
                        <xsl:value-of
                            select="../../tei:monogr/tei:imprint/tei:biblScope[@type='pp']"/>
                    </xsl:if>
                    <xsl:if test="following-sibling::tei:imprint/tei:biblScope/@type='col'">
                        <xsl:text> </xsl:text>
                        <xsl:value-of
                            select="following-sibling::tei:imprint/tei:biblScope[@type='col']"/>
                    </xsl:if>
                    <xsl:text>. </xsl:text>
                    
                    <xsl:if test="../../tei:note">
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="../../tei:note"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    
                    
                    
                </xsl:when>
                
                <!-- below deals with the journal bibliographic data after the article author and title -->
                <xsl:when test="../../tei:monogr/tei:title/@level='j'">
                    <i>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="../../tei:monogr/tei:title[@level='j']"/>
                    </i>
                    <xsl:text> </xsl:text>
                    <xsl:choose>
                        <xsl:when test="../../tei:monogr/tei:imprint/tei:biblScope/@type='vol'">
                            <xsl:value-of
                                select="../../tei:monogr/tei:imprint/tei:biblScope[@type='vol']"/>
                            <xsl:choose>
                                <xsl:when test="../../tei:monogr/tei:imprint/tei:date">
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="../../tei:monogr/tei:imprint/tei:date"/>
                                    <xsl:text>)</xsl:text>
                                    <xsl:if
                                        test="../../tei:monogr/tei:imprint/tei:biblScope/@type='pp'">
                                        <xsl:text>: </xsl:text>
                                        <xsl:value-of
                                            select="../../tei:monogr/tei:imprint/tei:biblScope[@type='pp']"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if
                                        test="../../tei:monogr/tei:imprint/tei:biblScope/@type='number'">
                                        <xsl:text>: </xsl:text>
                                        <xsl:value-of
                                            select="../../tei:monogr/tei:imprint/tei:biblScope[@type='number']"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when
                                            test="../../tei:monogr/tei:imprint/tei:biblScope/@type='pp'">
                                            <xsl:text/>
                                        </xsl:when>                                        
                                    </xsl:choose>
                                    
                                    
                                    
                                    
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            
                            
                        </xsl:when>
                    </xsl:choose>
                    
                    <!-- notes to journal article refs -->
                    <xsl:if test="../../tei:note">
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="../../tei:note"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    
                    
                    
                </xsl:when>
            </xsl:choose>
        </xsl:if>
        
        
        
        <xsl:choose>
            <!-- TITLE LEVEL W: for titles of ancient/medieval works, e.g. the De Schematibus et Tropis, which are not contiguous with the title of the monograph in which they are edited.  These are usually shorter texts-->
            <xsl:when test="@level='w'">
                <i>
                    <xsl:value-of select="normalize-space(text())"/>                
                </i>                             
                
                
                <xsl:if test="../tei:editor"> 
                    <xsl:text>, </xsl:text>
                    <xsl:text>ed. </xsl:text>
                    <xsl:value-of select="../tei:editor"/>
                    <xsl:if test="../tei:title[@level='m']">                       
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    
                </xsl:if>                                       
                
                <xsl:if test="../tei:respStmt">
                    <xsl:if test="not(../tei:editor)">
                        <xsl:text>, </xsl:text> 
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="normalize-space(../../tei:monogr/tei:respStmt/tei:resp/text())='Trans.'">
                            <xsl:text>trans. </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="../../tei:monogr/tei:respStmt/tei:resp"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text> </xsl:text>
                    <xsl:for-each select="../tei:respStmt">
                        <xsl:variable name="countOfPeople" select="count(tei:name)"/>
                        
                        <xsl:for-each select="tei:name">
                            <xsl:choose>
                                <xsl:when test="not(position()=$countOfPeople)">
                                    
                                    <xsl:value-of select="normalize-space(.)"/>
                                    
                                    <xsl:if test="../../tei:title[@level='m']">                       
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    
                                </xsl:when>
                                
                                <xsl:otherwise>
                                    
                                    <xsl:choose>
                                        <xsl:when test="not(position()=(1))">
                                            <xsl:text>and </xsl:text>
                                            <xsl:value-of select="normalize-space(.)"/>
                                            
                                            <xsl:text> </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="normalize-space(.)"/>                                            
                                            <xsl:if test="../../tei:title[@level='m']">
                                                
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                        
                    </xsl:for-each>
                    
                </xsl:if>
                <xsl:if test="../tei:title[@level='m']">
                    <xsl:if test="not(../tei:editor)">
                        <xsl:if test="not(../tei:respStmt)">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:if>
                    <xsl:text>in </xsl:text>
                    
                </xsl:if>
            </xsl:when>
            
            
            
            <!-- for monograph titles.  Titlelevel W entries will 'piggyback' on the below for their M level data -->
            
            
            
            <xsl:when test="@level='m'">
                <xsl:if test="not(../tei:title[@level='a'])">
                    
                    <i>
                        <xsl:if test="not(../tei:title/@level = 'a')">  
                            <xsl:value-of select="normalize-space(text())"/>
                        </xsl:if>
                    </i>
                    
                    <xsl:choose>
                        <!-- for a monograph that is part of a series -->
                        <xsl:when test="following-sibling::tei:title/@level='s'">
                            <xsl:choose>
                                <!-- if the series title is Acta Sanctorum -->
                                <xsl:when test="normalize-space(following-sibling::tei:title/text())='Acta Sanctorum'">
                                    <xsl:text>. AASS, </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                    <xsl:text>: </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='col']"/>
                                    <xsl:text>.</xsl:text>
                                    <xsl:if test="../tei:imprint/tei:pubPlace">
                                        <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                        <xsl:text>: </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:publisher">
                                        <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:date">
                                        <xsl:value-of select="../tei:imprint/tei:date"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../../tei:note">
                                        
                                        <xsl:text> </xsl:text>
                                        <xsl:apply-templates select="../../tei:note"/>
                                        <xsl:text></xsl:text>
                                        
                                    </xsl:if>
                                </xsl:when>
                                <!-- if the series title is PL -->
                                <xsl:when test="normalize-space(following-sibling::tei:title/text())='PL'">
                                    <xsl:text>. PL </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                    <xsl:text>: </xsl:text>
                                    <xsl:if test="../tei:imprint/tei:biblScope[@type='col']">
                                        <xsl:value-of select="../tei:imprint/tei:biblScope[@type='col']"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:biblScope[@type='pp']">
                                        <xsl:value-of select="../tei:imprint/tei:biblScope[@type='pp']"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:pubPlace">
                                        <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                        <xsl:text>: </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:publisher">
                                        <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:date">
                                        <xsl:value-of select="../tei:imprint/tei:date"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../../tei:note">
                                        
                                        <xsl:text> </xsl:text>
                                        <xsl:apply-templates select="../../tei:note"/>
                                        <xsl:text></xsl:text>
                                        
                                    </xsl:if>
                                </xsl:when>
                                <!-- if the series title is MGH -->
                                <xsl:when test="substring(following-sibling::tei:title/text(),1,3)='MGH'">
                                    <xsl:if test="not(../tei:title[@level='w'])">
                                        <xsl:choose>
                                            <xsl:when test="following-sibling::tei:editor">
                                                <xsl:text>, ed. </xsl:text>
                                                <xsl:value-of select="following-sibling::tei:editor"/>
                                            </xsl:when>
                                        </xsl:choose>
                                    </xsl:if>
                                    
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="following-sibling::tei:title"/>
                                    <xsl:choose>
                                        <xsl:when
                                            test="following-sibling::tei:imprint/tei:biblScope/@type='vol'">
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of
                                                select="following-sibling::tei:imprint/tei:biblScope[@type='vol']"/>
                                            <xsl:text>. </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>. </xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="following-sibling::tei:imprint/tei:pubPlace">
                                        <xsl:value-of select="following-sibling::tei:imprint/tei:pubPlace"/>
                                        <xsl:text>: </xsl:text>
                                        <xsl:if test="following-sibling::tei:imprint/tei:publisher">
                                            <xsl:value-of
                                                select="following-sibling::tei:imprint/tei:publisher"/>
                                            <xsl:text>, </xsl:text>
                                            
                                            
                                        </xsl:if>
                                    </xsl:if>
                                    <xsl:if test="following-sibling::tei:imprint/tei:date">
                                        <xsl:value-of select="following-sibling::tei:imprint/tei:date"/>
                                        <xsl:text>. </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="following-sibling::tei:imprint/tei:biblScope/@type='pp'">
                                        <xsl:text> p. </xsl:text>
                                        <xsl:value-of
                                            select="following-sibling::tei:imprint/tei:biblScope[@type='pp']"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    
                                    <xsl:if test="../../tei:note">
                                        
                                        <xsl:text> </xsl:text>
                                        <xsl:apply-templates select="../../tei:note"/>
                                        <xsl:text> </xsl:text>
                                        
                                    </xsl:if>
                                </xsl:when>
                                <!-- for other monographic series (not PL and not MGH) -->
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <!-- if the monographic series has volume numbers -->
                                        <xsl:when test="following-sibling::tei:imprint/tei:biblScope/@type='vol'">                                    
                                            <xsl:if test="not(../tei:title[@level='w'])">
                                                <xsl:choose>
                                                    
                                                    <xsl:when test="../tei:editor">                                            
                                                        <xsl:text>, ed. </xsl:text>
                                                        <xsl:value-of select="../tei:editor"/>
                                                    </xsl:when>                                       
                                                </xsl:choose>
                                                
                                                <xsl:if test="../tei:respStmt">
                                                    <xsl:text>, </xsl:text>
                                                    <xsl:choose>
                                                        <xsl:when test="normalize-space(../../tei:monogr/tei:respStmt/tei:resp/text())='Trans.'">
                                                            <xsl:text>trans.</xsl:text>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="../../tei:monogr/tei:respStmt/tei:resp"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:for-each select="../tei:respStmt">
                                                        <xsl:variable name="countOfPeople" select="count(tei:name)"/>
                                                        
                                                        <xsl:for-each select="tei:name">
                                                            <xsl:choose>
                                                                <xsl:when test="not(position()=$countOfPeople)">
                                                                    
                                                                    <xsl:value-of select="normalize-space(.)"/>
                                                                    <xsl:text>, </xsl:text>
                                                                    
                                                                </xsl:when>
                                                                
                                                                <xsl:otherwise>
                                                                    
                                                                    <xsl:choose>
                                                                        <xsl:when test="not(position()=(1))">
                                                                            <xsl:text>and </xsl:text>
                                                                            <xsl:value-of select="normalize-space(.)"/>
                                                                            
                                                                            <xsl:text> </xsl:text>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="normalize-space(.)"/>
                                                                            <xsl:text> </xsl:text>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                        
                                                    </xsl:for-each>
                                                </xsl:if>
                                            </xsl:if>
                                            <xsl:text> (</xsl:text>
                                            <xsl:value-of select="following-sibling::tei:title[@level='s']"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                            <xsl:text>). </xsl:text>
                                            <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                            <xsl:text>: </xsl:text>
                                            <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                            <xsl:text>, </xsl:text>
                                            <xsl:value-of select="../tei:imprint/tei:date"/>
                                            
                                            
                                            
                                            
                                            
                                            
                                            <xsl:if test="contains(../tei:imprint/tei:biblScope[@type='pp'], 'I')"> 
                                                <xsl:text>, </xsl:text>
                                                <xsl:value-of
                                                    select="following-sibling::tei:imprint/tei:biblScope[@type='pp']"/>
                                            </xsl:if>
                                            
                                            <xsl:if test="not(contains(../tei:imprint/tei:biblScope[@type='pp'], 'I'))">                                        
                                                <xsl:if test="following-sibling::tei:imprint/tei:biblScope/@type='pp'">
                                                    <xsl:text>, p. </xsl:text>
                                                    <xsl:value-of
                                                        select="following-sibling::tei:imprint/tei:biblScope[@type='pp']"/>
                                                    
                                                </xsl:if>
                                            </xsl:if>
                                            
                                            <xsl:text>. </xsl:text>
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            <xsl:if test="../../tei:note">
                                                
                                                <xsl:text> </xsl:text>
                                                <xsl:apply-templates select="../../tei:note"/>
                                                <xsl:text> </xsl:text>
                                                
                                            </xsl:if>
                                            
                                            
                                        </xsl:when>
                                        
                                        <!-- a monographic series that does not have volume numbers  -->
                                        <xsl:otherwise>
                                            <xsl:text></xsl:text>
                                            <xsl:choose>
                                                <xsl:when test="following-sibling::tei:editor">
                                                    <xsl:if test="not(../tei:title[@level='w'])">
                                                        <xsl:text>, ed. </xsl:text>
                                                        <xsl:value-of select="following-sibling::tei:editor"/>
                                                        <xsl:text> </xsl:text>
                                                    </xsl:if>
                                                </xsl:when>
                                            </xsl:choose>
                                            <xsl:if test="../tei:respStmt">
                                                <xsl:if test="not(../tei:title[@level='w'])">
                                                    <xsl:text>, </xsl:text>
                                                    <xsl:choose>
                                                        <xsl:when test="normalize-space(../../tei:monogr/tei:respStmt/tei:resp/text())='Trans.'">
                                                            <xsl:text>trans. </xsl:text>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="../../tei:monogr/tei:respStmt/tei:resp"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:for-each select="../tei:respStmt">
                                                        <xsl:variable name="countOfPeople" select="count(tei:name)"/>
                                                        
                                                        <xsl:for-each select="tei:name">
                                                            <xsl:choose>
                                                                <xsl:when test="not(position()=$countOfPeople)">
                                                                    
                                                                    <xsl:value-of select="normalize-space(.)"/>
                                                                    <xsl:text>, </xsl:text>
                                                                    
                                                                </xsl:when>
                                                                
                                                                <xsl:otherwise>
                                                                    
                                                                    <xsl:choose>
                                                                        <xsl:when test="not(position()=(1))">
                                                                            <xsl:text>and </xsl:text>
                                                                            <xsl:value-of select="normalize-space(.)"/>
                                                                            
                                                                            <xsl:text> </xsl:text>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:value-of select="normalize-space(.)"/>
                                                                            <xsl:text> </xsl:text>
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                        
                                                    </xsl:for-each>
                                                </xsl:if>
                                            </xsl:if>
                                            
                                            <xsl:text> (</xsl:text>
                                            <xsl:value-of select="following-sibling::tei:title[@level='s']"/>
                                            <xsl:for-each select="../tei:imprint">
                                                <xsl:text>). </xsl:text>
                                                <xsl:call-template name="plainImprint"/>
                                            </xsl:for-each>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <!-- ending punctuation if the monograph is a stand-alone publication (not part of a series) -->
                        <xsl:otherwise>
                            
                            
                            
                            <!-- the following will give the editor for an m-level title, so long as there is no a-level or w-level titles, in which case the editor is listed following those titles (see above) -->
                            <xsl:if test="not(../tei:title/@level = 'a')">
                                <xsl:if test="../tei:editor"> 
                                    <xsl:if test="not(../tei:title[@level='w'])">                        
                                        <xsl:text>, </xsl:text>                              
                                        <xsl:text>ed.  </xsl:text>
                                        <xsl:value-of select="../tei:editor"/>
                                        <xsl:text></xsl:text>
                                    </xsl:if>
                                </xsl:if>
                                <xsl:if test="not(../tei:title[@level='w'])"> 
                                    <xsl:if test="../tei:respStmt">
                                        <xsl:text>, </xsl:text>
                                        <xsl:choose>
                                            <xsl:when test="normalize-space(../../tei:monogr/tei:respStmt/tei:resp/text())='Trans.'">
                                                <xsl:text>trans.</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="../../tei:monogr/tei:respStmt/tei:resp"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <xsl:text> </xsl:text>
                                        <xsl:for-each select="../tei:respStmt">
                                            <xsl:variable name="countOfPeople" select="count(tei:name)"/>
                                            
                                            <xsl:for-each select="tei:name">
                                                <xsl:choose>
                                                    <xsl:when test="not(position()=$countOfPeople)">
                                                        
                                                        <xsl:value-of select="normalize-space(.)"/>
                                                        <xsl:text>, </xsl:text>
                                                        
                                                    </xsl:when>
                                                    
                                                    <xsl:otherwise>
                                                        
                                                        <xsl:choose>
                                                            <xsl:when test="not(position()=(1))">
                                                                <xsl:text>and </xsl:text>
                                                                <xsl:value-of select="normalize-space(.)"/>
                                                                
                                                                <xsl:text> </xsl:text>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="normalize-space(.)"/>
                                                                <xsl:text></xsl:text>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                    </xsl:if>
                                </xsl:if>
                                
                                
                                
                                
                                
                                
                                <!-- continues the entry for m-level titles that are not part of a series (though they may have multiple volumes) -->
                                <xsl:if test="../tei:imprint/tei:biblScope/@type='vol'">
                                    
                                    <xsl:text> </xsl:text>
                                    <xsl:text>(Vol. </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                                
                                <xsl:text>. </xsl:text>
                                
                                
                                <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                <xsl:text>: </xsl:text>
                                <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="../tei:imprint/tei:date"/>                       
                                
                                <xsl:if test="contains(../tei:imprint/tei:biblScope[@type='pp'], 'I')"> 
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of
                                        select="following-sibling::tei:imprint/tei:biblScope[@type='pp']"/>
                                </xsl:if>
                                
                                <xsl:if test="not(contains(../tei:imprint/tei:biblScope[@type='pp'], 'I'))">                                        
                                    <xsl:if test="following-sibling::tei:imprint/tei:biblScope/@type='pp'">
                                        <xsl:text>, p. </xsl:text>
                                        <xsl:value-of
                                            select="following-sibling::tei:imprint/tei:biblScope[@type='pp']"/>
                                        
                                    </xsl:if>
                                </xsl:if>
                                
                                <xsl:if test="../tei:imprint/tei:biblScope/@type='col'">                       
                                    <xsl:text>:</xsl:text>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='col']"/>                            
                                </xsl:if>
                                
                                <xsl:if test="../tei:imprint/tei:biblScope/@type='chap'">                            
                                    <xsl:text>: </xsl:text>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='chap']"/>
                                    
                                </xsl:if>
                                
                                <xsl:if test="../tei:imprint/tei:biblScope/@type='number'">
                                    <xsl:text>, </xsl:text>
                                    <xsl:text>no. </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='number']"/>                    
                                </xsl:if>
                                
                                <xsl:text>.</xsl:text>
                                
                                <xsl:if test="../../tei:note">
                                    <xsl:text> </xsl:text>
                                    <xsl:apply-templates select="../../tei:note"/>
                                    <xsl:text> </xsl:text>
                                    
                                </xsl:if>
                                
                                
                                
                            </xsl:if>
                            
                        </xsl:otherwise>
                    </xsl:choose>
                    
                </xsl:if>
            </xsl:when>
            
            
            <!-- For situations where we have a w-level title in a volume of a series (s-level title), but without an m-level title -->
            <xsl:when test="not(../tei:title[@level='m'])">
                <xsl:if test="not(../tei:title[@level='a'])">
                    <xsl:if test="not(../tei:title[@level='j'])">
                        <xsl:if test="not(../tei:title[@level='u'])">
                            
                            
                            
                            <!--   <xsl:otherwise> -->
                            
                            
                            
                            
                            <xsl:choose>     
                                
                                
                                
                                <xsl:when test="(../tei:title[@level='s']/text()='Acta Sanctorum')">
                                    <xsl:text>. AASS, </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                    <xsl:text>: </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='col']"/>
                                    <xsl:text>.</xsl:text>
                                    <xsl:if test="../tei:imprint/tei:pubPlace">
                                        <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                        <xsl:text>: </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:publisher">
                                        <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:date">
                                        <xsl:value-of select="../tei:imprint/tei:date"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../../tei:note">
                                        
                                        <xsl:text> </xsl:text>
                                        <xsl:apply-templates select="../../tei:note"/>
                                        <xsl:text></xsl:text>
                                        
                                    </xsl:if>
                                </xsl:when>
                                
                                <xsl:when test="(../tei:title[@level='s']/text()='AASS')">
                                    <xsl:text>. AASS, </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                    <xsl:text>: </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='col']"/>
                                    <xsl:text>.</xsl:text>
                                    <xsl:if test="../tei:imprint/tei:pubPlace">
                                        <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                        <xsl:text>: </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:publisher">
                                        <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:date">
                                        <xsl:value-of select="../tei:imprint/tei:date"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../../tei:note">
                                        
                                        <xsl:text> </xsl:text>
                                        <xsl:apply-templates select="../../tei:note"/>
                                        <xsl:text></xsl:text>
                                        
                                    </xsl:if>
                                </xsl:when>
                                
                                <xsl:when test="../tei:title[@level='s']/text()='PL'">
                                    <xsl:text>. PL </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                    <xsl:text>: </xsl:text>
                                    <xsl:value-of select="../tei:imprint/tei:biblScope[@type='col']"/>
                                    <xsl:text>.</xsl:text>
                                    <xsl:if test="../tei:imprint/tei:pubPlace">
                                        <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                        <xsl:text>: </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:publisher">
                                        <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../tei:imprint/tei:date">
                                        <xsl:value-of select="../tei:imprint/tei:date"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="../../tei:note">
                                        
                                        <xsl:text> </xsl:text>
                                        <xsl:apply-templates select="../../tei:note"/>
                                        <xsl:text></xsl:text>
                                        
                                    </xsl:if>
                                </xsl:when>
                                
                                
                                <xsl:otherwise>
                                    <xsl:text> (</xsl:text>                    
                                    <xsl:value-of select="../tei:title[@level='s']"/>                
                                    
                                    <xsl:if test="following-sibling::tei:imprint/tei:biblScope/@type='vol'">
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
                                    </xsl:if>
                                    <xsl:text>)</xsl:text>
                                    
                                    <xsl:choose>
                                        <xsl:when test="contains(../tei:title[@level='s'],'PL')"> 
                                            <xsl:text>: </xsl:text>
                                        </xsl:when>   
                                        
                                        <xsl:otherwise>
                                            <xsl:text>. </xsl:text>    
                                        </xsl:otherwise>
                                    </xsl:choose>       
                                    
                                    
                                    <xsl:if test="../tei:imprint/tei:pubPlace">
                                        <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                                        
                                        
                                        <xsl:text>: </xsl:text>
                                        
                                        <xsl:value-of select="../tei:imprint/tei:publisher"/>
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="../tei:imprint/tei:date"/>
                                    </xsl:if>
                                    <xsl:if test="following-sibling::tei:imprint/tei:biblScope/@type='pp'">
                                        <xsl:text>, p. </xsl:text>
                                        <xsl:value-of
                                            select="following-sibling::tei:imprint/tei:biblScope[@type='pp']"/>
                                    </xsl:if>
                                    <xsl:if test="following-sibling::tei:imprint/tei:biblScope/@type='col'">
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of
                                            select="following-sibling::tei:imprint/tei:biblScope[@type='col']"/>
                                    </xsl:if>
                                    <xsl:text>.</xsl:text>
                                    <xsl:if test="../../tei:note">
                                        <xsl:text> </xsl:text>
                                        <xsl:apply-templates select="../../tei:note"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            
                        </xsl:if>
                    </xsl:if>
                </xsl:if>
            </xsl:when>
            <!-- </xsl:otherwise> -->
            
            
        </xsl:choose>
        
        <!-- the following is a failsafe in case there are old titles without levels in a file; a title name will at least be given.  Won't work if the item for some reason has a <title> field AND a <title level=""> field. -->
        <xsl:if test="not(../tei:title[@level='a'])">
            <xsl:if test="not(../tei:title[@level='j'])">        
                <xsl:if test="not(../tei:title[@level='m'])">
                    <xsl:if test="not(../tei:title[@level='s'])">   
                        <xsl:if test="not(../tei:title[@level='u'])">
                            <xsl:if test="not(../tei:title[@level='w'])">   
                                
                                <i>                
                                    <xsl:value-of select="../tei:title"/> 
                                </i>
                                
                            </xsl:if>
                        </xsl:if>
                    </xsl:if>
                </xsl:if>
            </xsl:if>
        </xsl:if>
        
        
        
        
        <!-- I think the below is supposed to be for m- and w- level titles that fall into j-level titles.  At the moment only semi functional.  RMP -->
        <xsl:if test="@level='j'">
            <xsl:text>, </xsl:text>
            <i>                
                <xsl:value-of select="../tei:title[@level='j']"/>
            </i>
            <xsl:text> </xsl:text>
            <xsl:value-of select="../tei:imprint/tei:biblScope[@type='vol']"/>
            <xsl:text> </xsl:text>
            <xsl:if test="../tei:imprint/tei:date">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="../tei:imprint/tei:date"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="../tei:imprint/tei:biblScope/@type='pp'">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="../tei:imprint/tei:biblScope[@type='pp']"/>
            </xsl:if>
            <xsl:text>.</xsl:text>
            
            <xsl:if test="../../tei:note">
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="../../tei:note"/>
                <xsl:text> </xsl:text>
            </xsl:if>
        </xsl:if>
        
        
        <xsl:if test="@level='u'">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="."></xsl:value-of>
            <xsl:text>." </xsl:text>
            <xsl:if test="../tei:note">
                
                <xsl:value-of select="../tei:note"/>
                <xsl:text>. </xsl:text>     
                <xsl:if test="../tei:imprint/tei:pubPlace">
                    <xsl:value-of select="../tei:imprint/tei:pubPlace"/>
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:if test="../tei:imprint/tei:publisher">
                    <xsl:if test="not(../tei:imprint/tei:pubPlace)">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="../tei:imprint/tei:publisher"/>
                </xsl:if>
                <xsl:if test="../tei:imprint/tei:date">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="../tei:imprint/tei:date"/>
                    <xsl:text>.</xsl:text>
                </xsl:if>
            </xsl:if>
        </xsl:if>   
        
    </xsl:template>
    
    <xsl:template name="biblScope">
        <xsl:if test="normalize-space(@type)='vol'">
            <xsl:value-of select="normalize-space(@type)"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="."/>
        </xsl:if>
        <xsl:if test="normalize-space(@type)='col'">
            <xsl:text>:  </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- The below is the generic layout for publication place, publisher, pages, etc.  It is called out in several of the scenarios above, hence it is the first place to test changes.  I have had trouble arranging the final full-stop in this template so some of the code here may not be used.  RMP -->
    <xsl:template name="plainImprint">
        <xsl:if test="tei:pubPlace">
            <xsl:value-of select="tei:pubPlace"/>
            <xsl:text>: </xsl:text>
        </xsl:if>
        <xsl:if test="tei:publisher">
            <xsl:value-of select="tei:publisher"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:if test="tei:date">
            <xsl:value-of select="tei:date"/> 
            
        </xsl:if>
        
        <xsl:choose>
            
            <xsl:when test="tei:biblScope/@type='col'">
                <xsl:text>: </xsl:text>
                <xsl:value-of select="tei:biblScope[@type='col']"/>
                <xsl:text>.</xsl:text>
            </xsl:when>
            
            
            <xsl:when test="tei:biblScope/@type='number'">
                <xsl:text>, </xsl:text>
                <xsl:text>no. </xsl:text>
                <xsl:value-of select="tei:biblScope[@type='number']"/>                            
                <xsl:text>.</xsl:text>
            </xsl:when>
            
            
            <xsl:when test="tei:biblScope/@type='pp'">
                <!-- <xsl:if test="normalize-space(following-sibling::tei:biblScope/@type='pp'/text())='I'"> -->
                <xsl:text>, </xsl:text>
                <xsl:text>p. </xsl:text>
                <xsl:value-of select="tei:biblScope[@type='pp']"/>
                <xsl:text>.</xsl:text>
            </xsl:when>
            
            
            
            <xsl:otherwise>
                <xsl:text>.</xsl:text>
            </xsl:otherwise>
            
        </xsl:choose>
        
        <xsl:if test="../../tei:note">
            
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="../../tei:note"/>
            <xsl:text> </xsl:text>
            
        </xsl:if>
        <!-- </xsl:if> -->                    
        
        
        
    </xsl:template>
    
    
    
    <xsl:template name="titleText">
        <xsl:choose>
            <xsl:when test="substring(normalize-space(.),string-length(normalize-space(.))) = '.' ">
                <xsl:value-of select="substring(.,1,(string-length(.)-1))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>