<?xml version="1.0" encoding="UTF-8"?>
<!--
   Purpose:
     Create structure of chunked contents

   See Also:
     * http://doccookbook.sf.net/html/en/dbc.common.dbcustomize.html
     * http://sagehill.net/docbookxsl/CustomMethods.html#WriteCustomization

   Author:    Thomas Schraitle <toms@opensuse.org>,
              Stefan Knorr <sknorr@suse.de>
   Copyright: 2012, 2013, Thomas Schraitle, Stefan Knorr

-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="http://docbook.org/ns/docbook"
    xmlns:exsl="http://exslt.org/common"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://nwalsh.com/docbook/xsl/template/1.0"
    xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
    exclude-result-prefixes="exsl l t d">

  <xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/chunk-common.xsl"/>

  <!-- ===================================================== -->
  <xsl:template
    match="d:appendix|d:article|d:book|d:bibliography|d:chapter|d:part|d:preface|d:glossary|d:sect1|d:set|d:refentry|d:index"
                mode="breadcrumbs">
    <xsl:param name="class">crumb</xsl:param>
    <xsl:param name="context">header</xsl:param>

    <xsl:variable name="title.candidate">
      <xsl:apply-templates select="." mode="titleabbrev.markup"/>
    </xsl:variable>
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="$title.candidate != ''">
          <xsl:value-of select="$title.candidate"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="local-name(.)"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
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
            <xsl:choose>
              <xsl:when test="$overview-page = ''">
                <xsl:attribute name="class">book-icon</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="class">book-icon lower-level</xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
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
            <span class="single-contents-icon"> </span>
          </xsl:if>
          <xsl:if test="$context = 'fixed-header'">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">showcontentsoverview</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key">admonseparator</xsl:with-param>
            </xsl:call-template>
          </xsl:if>
          <xsl:value-of select="string($title)"/>
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
        <xsl:call-template name="generate.breadcrumbs.back"/>
        <xsl:choose>
          <xsl:when test="$rootelementname != 'article'">
            <xsl:for-each select="ancestor-or-self::*">
              <xsl:choose>
                <xsl:when test="$rootid != '' and descendant::*[@xml:id = string($rootid)]"/>
                <xsl:when test="not(ancestor::*) or @xml:id = string($rootid)">
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


  <xsl:template name="create.header.buttons.nav">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:if test="not(self::d:set|self::d:article)">
      <div class="button">
        <xsl:call-template name="header.navigation">
          <xsl:with-param name="next" select="$next"/>
          <xsl:with-param name="prev" select="$prev"/>
        </xsl:call-template>
      </div>
    </xsl:if>
  </xsl:template>


  <xsl:template name="header.navigation">
    <xsl:param name="prev" select="/d:foo"/>
    <xsl:param name="next" select="/d:foo"/>
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


  <!-- ===================================================== -->
  <xsl:template name="bottom.navigation">
    <xsl:param name="prev" select="/d:foo"/>
    <xsl:param name="next" select="/d:foo"/>
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
    <xsl:if test="$generate.bottom.navigation != 0 and $needs.navig = 'true' and not(self::d:set)">
      <div id="_bottom-navigation">
        <xsl:if test="count($next) > 0 and $isnext = 'true'">
          <a class="nav-link">
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="$next"/>
              </xsl:call-template>
            </xsl:attribute>
            <span class="next-icon">→</span>
            <span class="nav-label">
              <xsl:apply-templates select="$next" mode="page-bottom.label"/>
              <xsl:apply-templates select="$next" mode="titleabbrev.markup"/>
            </span>
          </a>
        </xsl:if>
        <xsl:if test="count($prev) > 0 and $isprev = 'true'">
          <a class="nav-link">
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="$prev"/>
              </xsl:call-template>
            </xsl:attribute>
            <span class="prev-icon">←</span>
            <span class="nav-label">
              <xsl:apply-templates select="$prev" mode="page-bottom.label"/>
              <xsl:apply-templates select="$prev" mode="titleabbrev.markup"/>
            </span>
          </a>
      </xsl:if>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="d:chapter|d:appendix|d:part" mode="page-bottom.label">
    <xsl:variable name="template">
      <xsl:call-template name="gentext.template">
        <xsl:with-param name="context" select="'xref-number'"/>
        <xsl:with-param name="name" select="local-name()"/>
      </xsl:call-template>
    </xsl:variable>

    <span class="title-number">
      <xsl:call-template name="substitute-markup">
        <xsl:with-param name="template" select="$template"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="*" mode="page-bottom.label"/>

  <!-- ===================================================== -->
  <xsl:template name="chunk-element-content">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="nav.context"/>
    <xsl:param name="content">
      <xsl:apply-imports/>
    </xsl:param>

    <xsl:call-template name="chunk-element-content-html">
      <xsl:with-param name="content" select="$content"/>
      <xsl:with-param name="next" select="$next"/>
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="nav.context" select="$nav.context"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="chunk-element-content-html">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="nav.context"/>
    <xsl:param name="content"/>

    <xsl:variable name="lang">
      <xsl:apply-templates select="(ancestor-or-self::*/@xml:lang)[last()]" mode="html.lang.attribute"/>
    </xsl:variable>

    <xsl:call-template name="user.preroot"/>

    <html lang="{$lang}">
      <xsl:call-template name="root.attributes"/>
      <xsl:call-template name="html.head">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
      </xsl:call-template>

      <body>
        <xsl:call-template name="body.attributes"/>
        <xsl:call-template name="outerelement.class.attribute"/>
        <xsl:call-template name="bypass">
          <xsl:with-param name="format" select="'chunk'"/>
        </xsl:call-template>

        <!-- FIXME support all params supported in xhtml/docbook.xsl -->
        <xsl:call-template name="user.header.content"/>

        <main id="_content">
          <xsl:call-template name="outerelement.class.attribute">
            <xsl:with-param name="node" select="'id-content'"/>
          </xsl:call-template>

          <xsl:call-template name="side.toc.overall"/>

          <article class="documentation">
            <xsl:copy-of select="$content"/>

            <nav class="page-bottom">
              <xsl:call-template name="bottom.navigation">
                <xsl:with-param name="prev" select="$prev"/>
                <xsl:with-param name="next" select="$next"/>
                <xsl:with-param name="nav.context" select="$nav.context"/>
              </xsl:call-template>
            </nav>

          </article>

          <nav id="_side-toc-page">
            <div class="mini-toc-title">On this page</div>
            <ol>
              <li>Ceci n'est pas un content</li>
            </ol>
          </nav>

        </main>

        <nav class="sidebar-secondary">
          <xsl:call-template name="share.and.print">
            <xsl:with-param name="prev" select="$prev"/>
            <xsl:with-param name="next" select="$next"/>
            <xsl:with-param name="nav.context" select="$nav.context"/>
          </xsl:call-template>
        </nav>

        <!-- FIXME support all params supported in xhtml/docbook.xsl -->
        <xsl:call-template name="user.footer.content"/>

      </body>
    </html>
  </xsl:template>


  <xsl:template name="user.header.content">
    <xsl:choose>
     <xsl:when test="$include.ssi.header != ''">
       <xsl:comment>#include virtual="<xsl:value-of select="$include.ssi.header"/>"</xsl:comment>
     </xsl:when>
     <xsl:when test="$generate.header != 0">
       <header id="navbar">
         <xsl:call-template name="create.header.logo"/>
         <xsl:call-template name="breadcrumbs.navigation">
           <!--<xsl:with-param name="prev" select="$prev"/>
           <xsl:with-param name="next" select="$next"/>-->
         </xsl:call-template>
       </header>
     </xsl:when>
     <xsl:otherwise/>
   </xsl:choose>
  </xsl:template>

  <xsl:template name="user.footer.content">
    <xsl:choose>
     <xsl:when test="$include.ssi.footer != ''">
       <xsl:comment>#include virtual="<xsl:value-of select="$include.ssi.footer"/>"</xsl:comment>
     </xsl:when>
     <xsl:if test="$generate.footer = 1">
       <footer>
         <xsl:call-template name="user.footer.content"/>
         <xsl:call-template name="user.footer.navigation">
           <!--<xsl:with-param name="prev" select="$prev"/>-->
           <!--<xsl:with-param name="next" select="$next"/>-->
           <xsl:with-param name="nav.context" select="$nav.context"/>
         </xsl:call-template>
       </footer>
     </xsl:if>
     <xsl:otherwise/>
   </xsl:choose>
  </xsl:template>





  <xsl:template name="side.toc.overall">
    <xsl:if test="$generate.side.toc != 0">
      <nav id="_side-toc-overall">
        <xsl:call-template name="side.toc.overall.inner">
          <xsl:with-param name="node" select="((ancestor-or-self::d:book | ancestor-or-self::d:article)|key('id', $rootid))[last()]"/>
        </xsl:call-template>
      </nav>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
