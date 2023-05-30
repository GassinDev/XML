<?xml version="1.0" encoding="UTF-8"?>

<!-- Declaración de archivo xsl -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <!-- Posible url en la que se aplica??? -->
    <xsl:template match="/proyecto">

        <!-- Nuevo elemento raíz: memoria -->
        <xsl:element name="memoria">

            <!-- Atributo fecha -->
            <!-- Que es rellenado con todo lo del xml que sea "fecha_publicacion" y esté dentro de "datos_proyecto" -->
            <xsl:attribute name="fecha">
                <xsl:value-of select="datos_proyecto/fecha_publicacion" />
            </xsl:attribute>

            <!-- Elemento titular -->
            <xsl:element name="titular">

            <!-- Esto lo que hace es que cuando el atributo lang es igual a X, pone X palabra -->
            <!-- A niveles prácticos es como un if -->
                <xsl:choose>

                    <xsl:when test="@lang='es'"> <!-- Cuando el atributo (marcado con un @) es igual a 'es' pone una cosa-->
                        <xsl:value-of select="concat('(', 'Castellano', ')', ' ', datos_proyecto/titulo)" /> <!-- Concat es una cosararilla que sirve para hacer cosas en menos lineas, yo por si acaso no la toco-->
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
                    <!-- Y esto como un else -->
                    <xsl:otherwise>
                        <xsl:value-of select="datos_proyecto/titulo" />
                    </xsl:otherwise>
                    

                </xsl:choose>

            </xsl:element>

            <!-- Elemento autores -->            
            <xsl:element name="autores">
                <!-- Por cada autor del xml que esté dentro de datos_proyecto, coge el nombre, mete un
                espacio y luego apellidos -->
                <xsl:for-each select="datos_proyecto/autor">
                    <xsl:value-of select="concat(nombre, ' ', apellidos)" />

                    <xsl:choose>

                        <xsl:when test="position()=(last() - 1)"> <!-- Cuando la posicion sea el penúltimo, pon un a 'y' con el xsl:text,-->
                            <xsl:text> y </xsl:text>
                        </xsl:when>

                        <xsl:when test="position()!=last()"> <!-- Y mientras no sea el ultimo, pon comas para separar -->
                            <xsl:text>, </xsl:text>
                        </xsl:when>
                    </xsl:choose>

                </xsl:for-each>
            </xsl:element>        

            <!-- Elementos a -->
            <xsl:for-each select="datos_proyecto/bibliografia/referencia"> <!-- Por cada referencia, dentro de bibliografia, dentro de datos_proyecto -->

                <xsl:element name="a"> <!-- Crea un elemento xsl de nombre a -->

                    <!-- Atributo href -->
                    <xsl:attribute name="href"> <!-- Con un atributo xml de nombre href -->
                        <xsl:value-of select="@enlace" /> <!-- Con el valor del atributo enlace -->
                    </xsl:attribute>
                    <!-- Traduccion logica de esta parte: estamos creando elementos y atributos html desde aqui
                    primero tenemos el elemento a, que lo creamos sin nada mas, pero antes de cerrar la etiqueta de este elemento agregamos un attribute, lo que hace
                que este esté dentro del elemento creado (<a href="X"> 
                    Y ahora, para que el href tenga algo hacemos un value of select y cogemos el atributo del documento xml llamado enlace-->
                    <xsl:value-of select="." />

                </xsl:element>

            </xsl:for-each>

            <!-- Elemento blockquote -->

            <!-- Si antes habia un elemento que funcionaba como un if, aqui tenemos literalmente el if -->
            <xsl:if test="dedicatoria"> <!-- Si el atributo test es igual a "dedicatoria" (lo que significa que estariamos hablando de una especie de cita) -->

                <xsl:element name="blockquote"> <!-- Crea un elemento html blockquote -->

                    <xsl:for-each select="dedicatoria/parrafo"> <!-- Por cada elemento parrafo en la ya mencionada dedicatoria... -->

                        <xsl:element name="p"> <!-- Crea un elemento parrafo -->
                            <xsl:value-of select="." /> <!-- Lo llena con lo que haya en el elemento parrafo, de ahi el punto, ya estamos dentro del parrafo debido al 
                            for each select, ahora usamos un punto para referirnos a donde estamos, como si fuese una terminal de windows o linux -->
                        </xsl:element>

                    </xsl:for-each>

                </xsl:element>

            </xsl:if>

            <!-- Elemento texto -->
            <xsl:element name="texto"> <!-- Creamos elemento texto-->

                <xsl:for-each select="apartado"> <!-- Seleccionamos todos los apartados -->

                    <xsl:element name="h2"> <!-- Y, por cada uno, creamos un h2 -->
                        <xsl:text>(</xsl:text> <!-- Estas lineas son para poner un parentesis de apertura, seleccionar el atributo id del xml, otro parentesis, y el contenido
                        del atributo titulo, de esta forma se consigue una mejor presentacion (y bueno, lo pide el enunciado asi que..) esto seria tambien realizable en una 
                    sola linea con lo que habia antes de "concat" pero no sé usarlo -->
                        <xsl:value-of select="@id" />
                        <xsl:text>) </xsl:text>
                        <xsl:value-of select="titulo" />
                    </xsl:element>

                    <xsl:if test="seccion"> <!-- Esto ya está visto, si el test contiene una seccion... -->

                        <xsl:for-each select="seccion"> <!-- ... Por cada seccion... -->

                            <xsl:element name="h3"> <!-- ... Crea un elemento h3 con el valor del contenido de titulo -->
                                <xsl:value-of select="titulo" />
                            </xsl:element>

                            <xsl:for-each select="parrafo"> <!-- Por cada parrafo un elemento p con lo que contenga el propio parrafo -->

                                <xsl:element name="p">
                                    <xsl:value-of select="." />
                                </xsl:element>
                                <!-- Hasta aquí. En resumen, lo que está haciendo esto es transformar un xml siguiendo varias reglas que le damos, 
                                casi todo es similar a la programación, hacemos bucles que recorren el documento buscando cada elemento, cuando lo encuentran lo añaden
                            y lo rellenan con contenido de otra cosa... va de ese rollo, diría que, a pesar de la sintaxis, esto es relativamente fácil -->
                            </xsl:for-each>

                        </xsl:for-each>

                    </xsl:if>                    

                </xsl:for-each>

            </xsl:element>

        </xsl:element>

    </xsl:template>

</xsl:stylesheet>