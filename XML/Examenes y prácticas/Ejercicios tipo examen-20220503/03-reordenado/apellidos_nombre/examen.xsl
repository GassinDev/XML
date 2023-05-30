<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" encoding="UTF-8" />

    <xsl:template match="xbel">

        <xsl:element name="favoritos">
            <xsl:attribute name="propietario">
                <xsl:value-of select="owner" />
            </xsl:attribute>
            <xsl:element name="fecha">
                <xsl:value-of select="@added" />
            </xsl:element>

            <xsl:for-each select="folder">
                <xsl:comment>Folder ...</xsl:comment>
                <xsl:comment>
                    <xsl:value-of select="title" />
                </xsl:comment>
                
                <xsl:for-each select="bookmark[ranking&gt;0]">
                    <xsl:sort select="ranking" data-type="number" order="descending"/>
                    <xsl:element name="item">
                        

                        <xsl:element name="puntos">
                            <xsl:value-of select="ranking" />                        
                        </xsl:element>

                        <xsl:element name="titulo">
                            <xsl:value-of select="title" />
                        </xsl:element>

                        <xsl:element name="url">
                            <xsl:value-of select="@href" />
                        </xsl:element>

                        <xsl:element name="etiquetas">
                            <xsl:for-each select="tag">
                                <xsl:value-of select="." />

                                <xsl:if test="position()!=last()">
                                    <xsl:text> # </xsl:text>
                                </xsl:if>

                            </xsl:for-each>
                        </xsl:element>

                    </xsl:element>
                </xsl:for-each>

            </xsl:for-each>

        </xsl:element>

    </xsl:template>

</xsl:stylesheet>