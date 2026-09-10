<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:maml="http://schemas.microsoft.com/maml/2004/10"
    xmlns:command="http://schemas.microsoft.com/maml/dev/command/2004/10"
    xmlns:dev="http://schemas.microsoft.com/maml/dev/2004/10" version="1.0">
    <xsl:template match="/command:command">
        <html>
            <head>
                <title><xsl:value-of select="//command:name"/></title>
                <link rel="stylesheet" type="text/css" href="style.css" />
            </head>
            <body> 
                <h4 id="Name"></h4>
                <p class="title">
                    <xsl:value-of select="//command:name"/>
                </p>
                <h4 id="Synopsis">Synopsis</h4>
                <p>
                    <xsl:value-of select="//maml:description/maml:para"/>
                </p>
                <h4 id="Syntax">Syntax</h4>
                <div class="codeSnippetContainerCodeContainer">
                    <div class="codeSnippetContainerCode">
                        <xsl:for-each select="command:syntax/command:syntaxItem">
                            <p><xsl:value-of select="maml:name"/>
                                <xsl:for-each select="command:parameter"> [-<xsl:value-of select="maml:name"
                                    />] </xsl:for-each> [&lt;CommonParameters&gt;] </p>
                    	</xsl:for-each>
                    </div>
                </div>
                <h4 id="DetailedDescription">Detailed Description</h4>
                	<xsl:for-each select="maml:description/maml:para">
                        <p>
                        	<xsl:value-of select="."/>
                        </p>
                    </xsl:for-each>
                <h4 id="Parameters">Parameters</h4>
                <xsl:for-each select="command:parameters/command:parameter">
                    <p class="subheading">
                        -<xsl:value-of select="maml:name"/> &lt;<xsl:value-of
                                select="dev:type/maml:name"/>&gt;
                    </p>
                	<xsl:for-each select="maml:description/maml:para">
                        <p>
                        	<xsl:value-of select="."/>
                        </p>
                    </xsl:for-each>
                    <table>
		           <tr><td><p>Aliases</p></td><td><p><xsl:choose><xsl:when test="@aliases != ''"><xsl:value-of select="@aliases"/></xsl:when><xsl:otherwise>None</xsl:otherwise></xsl:choose></p></td></tr>
					   
					    <tr><td><p>Required?</p></td><td><p><xsl:value-of select="@required" /></p></td></tr>
                        <tr><td><p>Position</p></td><td><p><xsl:value-of select="@position" /></p></td></tr>
                        <tr><td><p>Default value</p></td><td><p><xsl:choose><xsl:when test="dev:defaultValue != ''"><xsl:value-of select="dev:defaultValue"/></xsl:when><xsl:otherwise>None</xsl:otherwise></xsl:choose></p></td></tr>
                        <tr><td><p>Accept pipeline input?</p></td><td><p><xsl:value-of select="@pipelineInput" /></p></td></tr>
                        <tr><td><p>Accept wildcard characters?</p></td><td><p><xsl:value-of select="@globbing"/></p></td></tr>
                    </table>
                </xsl:for-each>
                <h4 id="InputType">Input Type</h4>
                <p>
                    <xsl:for-each select="command:inputTypes/command:inputType">
                        <xsl:value-of select="dev:type/maml:name"/>
                        <br/>
                    </xsl:for-each>
                </p>
                <h4 id="ReturnType">Return Type</h4>
                <p>
                    <xsl:for-each select="command:returnValues/command:returnValue">
                        <xsl:value-of select="dev:type/maml:name"/>
                        <br/>
                    </xsl:for-each>
                </p>
                <h4 id="Notes">Notes</h4>
                <xsl:choose>
                	<xsl:when test="maml:alertSet">
                    	<xsl:for-each select="maml:alertSet">
                            	<xsl:for-each select="maml:title">
                                	<xsl:if test=". != ''">
                                        <p class="subheading">
                                        <xsl:value-of select="."/>
                                        </p>
                                    </xsl:if>
                                </xsl:for-each>
                                <xsl:for-each select="maml:alert/maml:para">
                                    <p>
                                    <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                    	</xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise><p>None</p></xsl:otherwise>
                </xsl:choose>
                <h4 id="Examples">Examples</h4>
                <xsl:for-each select="command:examples/command:example">
                    <p class="subheading">
                        <xsl:value-of select="maml:title"/>
                    </p>
                    <xsl:for-each select="maml:introduction/maml:para">
                        <xsl:if test=". != ''">
                            <p>
                            	<xsl:value-of select="."/>
                            </p>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:for-each select="dev:remarks/maml:para">
                        <xsl:if test=". != ''">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:if>
                    </xsl:for-each>
                	<div class="codeSnippetContainerCodeContainer">
                        <div class="codeSnippetContainerCode">
                            <pre>
                                <xsl:value-of select="dev:code"/>
                            </pre>
                        </div>
                    </div>
                </xsl:for-each>
                <h4 id="RelatedLinks">Related Links</h4>
                <p>
                    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
                    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
                    <xsl:for-each select="maml:relatedLinks/maml:navigationLink">
                        <xsl:if test="translate(maml:linkText, $smallcase, $uppercase) = 'ONLINE VERSION:'">
                            <a><xsl:attribute name="href"><xsl:value-of select="maml:uri"/></xsl:attribute>Online Version</a><br/>
                        </xsl:if>
                        <xsl:if test="translate(maml:linkText, $smallcase, $uppercase) != 'ONLINE VERSION:'">
                            <a><xsl:attribute name="href">SAPIENHelp://<xsl:value-of select="maml:linkText"/></xsl:attribute><xsl:value-of select="maml:linkText"/></a><br/>
                        </xsl:if>
                    </xsl:for-each>
                </p>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
