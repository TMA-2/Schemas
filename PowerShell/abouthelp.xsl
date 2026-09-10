<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:my="my:my" exclude-result-prefixes="xs">
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="textfile" select="textfile"/>
      <xsl:variable name="vTopicName">
          <xsl:call-template name="get-title">
              <xsl:with-param name="text" select="$textfile" />
              <xsl:param name="pPLine" />
              <xsl:param name="pTopic" select="0"/>
          </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="vTitle">
          <xsl:call-template name="replace-string">
            <xsl:with-param name="text" select="$vTopicName"/>
            <xsl:with-param name="replace" select="'_'" />
            <xsl:with-param name="with" select="' '"/>
          </xsl:call-template>
      </xsl:variable>

    <xsl:template match="/">
    <html> 
      <head> 
      	<title>
        	<xsl:value-of select="$vTitle"/>
        </title>
		<style>
        </style>
        <link rel="stylesheet" type="text/css" href="style.css" />
     </head>
     <body bgcolor="#ffffff">
      <xsl:call-template name="break">
        <xsl:with-param name="text" select="$textfile" />
        <xsl:with-param name="pPLine" />
        <xsl:with-param name="pSeeAlso" select="0"/>
      </xsl:call-template>
     </body>
    </html>
    </xsl:template>
    
	<xsl:template name="break">
      <xsl:param name="text" select="."/>
      <xsl:param name="pPLine" />
      <xsl:param name="pSeeAlso" />
      <xsl:choose>
        <xsl:when test= "contains($text, '&#xa;') ">
        	<xsl:variable name="vLine" select="substring-before($text, '&#xa;')" />
        	<xsl:variable name="vNLine" select="substring-after($text, '&#xa;')" />
        	<xsl:variable name="vPLine" select="$pPLine" />
        	<xsl:variable name="vpSeeAlso" select="$pSeeAlso" />
            
        	<xsl:variable name="vLineLength" select="string-length($vLine)"/>
            <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
            <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
            <xsl:choose>
                <xsl:when test= "$vLineLength &gt; 1 and not($vpSeeAlso = 1)" >
                  <xsl:choose>
                        
                        <xsl:when test= "starts-with($vLine, '        - ')">
                            <xsl:variable name="vInnerString" select="concat(substring($vLine, 11, $vLineLength ), ' ')"/>
                            <ul class='list'><li><xsl:value-of select="$vInnerString"/></li></ul>
                        </xsl:when>
                        
                        <xsl:when test= "starts-with($vLine, '        ') ">
                            <xsl:variable name="vInnerString" select="substring($vLine, 9, $vLineLength - 1)"/>
                            <xsl:choose>
                                <xsl:when test="starts-with($vNLine, '&#xa;        ')">
                                    <pre class="abouthelp">
                                        <xsl:value-of select="$vLine"/>
                                    </pre>
                                </xsl:when>
                                <xsl:otherwise>
                                    <pre class="abouthelp"><xsl:value-of select="$vLine"/></pre><br class="abouthelp" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        
                        <xsl:when test= "starts-with($vLine, '    ') and starts-with($vPLine, '    ') and  starts-with($vNLine, '&#xa;    ') ">
                            <xsl:variable name="vInnerString" select="concat(substring($vLine, 5, $vLineLength ), ' ')"/>
                            <xsl:choose>
                                <xsl:when test = "$vInnerString=' '">
                                    <br class="abouthelp" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <span><xsl:value-of select="$vInnerString"/></span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        
                        <xsl:when test= "starts-with($vLine, '    ') and not(starts-with($vPLine, '    ')) ">
                            <xsl:variable name="vInnerString" select="concat(substring($vLine, 5, $vLineLength ), ' ')"/>
                              <xsl:variable name="vNoSpaces">
                                  <xsl:call-template name="replace-string">
                                    <xsl:with-param name="text" select="$vInnerString"/>
                                    <xsl:with-param name="replace" select="' '" />
                                    <xsl:with-param name="with" select="''"/>
                                  </xsl:call-template>
                              </xsl:variable>
                            <xsl:choose>
                                <xsl:when test = "$vTopicName = $vNoSpaces">
                                    <span class="title"><xsl:value-of select="$vNoSpaces"/></span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span><xsl:value-of select="$vInnerString"/></span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        
                        <xsl:when test= "starts-with($vLine, '    ') ">
                            <xsl:variable name="vInnerString" select="substring($vLine, 5, $vLineLength )"/>
                            <span><xsl:value-of select="$vInnerString"/><br class="abouthelp"/></span>
                        </xsl:when>
                       
                        <xsl:otherwise>
                            <xsl:variable name="vInnerString" select="substring($vLine, 1, $vLineLength )"/>
                            <xsl:choose>
                                <xsl:when test= "$vInnerString = translate($vInnerString, $smallcase, $uppercase)  and not(contains($vInnerString, '      ')) and not(contains($vInnerString, '----'))  and not(contains($vInnerString, 'C:\PS'))">
                                   <h4><xsl:attribute name="id"><xsl:value-of select="$vInnerString"/></xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when test= "contains($vInnerString, 'TOPIC')">
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$vInnerString"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    </h4>
                               </xsl:when>
                               <xsl:otherwise>
                                    <pre class="abouthelp"><xsl:value-of select="concat('        ', $vInnerString)"/></pre>
                              </xsl:otherwise>
                              </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                   <xsl:variable name="vSeeAlso">
                   <xsl:choose>
                       <xsl:when test= "contains($vLine, 'SEE ALSO')"> 
                            1
                       </xsl:when>
                       <xsl:otherwise>
                            0
                       </xsl:otherwise>
                   </xsl:choose>
                   </xsl:variable> 
                
                    <xsl:call-template name="break">
                      <xsl:with-param name="text" select="$vNLine" />
                      <xsl:with-param name="pPLine" select="$vLine" />
                      <xsl:with-param name="pSeeAlso" select="$vSeeAlso"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="$vLineLength &gt; 2 and $vpSeeAlso = 1" >
                    <xsl:variable name="vSeeAlso" select="$vpSeeAlso" />
                    <xsl:choose>
                    <xsl:when test= "starts-with($vLine, '    ')">
                        <xsl:variable name="vInnerString" select="substring($vLine, 5, $vLineLength )"/>
                        <span><a><xsl:attribute name="href"><xsl:value-of select="concat('SAPIENHelp://', $vInnerString)"/></xsl:attribute><xsl:value-of select="$vInnerString"/></a><br class="abouthelp"/></span>
                        <xsl:call-template name="break">
                          <xsl:with-param name="text" select="substring-after($text, '&#xa;')" />
                          <xsl:with-param name="pPLine" select="substring-before($text, '&#xa;')" />
                          <xsl:with-param name="pSeeAlso" select="$vSeeAlso"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="break">
                          <xsl:with-param name="text" select="substring-after($text, '&#xa;')" />
                          <xsl:with-param name="pPLine" select="substring-before($text, '&#xa;')" />
                          <xsl:with-param name="pSeeAlso" select="$vSeeAlso"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="vSeeAlso" select="$vpSeeAlso" />
                  <xsl:call-template name="break">
                    <xsl:with-param name="text" select="substring-after($text, '&#xa;')" />
                    <xsl:with-param name="pPLine" select="$vPLine" />
                    <xsl:with-param name="pSeeAlso" select="$vSeeAlso"/>
                  </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$text"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
           
    <xsl:template name="get-title">
    <xsl:param name="text" select="."/>
    <xsl:param name="pPLine" />
    <xsl:param name="pTopic" />
    	<xsl:choose>
        <xsl:when test= "contains($text, '&#xa;') ">
        	<xsl:variable name="vLine" select="substring-before($text, '&#xa;')" />
        	<xsl:variable name="vNLine" select="substring-after($text, '&#xa;')" />
        	<xsl:variable name="vPLine" select="$pPLine" />
        	<xsl:variable name="vpTopic" select="$pTopic" />
        	<xsl:variable name="vLineLength" select="string-length($vLine)"/>
            
            <xsl:choose>
            <xsl:when test= "$vLineLength &gt; 2 and not($vpTopic = 1)" >
            
              	<xsl:variable name="vTopic">
                   <xsl:choose>
                       <xsl:when test= "contains($vLine, 'TOPIC')"> 
                            1
                       </xsl:when>
                       <xsl:otherwise>
                            0
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:variable> 
                
                <xsl:call-template name="get-title">
                  <xsl:with-param name="text" select="substring-after($text, '&#xa;')" />
                  <xsl:with-param name="pPLine" select="substring-before($text, '&#xa;')" />
                  <xsl:with-param name="pTopic" select="$vTopic"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test= "$vLineLength &gt; 2 and $vpTopic = 1" >
                <xsl:variable name="vTopicString" select="$vLine" />
                <xsl:call-template name="replace-string">
                  <xsl:with-param name="text" select="$vTopicString"/>
                  <xsl:with-param name="replace" select="' '" />
                  <xsl:with-param name="with" select="''"/>
                </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
        		<xsl:variable name="vTopic" select="$vpTopic"/>
                <xsl:call-template name="get-title">
                  <xsl:with-param name="text" select="substring-after($text, '&#xa;')" />
                  <xsl:with-param name="pPLine" select="substring-before($text, '&#xa;')" />
                  <xsl:with-param name="pTopic" select="$vTopic"/>
                </xsl:call-template>
          </xsl:otherwise>
       </xsl:choose>
       </xsl:when>
       </xsl:choose>
   </xsl:template>
    
    <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$with"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text"
select="substring-after($text,$replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="with" select="$with"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>