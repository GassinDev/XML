<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" encoding="utf-8" indent="yes" />
    
    <xsl:template match="/root">

        <xsl:comment>
            <xsl:value-of select="origen/productor"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="origen/web"/>
        </xsl:comment>

        <xsl:element name="eltiempo">
            <xsl:attribute name="derechos">
                <xsl:value-of select="origen/copyright"></xsl:value-of>
            </xsl:attribute>

            <xsl:element name="localidad">
                <xsl:value-of select="nombre"></xsl:value-of>
            </xsl:element>

            <xsl:element name="maximas">
                <xsl:for-each select="prediccion/dia">
                    <xsl:element name="valor">
                        <xsl:value-of select="temperatura/maxima"></xsl:value-of>
                        <xsl:value-of select="concat(' (', @fecha, ')')"></xsl:value-of>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>

            <xsl:for-each select="prediccion/dia">
            <xsl:sort select="@fecha"></xsl:sort>
            
                <xsl:element name="dia">
                    <xsl:attribute name="fecha">
                        <xsl:value-of select="@fecha"/>
                    </xsl:attribute>

                    <xsl:for-each select="temperatura/dato[ . &gt; 0] ">
                        <xsl:value-of select="."/> 
                        <xsl:if test="position()!=last()">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>

        </xsl:element>

    </xsl:template>
</xsl:stylesheet>