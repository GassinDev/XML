<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" encoding="utf-8" />

    <xsl:template match="/inventario">

        <xsl:element name="listado">

            <xsl:element name="mantiene">

                <xsl:attribute name="correo">
                    <xsl:value-of select="mail" />
                </xsl:attribute>

                <xsl:value-of select="responsable" />

            </xsl:element>

            <xsl:element name="cotacto">

                <xsl:for-each select="tel">

                    <xsl:choose>

                        <xsl:when test="@tipo='particular'">
                            <xsl:element name="particular">
                                <xsl:value-of select="." />
                            </xsl:element>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:element name="tel">
                                <xsl:value-of select="." />
                            </xsl:element>
                        </xsl:otherwise>

                    </xsl:choose>

                </xsl:for-each>

            </xsl:element>

            <xsl:element name="responsables">

                <xsl:for-each select="espacio">

                    <xsl:value-of select="concat(position(),'. ', responsable)" />

                    <xsl:if test="position()!=last()">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <!-- <xsl:value-of select="responsable"/> -->

                </xsl:for-each>

            </xsl:element>

            <xsl:element name="detalle">

                <xsl:for-each select="espacio">
                    <xsl:comment>
                        <xsl:value-of select="concat(@code,' ',nombre)"></xsl:value-of>
                    </xsl:comment>

                    <xsl:for-each select="item[cantidad&gt;0]">

                        <xsl:sort select="cantidad" data-type="number" order="ascending" />
                        <xsl:element name="item">
                            <xsl:value-of select="concat(cantidad, ' ', nombre)" />
                        </xsl:element>

                    </xsl:for-each>

                </xsl:for-each>

            </xsl:element>

        </xsl:element>

    </xsl:template>

</xsl:stylesheet>