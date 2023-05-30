<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:template match="/proyecto">

        <!-- Nuevo elemento raíz: memoria -->
        <xsl:element name="memoria">

            <!-- Atributo fecha -->
            <xsl:attribute name="fecha">
                <xsl:value-of select="datos_proyecto/fecha_publicacion" />
            </xsl:attribute>

            <!-- Elemento titular -->
            <xsl:element name="titular">

                <xsl:choose>

                    <xsl:when test="@lang='es'">
                        <xsl:value-of select="concat('(', 'Castellano', ')', ' ', datos_proyecto/titulo)" />
                    </xsl:when>

                    <xsl:when test="@lang='en'">
                        <xsl:value-of select="concat('(', 'Inglés', ')', ' ', datos_proyecto/titulo)" />
                    </xsl:when>

                    <xsl:when test="@lang='fr'">
                        <xsl:value-of select="concat('(', 'Francés', ')', ' ', datos_proyecto/titulo)" />
                    </xsl:when>

                    <xsl:when test="@lang='ge'">
                        <xsl:value-of select="concat('(', 'Alemán', ')', ' ', datos_proyecto/titulo)" />
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:value-of select="datos_proyecto/titulo" />
                    </xsl:otherwise>

                </xsl:choose>

            </xsl:element>

            <!-- Elemento autores -->
            <xsl:element name="autores">

                <xsl:for-each select="datos_proyecto/autor">
                    <xsl:value-of select="concat(nombre, ' ', apellidos)" />

                    <xsl:choose>

                        <xsl:when test="position()=(last() - 1)">
                            <xsl:text> y </xsl:text>
                        </xsl:when>

                        <xsl:when test="position()!=last()">
                            <xsl:text>, </xsl:text>
                        </xsl:when>
                    </xsl:choose>

                </xsl:for-each>

            </xsl:element>

            <!-- Elementos a -->
            <xsl:for-each select="datos_proyecto/bibliografia/referencia">

                <xsl:element name="a">

                    <!-- Atributo href -->
                    <xsl:attribute name="href">
                        <xsl:value-of select="@enlace" />
                    </xsl:attribute>

                    <xsl:value-of select="." />

                </xsl:element>

            </xsl:for-each>

            <!-- Elemento blockquote -->
            <xsl:if test="dedicatoria">

                <xsl:element name="blockquote">

                    <xsl:for-each select="dedicatoria/parrafo">

                        <xsl:element name="p">
                            <xsl:value-of select="." />
                        </xsl:element>

                    </xsl:for-each>

                </xsl:element>

            </xsl:if>

            <!-- Elemento texto -->
            <xsl:element name="texto">

                <xsl:for-each select="apartado">

                    <xsl:element name="h2">
                        <xsl:value-of select="concat('(', @id, ')', titulo)" />
                    </xsl:element>

                    <xsl:if test="seccion">

                        <xsl:for-each select="seccion">

                            <xsl:element name="h3">
                                <xsl:value-of select="titulo" />
                            </xsl:element>

                            <xsl:for-each select="parrafo">

                                <xsl:element name="p">
                                    <xsl:value-of select="." />
                                </xsl:element>

                            </xsl:for-each>

                        </xsl:for-each>

                    </xsl:if>

                </xsl:for-each>

            </xsl:element>

        </xsl:element>

    </xsl:template>

</xsl:stylesheet>