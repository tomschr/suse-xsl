<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   Purpose:
     Create structure of chunked contents
     
     
   See Also:
     * http://doccookbook.sf.net/html/en/dbc.common.dbcustomize.html
     * http://sagehill.net/docbookxsl/CustomMethods.html#WriteCustomization

   Author:    Thomas Schraitle <toms@opensuse.org>
   Copyright: 2012, Thomas Schraitle

-->

<!DOCTYPE xsl:stylesheet
[
  <!ENTITY www "http://docbook.sourceforge.net/release/xsl/current/xhtml">
  <!ENTITY nbsp "&#xa0;">
]>
<xsl:stylesheet version="1.0"  
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://nwalsh.com/docbook/xsl/template/1.0"
    xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
    exclude-result-prefixes="exsl l t">
  
  <xsl:import href="&www;/chunk-common.xsl"/>

  <xsl:template name="clearme">
    <xsl:param name="wrapper">div</xsl:param>
    <xsl:element name="{$wrapper}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="class">clearme</xsl:attribute>
    </xsl:element>
  </xsl:template>

  <xsl:variable name="rootelementname">
    <xsl:choose>
      <xsl:when test="local-name(key('id', $rootid)) != ''">
        <xsl:value-of select="local-name(key('id', $rootid))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="local-name(/*)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- ===================================================== -->
  <xsl:template
    match="appendix|article|book|bibliography|chapter|part|preface|glossary|sect1|set"
                mode="breadcrumbs">
    <xsl:param name="class">crumb</xsl:param>
    <xsl:param name="context">header</xsl:param>

    <xsl:variable name="title">
      <xsl:apply-templates select="." mode="titleabbrev.markup"/>
    </xsl:variable>

    <xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="generate.class.attribute">
        <xsl:with-param name="class" select="$class"/>
      </xsl:call-template>
      <xsl:choose>
        <xsl:when test="$class='book-link'">
          <xsl:attribute name="href">
            <xsl:value-of select="concat($root.filename, $html.ext)"/>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:value-of select="string($title)"/>
          </xsl:attribute>
          <span class="book-icon">
            <xsl:value-of select="string($title)"/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="."/>
              <xsl:with-param name="context" select="."/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:if test="$class = 'single-crumb'">
            <span class="book2-icon"> </span>
          </xsl:if>
          <xsl:value-of select="string($title)"/>
          <xsl:if test="$context = 'fixed-header'">
            (<xsl:call-template name="gentext">
              <xsl:with-param name="key">contentsoverview</xsl:with-param>
            </xsl:call-template>)
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="breadcrumbs.navigation">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="context">header</xsl:param>
    <xsl:param name="debug"/>
    
    <xsl:if test="$generate.breadcrumbs != 0">
      <div class="crumbs">
        <xsl:choose>
          <xsl:when test="$rootelementname != 'article'">
            <xsl:for-each select="ancestor-or-self::*">
              <xsl:choose>
               <!-- This works for all common cases, but will do foolish things when you build
                    a $rootid that is nested more than one level deep within the root element
                    and that $rootid is not an article. Sorry for the pain. -->
                <xsl:when test="$rootid != '' and not(ancestor::*)"/>
                <xsl:when test="not(ancestor::*) or self::*[@id = string($rootid)]">
                  <xsl:apply-templates select="." mode="breadcrumbs">
                    <xsl:with-param name="class">book-link</xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                  <span><xsl:copy-of select="$daps.breadcrumbs.sep"/></span>
                  <xsl:apply-templates select="." mode="breadcrumbs"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="." mode="breadcrumbs">
              <xsl:with-param name="class">single-crumb</xsl:with-param>
              <xsl:with-param name="context" select="$context"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </xsl:if>
  </xsl:template>

  <!-- ===================================================== -->
  <xsl:template name="pickers">
    <xsl:if test="$generate.pickers != 0">
    <div id="_pickers">
      <div id="_language-picker" class="inactive">
        <a id="_language-picker-button" href="#">
          <span class="picker">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">LocalisedLanguageName</xsl:with-param>
            </xsl:call-template>
          </span>
        </a>
        <div class="bubble-corner active-contents"> </div>
        <div class="bubble active-contents">
          <h6>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">selectlanguage</xsl:with-param>
            </xsl:call-template>
          </h6>
          <a class="selected" href="#">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">LocalisedLanguageName</xsl:with-param>
            </xsl:call-template>
          </a>
        </div>
      </div>
      <div id="_format-picker" class="inactive">
        <a id="_format-picker-button" href="#">
          <span class="picker">Web Page</span>
        </a>
        <div class="bubble-corner active-contents"> </div>
        <div class="bubble active-contents">
          <h6>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">selectformat</xsl:with-param>
            </xsl:call-template>
          </h6>
          <a class="selected" href="#">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">formathtml</xsl:with-param>
            </xsl:call-template>
          </a>
          <a href="#">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">formatsinglehtml</xsl:with-param>
            </xsl:call-template>
          </a>
          <a href="#">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">formatpdf</xsl:with-param>
            </xsl:call-template>
          </a>
          <a href="#">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">formatepub</xsl:with-param>
            </xsl:call-template>
          </a>
        </div>
      </div>
    </div>
    </xsl:if>
  </xsl:template>

  <!-- ===================================================== -->
  <xsl:template name="create.header.logo">
    <div id="_logo">
      <img src="{$daps.header.logo}" alt="{$daps.header.logo.alt}"/>
    </div>
  </xsl:template>

  <xsl:template name="create.header.buttons">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>

    <div class="buttons">
      <a class="top-button button" href="#">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">totopofpage</xsl:with-param>
        </xsl:call-template>
      </a>
      <xsl:if test="not(self::set|self::article)">
      <div class="button">
        <xsl:call-template name="header.navigation">
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="prev" select="$prev"/>
          <!--<xsl:with-param name="nav.context" select="$nav.context"/>-->
        </xsl:call-template>
      </div>
      </xsl:if>
      <xsl:call-template name="clearme"/>
    </div>
  </xsl:template>

  <!-- ===================================================== -->
  <xsl:template name="fixed-header-wrap">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="nav.context"/>
    
    <div id="_fixed-header-wrap" class="inactive">
      <div id="_fixed-header">
        <xsl:call-template name="breadcrumbs.navigation">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="context">fixed-header</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="create.header.buttons">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
        </xsl:call-template>
        <xsl:call-template name="clearme"/>
      </div>
      <xsl:if test="$rootelementname = 'article'">
      <div class="active-contents bubble">
        <div class="bubble-container">
          <h6>
            <xsl:apply-templates mode="title.markup"
              select="(ancestor-or-self::book | ancestor-or-self::article)[1]"/>
          </h6>
          <div id="_bubble-toc">
            <xsl:call-template name="bubble-toc"/>
          </div>
          <xsl:call-template name="clearme"/>
        </div>
      </div>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template name="create-find-area">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:variable name="localisationfind">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key">find</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    
    <div id="_find-area" class="active">
      <div class="inactive-contents">
        <a href="#" id="_find-area-button" class="tool" title="{$localisationfind}">
          <span class="pad-tools-50-out">
            <span class="pad-tools-50-in">
              <span class="tool-spacer">
                <span class="find-icon"><xsl:value-of select="$localisationfind"/></span>
              </span>
              <span class="tool-label"><xsl:value-of select="$localisationfind"/></span>
            </span>
          </span>
        </a>
      </div>
      <div class="active-contents">
        <form action="post">
          <div class="find-form">
            <input type="text" id="_find-input" value="{$localisationfind}"/>
            <button id="_find-button" alt="{$localisationfind}" title="{$localisationfind}">
              <xsl:value-of select="$localisationfind"/>
            </button>
            <label id="_find-input-label">
              <xsl:value-of select="$localisationfind"/>
            </label>
            <xsl:call-template name="clearme"/>
          </div>
        </form>
      </div>
    </div>
  </xsl:template>
  
  <!-- ===================================================== -->
  <xsl:template name="toolbar-wrap">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="nav.context"/>
    <xsl:variable name="rootnode"  select="generate-id(/*) = generate-id(.)"/>
        <xsl:variable name="localisationcontents">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key">contentsoverview</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$rootelementname != 'article'">
      <div id="_toolbar-wrap">
        <div id="_toolbar">
          <xsl:choose>
            <xsl:when test="$rootnode">
              <!-- We don't need it for a set -->
              <div id="_toc-area" class="inactive"> </div>
            </xsl:when>
            <xsl:otherwise>
              <div id="_toc-area" class="inactive">
                <a id="_toc-area-button" class="tool" title="{$localisationcontents}">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <!-- FIXME: -->
                      <xsl:with-param name="object" select="/*"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <span class="tool-spacer">
                    <span class="toc-icon">
                      <xsl:value-of select="$localisationcontents"/>
                    </span>
                    <xsl:call-template name="clearme">
                      <xsl:with-param name="wrapper">span</xsl:with-param>
                    </xsl:call-template>
                  </span>
                  <span class="tool-label">
                    <xsl:value-of select="$localisationcontents"/>
                  </span>
                </a>
                <div class="active-contents bubble-corner"> </div>
                <div class="active-contents bubble">
                  <div class="bubble-container">
                    <h6>
                      <xsl:apply-templates mode="title.markup"
                        select="(ancestor-or-self::book | ancestor-or-self::article)[1]"/>
                    </h6>
                    <div id="_bubble-toc">
                      <xsl:call-template name="bubble-toc"/>
                    </div>
                    <xsl:call-template name="clearme"/>
                  </div>
                </div>
              </div>
            </xsl:otherwise>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="self::set|self::article">
              <div id="_nav-area" class="inactive"></div>
            </xsl:when>
            <xsl:otherwise>
              <div id="_nav-area" class="inactive">
                <div class="tool">
                  <span class="nav-inner">
                    <span class="tool-label">
                      <xsl:call-template name="gentext">
                        <xsl:with-param name="key">navigation</xsl:with-param>
                      </xsl:call-template>
                    </span>
                    <!-- Add navigation -->
                    <xsl:call-template name="header.navigation">
                      <xsl:with-param name="next" select="$next"/>
                      <xsl:with-param name="prev" select="$prev"/>
                      <xsl:with-param name="nav.context" select="$nav.context"/>
                    </xsl:call-template>
                  </span>
                </div>
              </div>
            </xsl:otherwise>
          </xsl:choose>

          <!-- Do not create a Find area for now, instead of focus on remaining
               missing essentials. Make Find functional later. -->
          <!-- <xsl:call-template name="create-find-area">
            <xsl:with-param name="next" select="$next"/>
            <xsl:with-param name="prev" select="$prev"/>
            <xsl:with-param name="nav.context" select="$nav.context"/>
          </xsl:call-template> -->

        </div>
      </div>
    </xsl:if>
  </xsl:template>
  
  <!-- ===================================================== -->
  <xsl:template name="header.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:param name="nav.context"/>
    
    <xsl:variable name="needs.navig">
      <xsl:call-template name="is.node.in.navig">
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="prev" select="$prev"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="isnext">
      <xsl:call-template name="is.next.node.in.navig">
        <xsl:with-param name="next" select="$next"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="isprev">
      <xsl:call-template name="is.prev.node.in.navig">
        <xsl:with-param name="prev" select="$prev"/>
      </xsl:call-template>
    </xsl:variable>
  
  <!-- 
     We use two node sets and calculate the set difference
     with the following, general XPath expression:
     
      setdiff = $node-set1[count(.|$node-set2) != count($node-set2)]
     
     $node-set1 contains the ancestors of all nodes, starting with the
     current node (but the current node is NOT included in the set)
     
     $node-set2 contains the ancestors of all nodes starting from the 
     node which points to the $rootid parameter
     
     For example:
     node-set1: {/, set, book, chapter}
     node-set2: {/, set, } 
     setdiff:   {        book, chapter}
     
  -->
  <xsl:variable name="ancestorrootnode" select="key('id', $rootid)/ancestor::*"/>
  <xsl:variable name="setdiff" select="ancestor::*[count(. | $ancestorrootnode) 
                                != count($ancestorrootnode)]"/>
  <xsl:if test="$needs.navig">
       <xsl:choose>
         <xsl:when test="count($prev) > 0 and $isprev = 'true'">
           <a accesskey="p" class="tool-spacer">
             <xsl:attribute name="title">
               <xsl:apply-templates select="$prev"
                 mode="object.title.markup"/>
             </xsl:attribute>
             <xsl:attribute name="href">
               <xsl:call-template name="href.target">
                 <xsl:with-param name="object" select="$prev"/>
               </xsl:call-template>
             </xsl:attribute>
             <span class="prev-icon">←</span>
           </a>
         </xsl:when>
         <xsl:otherwise>
           <span class="tool-spacer">
             <span class="prev-icon">←</span>
           </span>
         </xsl:otherwise>
       </xsl:choose>
       <xsl:choose>
         <xsl:when test="count($next) > 0 and $isnext = 'true'">
           <a accesskey="n" class="tool-spacer">
             <xsl:attribute name="title">
               <xsl:apply-templates select="$next"
                 mode="object.title.markup"/>
             </xsl:attribute>
             <xsl:attribute name="href">
               <xsl:call-template name="href.target">
                 <xsl:with-param name="object" select="$next"/>
               </xsl:call-template>
             </xsl:attribute>
             <span class="next-icon">→</span>
           </a>
         </xsl:when>
         <xsl:otherwise>
           <span class="tool-spacer">
             <span class="next-icon">→</span>
           </span>
         </xsl:otherwise>
       </xsl:choose>
    </xsl:if>
  </xsl:template>


  <xsl:template name="share.and.print">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:param name="nav.context"/>
    
    <div id="_share-print">
      <xsl:if test="$generate.sharelinks != 0">
        <div class="online-contents share">
          <strong><xsl:call-template name="gentext">
              <xsl:with-param name="key">sharethispage</xsl:with-param>
            </xsl:call-template>
          </strong>
          <!-- &#x2022; = &bull; -->
          <span id="_share-fb">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">shareviafacebook</xsl:with-param>
            </xsl:call-template>
          </span> &#x2022; 
          <span id="_share-gp">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">shareviagoogleplus</xsl:with-param>
            </xsl:call-template>
          </span> &#x2022; 
          <span id="_share-tw">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">shareviatwitter</xsl:with-param>
            </xsl:call-template>
          </span> &#x2022; 
          <span id="_share-mail">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">shareviaemail</xsl:with-param>
            </xsl:call-template>
          </span>
        </div>
      </xsl:if>
      <div class="print"><span id="_print-button">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key">printthispage</xsl:with-param>
        </xsl:call-template></span></div>
      <xsl:call-template name="clearme"/>
    </div>
  </xsl:template>

  <!-- ===================================================== -->
  <xsl:template name="bottom.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:param name="nav.context"/>
    <xsl:variable name="needs.navig">
      <xsl:call-template name="is.node.in.navig">
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="prev" select="$prev"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="isnext">
      <xsl:call-template name="is.next.node.in.navig">
        <xsl:with-param name="next" select="$next"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="isprev">
      <xsl:call-template name="is.prev.node.in.navig">
        <xsl:with-param name="prev" select="$prev"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- 
     We use two node sets and calculate the set difference
     with the following, general XPath expression:
     
      setdiff = $node-set1[count(.|$node-set2) != count($node-set2)]
     
     $node-set1 contains the ancestors of all nodes, starting with the
     current node (but the current node is NOT included in the set)
     
     $node-set2 contains the ancestors of all nodes starting from the 
     node which points to the $rootid parameter
     
     For example:
     node-set1: {/, set, book, chapter}
     node-set2: {/, set, } 
     setdiff:   {        book, chapter}
     
  -->
    <xsl:variable name="ancestorrootnode"
      select="key('id', $rootid)/ancestor::*"/>
    <xsl:variable name="setdiff"
      select="ancestor::*[count(. | $ancestorrootnode) 
                                != count($ancestorrootnode)]"/>
    <xsl:if test="$needs.navig and not(self::set)">
      <div id="_bottom-navigation">
        <xsl:if test="count($next) >0 and $isnext">
          <a class="nav-link">
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="$next"/>
              </xsl:call-template>
            </xsl:attribute>
            <span class="next-icon">→</span>
            <span class="nav-label">
              <xsl:apply-templates select="$next"
                mode="object.title.markup"/>
            </span>
          </a>
        </xsl:if>
        <xsl:if test="count($prev) >0 and $isprev">
          <a class="nav-link">
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="$prev"/>
              </xsl:call-template>
            </xsl:attribute>
            <span class="prev-icon">←</span>
            <span class="nav-label">
              <xsl:apply-templates select="$prev"
                mode="object.title.markup"/>
            </span>
          </a>
      </xsl:if>
      </div>
    </xsl:if>
  </xsl:template>

  <!-- ===================================================== -->

  <xsl:template name="body.class.attribute">
    <xsl:choose>
      <xsl:when test="($draft.mode = 'yes' or
                    ($draft.mode = 'maybe' and
                    ancestor-or-self::*[@status][1]/@status = 'draft'))
                    and $draft.watermark.image != ''">
        <xsl:attribute name="class">draft offline</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="class">offline</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ===================================================== -->
  <xsl:template name="chunk-element-content">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="nav.context"/>
    <xsl:param name="content">
      <xsl:apply-imports/>
    </xsl:param>
    <xsl:variable name="lang">
      <xsl:apply-templates select="(ancestor-or-self::*/@lang)[last()]" mode="html.lang.attribute"/>
    </xsl:variable>

    <!--<xsl:call-template name="log.message">
      <xsl:with-param name="level">Info</xsl:with-param>
      <xsl:with-param name="message">object.title.markup.textonly=<xsl:apply-templates select="." mode="title.markup.textonly"/>
      </xsl:with-param>
    </xsl:call-template>-->

    <xsl:call-template name="user.preroot"/>

    <html lang="{$lang}" xml:lang="{$lang}">
      <xsl:call-template name="root.attributes"/>
      <xsl:call-template name="html.head">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
      </xsl:call-template>

      <body>
        <xsl:call-template name="body.attributes"/>
        <xsl:call-template name="body.class.attribute"/>
        <div id="_outer-wrap">
          <div id="_white-bg">
            <div id="_header">
              <xsl:call-template name="create.header.logo"/>
              <xsl:call-template name="pickers"/>
              <xsl:call-template name="breadcrumbs.navigation">
                <xsl:with-param name="prev" select="$prev"/>
                <xsl:with-param name="next" select="$next"/>
              </xsl:call-template>
              
              <xsl:call-template name="clearme"/>
            </div>
          </div>
          
          <xsl:call-template name="toolbar-wrap">
            <xsl:with-param name="next" select="$next"/>
            <xsl:with-param name="prev" select="$prev"/>
          </xsl:call-template>
          
          <xsl:call-template name="fixed-header-wrap">
            <xsl:with-param name="next" select="$next"/>
            <xsl:with-param name="prev" select="$prev"/>
          </xsl:call-template>
          
          <xsl:call-template name="user.header.navigation">
            <xsl:with-param name="prev" select="$prev"/>
            <xsl:with-param name="next" select="$next"/>
            <xsl:with-param name="nav.context" select="$nav.context"/>
          </xsl:call-template>

        <!--<xsl:call-template name="header.navigation">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="nav.context" select="$nav.context"/>
        </xsl:call-template>-->

          <xsl:call-template name="user.header.content"/>
          <div id="_content">
            <xsl:if test="$use.meta != 0">
              <!--
                On every structural element (like chapter, preface, ...) we
                have a xml:base attribute pointing to the filename
                If it isn't available, we point to the book filename
              -->
              <xsl:variable name="xmlbase.filename">
                <xsl:variable name="_xmlbase" 
                  select="(ancestor-or-self::chapter|
                  ancestor-or-self::preface|
                  ancestor-or-self::appendix|
                  ancestor-or-self::glossary)/@xml:base"/>
                <xsl:choose>
                  <xsl:when test="$_xmlbase != ''">
                    <xsl:value-of select="$_xmlbase"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="ancestor-or-self::book/@xml:base"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:comment>htdig_noindex</xsl:comment>
              <xsl:call-template name="getmetadata">
                <xsl:with-param name="filename" select="$xmlbase.filename"/>
              </xsl:call-template>
              <xsl:comment>/htdig_noindex</xsl:comment>
            </xsl:if>
            
            <xsl:copy-of select="$content"/>
            
            <div class="page-bottom">
              <xsl:call-template name="bottom.navigation">
                <xsl:with-param name="prev" select="$prev"/>
                <xsl:with-param name="next" select="$next"/>
                <xsl:with-param name="nav.context" select="$nav.context"/>
              </xsl:call-template>
              <xsl:call-template name="share.and.print">
                <xsl:with-param name="prev" select="$prev"/>
                <xsl:with-param name="next" select="$next"/>
                <xsl:with-param name="nav.context" select="$nav.context"/>
              </xsl:call-template>
            </div>
          </div>
          
          <div id="_inward"></div>
        </div>
        
        <div id="_footer-wrap">
        <xsl:call-template name="user.footer.content"/>

        <!--
        <xsl:call-template name="footer.navigation">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="nav.context" select="$nav.context"/>
        </xsl:call-template>
        -->
        
        <xsl:call-template name="user.footer.navigation">
          <xsl:with-param name="prev" select="$prev"/>
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="nav.context" select="$nav.context"/>
        </xsl:call-template>
        </div>
      </body>
    </html>
    <xsl:value-of select="$chunk.append"/>
  </xsl:template>
  
  
  <xsl:template name="user.head.content">
    <xsl:param name="node" select="."/>
    <xsl:if test="$daps.header.js.library != ''">
      <xsl:call-template name="make.script.link">
        <xsl:with-param name="script.filename" select="$daps.header.js.library"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$daps.header.js.custom != ''">
      <xsl:call-template name="make.script.link">
        <xsl:with-param name="script.filename" select="$daps.header.js.custom"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="user.footer.content">
    <div id="_footer">
      <p>© 2012 SUSE</p>
      <ul>
        <li>
          <a href="http://www.suse.com/company/careers/" target="_top">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">susecareers</xsl:with-param>
            </xsl:call-template>
          </a>
        </li>
        <li>
          <a href="http://www.suse.com/company/legal/" target="_top">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">suselegal</xsl:with-param>
            </xsl:call-template>
          </a>
        </li>
        <li>
          <a href="http://www.suse.com/company/" target="_top">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">suseabout</xsl:with-param>
            </xsl:call-template>
          </a>
        </li>
        <li>
          <a href="http://www.suse.com/ContactsOffices/contacts_offices.jsp"
            target="_top">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">susecontact</xsl:with-param>
            </xsl:call-template>
          </a>
        </li>
      </ul>
    </div>
    
  </xsl:template>

</xsl:stylesheet>
