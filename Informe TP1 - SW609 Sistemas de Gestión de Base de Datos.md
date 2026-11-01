<p align="center"><img src="images/logo-uni.png" alt="Logo de la Universidad Nacional de Ingeniería" width="223"></p>
**UNIVERSIDAD NACIONAL DE INGENIERÍA**  
**Ingeniería de Software**  
**Período:** 2026-2  
**Curso:** Sistema de Gestión de Base de Datos  
**Código:** SW609  
**NRC:** \[completar\]  
**Docente:** Mg. Richard Leonardo Berrocal Navarro  
**INFORME DE TRABAJO PARCIAL (TP1)**  
**Nombre del startup:** DALERST  
**Nombre del producto:** Keel  
**Relación de integrantes**

| Código | Apellidos y nombres |
| :---- | :---- |
|  20244028F | Nuñez Villazana Franz Pool |
|  20244011F | Puris Ricaldi Roy Farid |
|  20240243J | Castro Aguirre Lenin Giomar |
|  20232156D | Ramos Jacay Dair David |

Lima, octubre de 2026

# **Registro de versiones del informe**

| Versión | Fecha | Autor | Descripción de modificación |
| :---- | :---- | :---- | :---- |
| 1.0 | 29/10/2026 | Franz Nuñez | Primera versión del informe: Capítulo I. |
| 1.1 | 30/10/2026 | Roy Farid Puris Ricaldi | Redacción del Capítulo I (secciones 1.1 a 1.3). |

*Cada fila lleva un solo autor. Agregar una fila por cada versión relevante (secciones nuevas, correcciones por retroalimentación del docente, etc.).*

# **Contenido**

[**Registro de versiones del informe	1**](#registro-de-versiones-del-informe)

[**Contenido	1**](#contenido)

[**Student Outcome	3**](#student-outcome)

[**Capítulo I: Introducción	3**](#capítulo-i-introducción)

[1.1. Startup profile	3](#11-startup-profile)

[1.1.1. Descripción del startup	3](#111-descripción-del-startup)

[1.1.2. Perfiles de integrantes del equipo	4](#112-perfiles-de-integrantes-del-equipo)

[1.2. Solution profile	5](#12-solution-profile)

[1.2.1. Antecedentes y problemática	5](#121-antecedentes-y-problemática)

[1.2.2. Propuesta de valor	7](#122-propuesta-de-valor)

[1.3. Segmentos objetivo	8](#13-segmentos-objetivo)

[**Capítulo II: Recopilación y análisis de requisitos	9**](#capítulo-ii-recopilación-y-análisis-de-requisitos)

[2.1. Entrevistas	9](#21-entrevistas)

[2.1.1. Diseño de entrevistas	9](#211-diseño-de-entrevistas)

[2.1.2. Registro de entrevistas	9](#212-registro-de-entrevistas)

[2.1.3. Análisis de entrevistas	10](#213-análisis-de-entrevistas)

[2.2. Requisitos	10](#22-requisitos)

[**Capítulo III: Diseño de base de datos	10**](#capítulo-iii-diseño-de-base-de-datos)

[3.1. Entidades	10](#31-entidades)

[3.2. Atributos	10](#32-atributos)

[3.3. Enfoque relacional	10](#33-enfoque-relacional)

[3.3.1. Diagrama entidad-relación lógico	10](#331-diagrama-entidad-relación-lógico)

[3.4. Enfoque no relacional (TF1)	10](#34-enfoque-no-relacional-tf1)

[3.4.1. Colecciones	10](#341-colecciones)

[3.4.2. Validación de esquema	10](#342-validación-de-esquema)

[3.4.3. Patrones de modelo de datos	10](#343-patrones-de-modelo-de-datos)

[**Capítulo IV: Implementación de base de datos	11**](#capítulo-iv-implementación-de-base-de-datos)

[4.1. Sistema de gestión de base de datos	11](#41-sistema-de-gestión-de-base-de-datos)

[4.1.1. Evaluación y elección del sistema de gestión de base de datos relacional	11](#411-evaluación-y-elección-del-sistema-de-gestión-de-base-de-datos-relacional)

[4.1.2. Evaluación y elección del sistema de gestión de base de datos no relacional (TF1)	11](#412-evaluación-y-elección-del-sistema-de-gestión-de-base-de-datos-no-relacional-tf1)

[4.2. Diagramas de datos	11](#42-diagramas-de-datos)

[4.2.1. Diagrama entidad-relación físico	11](#421-diagrama-entidad-relación-físico)

[4.2.2. Diagrama de documentos (TF1)	11](#422-diagrama-de-documentos-tf1)

[4.3. Scripts de creación de la base de datos (TF1)	11](#43-scripts-de-creación-de-la-base-de-datos-tf1)

[4.3.1. Scripts de creación y carga de datos de la base de datos relacional	11](#431-scripts-de-creación-y-carga-de-datos-de-la-base-de-datos-relacional)

[4.3.2. Scripts de creación y carga de datos de la base de datos no relacional	11](#432-scripts-de-creación-y-carga-de-datos-de-la-base-de-datos-no-relacional)

[4.4. Consultas (TF1)	11](#44-consultas-tf1)

[4.4.1. Consultas para la base de datos relacional	11](#441-consultas-para-la-base-de-datos-relacional)

[4.4.2. Consultas para la base de datos no relacional	11](#442-consultas-para-la-base-de-datos-no-relacional)

[**Conclusiones	12**](#conclusiones)

[Conclusiones y recomendaciones	12](#conclusiones-y-recomendaciones)

[Video About-the-Team	12](#video-about-the-team)

[**Bibliografía	12**](#bibliografía)

[**Anexos	12**](#anexos)

[Anexo A. Videos de exposiciones	12](#anexo-a-videos-de-exposiciones)

# 

# **Student Outcome**

ABET \- EAC \- Student Outcome 7: la capacidad de adquirir y aplicar nuevos conocimientos según sea necesario, utilizando estrategias de aprendizaje apropiadas.

| Criterio específico | Acciones realizadas | Conclusiones |
| :---- | :---- | :---- |
| 7.c1. Actualiza conceptos y conocimientos necesarios para su desarrollo profesional y, en especial, para su proyecto en soluciones de ingeniería de software. | \[Por integrante: nombres y apellidos, y las acciones realizadas en cada entrega relacionadas con el criterio.\] | \[Conclusión grupal, acumulable en cada entrega.\] |
| 7.c2. Reconoce la necesidad del aprendizaje permanente para el desempeño profesional y el desarrollo de proyectos en soluciones de ingeniería de software. | \[Por integrante: nombres y apellidos, y las acciones realizadas en cada entrega relacionadas con el criterio.\] | \[Conclusión grupal, acumulable en cada entrega.\] |

# 

# 

# **Capítulo I: Introducción**

## **1.1. Startup profile**

### **1.1.1. Descripción del startup**

DALERST es una startup peruana dedicada al desarrollo de software para empresas de distintos rubros. Su nombre nace de la combinación de los nombres de sus cuatro integrantes, estudiantes de Ingeniería de Software de la Universidad Nacional de Ingeniería (UNI), quienes la conformaron en 2026 en el marco de un proyecto académico con visión de empresa.  
La startup ofrece sus soluciones bajo el modelo de software como servicio (SaaS): el cliente accede a la plataforma desde la web, sin instalar ni mantener infraestructura propia, y paga una suscripción. Los productos de DALERST se construyen por módulos, de modo que cada empresa activa solo las funciones que su operación necesita y puede ampliarlas a medida que crece.  
El equipo parte de una idea simple: muchas empresas todavía gestionan procesos clave con hojas de cálculo, cuadernos y mensajes dispersos, y pierden tiempo y dinero por ello. DALERST busca reemplazar esa dispersión por sistemas ordenados, apoyados en bases de datos bien diseñadas, que den a cada empresa información confiable y a la mano.  
Su primer producto es Keel, una plataforma para la gestión de reparaciones y mantenimiento de embarcaciones. Keel es el punto de partida de la startup en el sector marítimo; su descripción detallada se desarrolla en la sección 1.2.  
**Misión.** Desarrollar software en la nube, modular y accesible, que ayude a las empresas a ordenar sus procesos y a decidir con información confiable, de manera que puedan operar con menos tiempo y recursos perdidos.  
**Visión.** Ser una empresa de software reconocida en el Perú y en América Latina por crear productos que simplifican la operación de las empresas, empezando por los sectores que hoy trabajan con herramientas poco integradas.  
**Valores.** Los valores que guían el trabajo de DALERST son los siguientes:

* **Rigor técnico:** diseñamos con criterio los datos y la arquitectura de cada solución.  
* **Modularidad:** cada cliente usa solo lo que necesita y puede crecer a su ritmo.  
* **Cercanía con el cliente:** partimos de entender cómo trabaja realmente cada empresa antes de proponer una solución.  
* **Mejora continua:** aprendemos de cada entrevista, de cada prueba y de cada error.

**Contexto.** DALERST se desarrolla como proyecto del curso Sistemas de Gestión de Base de Datos (SW609), del periodo 2026-2, a cargo del docente Mg. Richard Leonardo Berrocal Navarro. En este informe se presenta la primera entrega, que corresponde a la presentación del startup, la problemática y los segmentos objetivo.  
 

### **1.1.2. Perfiles de integrantes del equipo**

Los cuatro integrantes del equipo cursan Ingeniería de Software en la Universidad Nacional de Ingeniería, carrera que forma profesionales en el análisis, el diseño, la construcción y el mantenimiento de sistemas de software. A continuación se presenta el perfil de cada uno.

<p align="center"><img src="images/franz-nunez.png" alt="Franz Pool Nuñez Villazana" width="400"></p>
**Franz Pool Nuñez Villazana**

**Código:** 20244028F. Carrera: Ingeniería de Software (UNI).  
**Acerca de mí:** Estudiante de Ingeniería de Software (UNI) desde 2024, actualmente en el sexto ciclo. Interesado en manejo de datos y el desarrollo de aplicaciones web.  
<p align="center"><img src="images/roy-puris.png" alt="Roy Farid Puris Ricaldi" width="400"></p>
                                                    **Roy Farid Puris Ricaldi**

**Código:** 20244011F. Carrera: Ingeniería de Software (UNI).  
**Acerca de mí:** Estudiante de Ingeniería de Software de la UNI desde 2024, actualmente en el sexto ciclo. Participó en el ICPC y trabaja con algoritmos y estructuras de datos.   
<p align="center"><img src="images/lenin-castro.png" alt="Lenin Giomar Castro Aguirre" width="400"></p>
**Lenin Giomar Castro Aguirre**

**Código:** 20240243J. Carrera: Ingeniería de Software (UNI). Rol: Team Leader del equipo.  
**Acerca de mí:** Estudiante de Ingeniería de Software de la UNI desde 2024, actualmente en el sexto ciclo. Participó en el ICPC, interesado en el desarrollo de soluciones de software.

<p align="center"><img src="images/dair-ramos.png" alt="Dair David Ramos Jacay" width="368"></p>
**Dair David Ramos Jacay**  
**Código:** 20232156D. Carrera: Ingeniería de Software (UNI).  
**Acerca de mí:** Estudiante de Ingeniería de Software (UNI) desde 2023, actualmente en el sexto ciclo. Participó en el Regional ICPC y trabajó con algoritmos y estructuras de datos. Interesado en manejo de datos y el desarrollo de aplicaciones web.

**Conocimientos técnicos del equipo.** Los cuatro integrantes tienen una base sólida en algoritmos y estructuras de datos, y todos participaron en el ICPC (International Collegiate Programming Contest). Esta experiencia aporta al proyecto capacidad de análisis, rigor para razonar sobre el rendimiento de las soluciones y habilidad para modelar los datos de un sistema, algo central en un curso de bases de datos.  
 

## **1.2. Solution profile**

### **1.2.1. Antecedentes y problemática**

El Perú cuenta con una flota de embarcaciones numerosa y diversa. La Sociedad Nacional de Pesquería informó que 16 405 de las 18 211 embarcaciones pesqueras del país, es decir el 90 %, son artesanales o de menor escala (Proactivo, s. f.). En 2025, los puertos peruanos registraron 20 794 arribos y 20 952 zarpes de naves, un 11,5 % y un 12,2 % más que en 2024, y en la Amazonía operaron 4 251 naves de pasajeros y más de 1 800 embarcaciones de carga mixta (MundoMarítimo, 2026).  
La reparación y el mantenimiento de esa flota se atienden en astilleros y talleres de distinto tamaño. Los astilleros de los Servicios Industriales de la Marina (SIMA Perú), ubicados en Callao, Iquitos y Chimbote, realizan trabajos de recorrido y mantenimiento de embarcaciones nacionales e internacionales de los sectores naviero, portuario y pesquero (Andina, s. f.). Además, el sector se está modernizando: SIMA ha iniciado la ampliación de sus astilleros (Andina, s. f.) y se anuncian proyectos de construcción y reparación naval de mayor escala en el país (Perú Retail, 2024).  
En paralelo, la digitalización del mantenimiento naval es un tema de investigación actual. Un estudio de 2026 sobre el registro digital de la sala de máquinas observa que el registro manual produce datos duplicados, errores en la programación del mantenimiento y dificultades para controlar los repuestos disponibles (Robbi et al., 2026).  
Esto deja ver una brecha: la flota crece y los astilleros se modernizan, pero la gestión diaria de cada reparación (qué trabajos se hacen, quién los hace, con qué repuestos y en cuánto tiempo) suele apoyarse en registros manuales o en herramientas que no están conectadas entre sí.  
**Problema.** Las empresas que reparan y mantienen embarcaciones no pueden gestionar las reparaciones de manera idónea y, como consecuencia, pierden tiempo y recursos. Para delimitar la problemática se aplicó la técnica de las 5 W y 2 H:  
**Who (¿Quiénes?):**

* Astilleros y talleres de reparación naval, de gran, mediana y pequeña escala.  
* Jefes de taller y de proyecto, que deben planificar y controlar cada reparación.  
* Personal técnico y de almacén, que ejecuta los trabajos y administra los repuestos.  
* Gerencias, que necesitan información para decidir y para responder a sus clientes.  
* Armadores y dueños de embarcaciones, afectados de forma indirecta cuando su nave tarda más de lo previsto en volver a operar.

**What (¿Qué problema?):**

* No pueden manejar las reparaciones de manera adecuada, lo que provoca pérdida de tiempo y de recursos.  
* La información de cada embarcación, de sus trabajos y de su historial de mantenimiento está dispersa.  
* Los trabajos y el personal se planifican sin una visión completa de la carga de trabajo.  
* El control de repuestos y materiales es débil.

**Where (¿Dónde ocurre?):**

* En los procesos de gestión de embarcaciones dentro de los astilleros y talleres del país, como los de Callao, Chimbote e Iquitos (Andina, s. f.).  
* En las áreas de taller, almacén y oficina técnica, donde la información debe fluir entre varias personas.

**When (¿Cuándo ocurre?):**

* Cuando una embarcación ingresa y se estiman trabajos, tiempos y costos.  
* Durante la ejecución de la reparación, sobre todo cuando se atienden varias embarcaciones a la vez.  
* Al programar el mantenimiento preventivo y al entregar la embarcación terminada.

**Why (¿Por qué ocurre?):**

* La información no está reunida en un solo sistema y se registra de forma manual, lo que genera duplicados y errores (Robbi et al., 2026).  
* Cada empresa trabaja de manera distinta y las herramientas genéricas no se adaptan a su forma de operar.  
* Las empresas pequeñas y medianas, que son mayoría en la flota (Proactivo, s. f.), tienen pocos recursos para adoptar sistemas costosos.

**How (¿Cómo se presenta?):**

* Retrasos en la entrega de las embarcaciones y dificultad para estimar tiempos.  
* Repuestos que faltan en el momento justo o que se compran de más.  
* Reprocesos y trabajos repetidos por falta de trazabilidad.  
* Personal con poca carga en unos momentos y sobrecargado en otros.

**How much (¿Qué impacto tiene?):**

* Más días de embarcación detenida, horas de personal sin uso productivo y repuestos comprados o almacenados sin control, lo que se traduce en pérdida de tiempo y de dinero para la empresa y para sus clientes.  
* La escala de la flota (18 211 embarcaciones pesqueras y más de 20 000 arribos de naves en 2025\) indica que el problema afecta a un mercado amplio (Proactivo, s. f.; MundoMarítimo, 2026).  
* El costo exacto de cada reparación mal gestionada se medirá con las entrevistas del Capítulo II.

**Problemática.** Las empresas de reparación y mantenimiento naval atienden una flota grande sin una herramienta que integre la gestión de sus reparaciones. Esto alarga los tiempos de entrega, aumenta los costos y desperdicia el trabajo y los materiales disponibles. DALERST propone resolverlo con un sistema que ordene esa gestión en un solo lugar.  
 

### **1.2.2. Propuesta de valor**

**Problema a resolver.** Las empresas que reparan y mantienen embarcaciones no gestionan sus reparaciones de forma adecuada y, por ello, pierden tiempo y recursos.  
**Propuesta.** Keel es el primer producto de DALERST: un software como servicio (SaaS) que centraliza la gestión de las reparaciones y del mantenimiento de embarcaciones de todo tipo, es decir, de cualquier nave del ámbito marítimo. Como cada empresa trabaja de manera distinta, Keel es modular: cada cliente contrata y usa solo las funciones que necesita. El nombre hace referencia a la quilla (keel, en inglés), la pieza central del casco de una nave: Keel busca ser la base sobre la que se organiza la operación de un astillero o de un taller naval.  
**Hipótesis Lean UX**

* Creemos que las empresas que reparan y mantienen embarcaciones, en especial las pequeñas y medianas, necesitan una plataforma que reúna la información de sus reparaciones y les permita planificar y controlar su trabajo.  
* Creemos que, al implementar un sistema modular como Keel, con registro de embarcaciones, órdenes de trabajo, control de personal y de repuestos, estas empresas reducirán sus retrasos y aprovecharán mejor sus recursos.  
* Sabremos que esto es cierto cuando las empresas que prueben Keel registren menos retrasos en las entregas, menos faltantes o excesos de repuestos y un uso constante de la plataforma en su trabajo diario.

**Lean UX Canvas**  
**1\. Problema de negocio.** Las empresas de reparación naval no gestionan bien sus reparaciones: la información está dispersa, la planificación es débil y el control de repuestos es deficiente, lo que genera pérdida de tiempo y de recursos.  
**2\. Resultados comerciales.** Conseguir las primeras empresas suscritas, lograr un uso constante de la plataforma, validar qué módulos son los más valorados y posicionar a Keel como una herramienta accesible para el sector marítimo.  
**3\. Usuarios y clientes.** Astilleros, talleres de reparación y empresas de mantenimiento naval. Dentro de ellos, usan la plataforma la gerencia, los jefes de taller o de proyecto, los técnicos y el personal de almacén.  
**4\. Beneficios del usuario.** Tener la información de cada embarcación y de cada trabajo en un solo lugar, planificar mejor las reparaciones, perder menos tiempo y recursos, y pagar solo por los módulos que usa.  
**5\. Ideas de soluciones.** Plataforma web modular que puede incluir los siguientes módulos:

* Registro de embarcaciones y de su historial de mantenimiento.  
* Órdenes de trabajo y seguimiento del estado de cada reparación.  
* Planificación y asignación del personal técnico.  
* Almacén y control de repuestos y materiales.  
* Mantenimiento preventivo con alertas y calendario.  
* Reportes e indicadores para la gerencia.

**6\. Hipótesis.** Si las empresas centralizan sus reparaciones en Keel, entonces reducirán los retrasos y el desperdicio de repuestos, porque tendrán visibilidad de todo el proceso en un solo lugar.  
**7\. Lo más importante que se necesita aprender primero.** Qué procesos de la reparación son los que más tiempo hacen perder, qué herramientas usan hoy las empresas, qué módulos estarían dispuestas a pagar y si la modalidad por suscripción les resulta viable.  
**8\. Menor cantidad de trabajo para resolver las dudas.** Entrevistar a empresas de reparación naval de cada segmento (Capítulo II) y construir un prototipo básico con registro de embarcaciones, órdenes de trabajo y control de repuestos para validar su utilidad.  
<p align="left"><img src="images/lean-ux-canvas-keel.png" alt="Lean UX Canvas de Keel" width="624"></p>
 

## **1.3. Segmentos objetivo**

Keel se dirige a las empresas que reparan y mantienen embarcaciones. Se distinguen segmentos primarios y secundarios según el tamaño y el tipo de operación de la empresa. Las fuentes consultadas no publican un registro consolidado de empresas de reparación naval; por ello, el tamaño de cada segmento se estima a partir de la flota que atiende y se afinará con las entrevistas del Capítulo II.  
**Segmentos primarios**  
**Astilleros de gran escala.** Empresas con instalaciones y proyectos de gran envergadura, como SIMA Perú, que opera astilleros en Callao, Iquitos y Chimbote (Andina, s. f.). La Armada del Perú planea la renovación de 23 buques en los próximos años (Revista Economía, s. f.), y SIMA desarrolla un proyecto para ampliar su capacidad de reparación con un nuevo dique seco (Perú Retail, 2024). Gestionan muchos trabajos a la vez, por lo que necesitan control de personal, de almacén y de plazos.  
**Astilleros y talleres medianos y pequeños de la costa.** Atienden principalmente a embarcaciones pesqueras. La flota pesquera del país suma 18 211 embarcaciones, de las cuales 16 405 (90 %) son artesanales o de menor escala (Proactivo, s. f.). Son empresas de menor tamaño, con procesos más manuales y poco presupuesto, para las que un servicio modular y por suscripción es una alternativa adecuada.  
**Talleres y empresas de mantenimiento fluvial de la Amazonía.** Atienden el transporte de personas y de carga por los ríos amazónicos. En 2025 operaron en esa región 4 251 naves de pasajeros y más de 1 800 embarcaciones de carga mixta (MundoMarítimo, 2026), y SIMA cuenta con un astillero en Iquitos (Andina, s. f.). Dependen de que las embarcaciones vuelvan a operar con rapidez, pues son un medio de transporte clave en la región.  
**Segmentos secundarios**  
**Empresas navieras, pesqueras y de transporte con flota propia.** Algunas cuentan con áreas internas de mantenimiento que también necesitan registrar el historial de sus embarcaciones y programar el mantenimiento preventivo.  
**Armadores y propietarios de embarcaciones.** No usan Keel para gestionar reparaciones, pero se benefician al recibir información más clara sobre el estado y los plazos de sus naves.  
**Criterio de priorización.** Por la facilidad de acceso y por el tamaño de la flota atendida, el equipo prioriza como primer público a los astilleros y talleres medianos y pequeños, y usará los otros segmentos para validar y ampliar la plataforma.  
 

# **Capítulo II: Recopilación y análisis de requisitos**

## **2.1. Entrevistas**

### **2.1.1. Diseño de entrevistas**

*\[Preguntas principales y complementarias por segmento. Deben permitir identificar las entidades necesarias para la base de datos.\]*  
 

### **2.1.2. Registro de entrevistas**

*\[Por segmento, 1 a 2 entrevistas. Por entrevista: nombres, apellidos, edad, distrito, captura del video, URL de YouTube con el minuto de inicio y la duración, y un resumen de las respuestas.\]*  
 

### **2.1.3. Análisis de entrevistas**

*\[Análisis por segmento con porcentajes, que muestre características objetivas y subjetivas, relacionadas con las entrevistas registradas.\]*  
 

## **2.2. Requisitos**

*\[Lista de requisitos funcionales, por ejemplo como historias de usuario.\]*  
 

# **Capítulo III: Diseño de base de datos**

## **3.1. Entidades**

*\[Mínimo 10 entidades, cada una con su descripción.\]*  
 

## **3.2. Atributos**

*\[Atributos principales de cada entidad, con descripción.\]*  
 

## **3.3. Enfoque relacional**

### **3.3.1. Diagrama entidad-relación lógico**

*\[Diagrama con entidades, atributos, relaciones y cardinalidades.\]*  
 

## **3.4. Enfoque no relacional (TF1)**

### **3.4.1. Colecciones**

 

### **3.4.2. Validación de esquema**

 

### **3.4.3. Patrones de modelo de datos**

 

# **Capítulo IV: Implementación de base de datos**

## **4.1. Sistema de gestión de base de datos**

### **4.1.1. Evaluación y elección del sistema de gestión de base de datos relacional**

*\[Comparar MySQL, SQL Server y Oracle según escalabilidad, rendimiento y compatibilidad. Incluir evidencia de la implementación del sistema elegido.\]*  
 

### **4.1.2. Evaluación y elección del sistema de gestión de base de datos no relacional (TF1)**

 

## **4.2. Diagramas de datos**

### **4.2.1. Diagrama entidad-relación físico**

*\[Diagrama hecho con la extensión ERD Editor de Visual Studio Code: tablas, columnas, claves primarias y foráneas, restricciones.\]*  
 

### **4.2.2. Diagrama de documentos (TF1)**

 

## **4.3. Scripts de creación de la base de datos (TF1)**

### **4.3.1. Scripts de creación y carga de datos de la base de datos relacional**

 

### **4.3.2. Scripts de creación y carga de datos de la base de datos no relacional**

 

## **4.4. Consultas (TF1)**

### **4.4.1. Consultas para la base de datos relacional**

 

### **4.4.2. Consultas para la base de datos no relacional**

 

# **Conclusiones**

## **Conclusiones y recomendaciones**

 

## **Video About-the-Team**

*\[Resumen, pauta de secuencias con minutos de inicio (hh:mm:ss), un cuadro representativo y la URL de YouTube.\]*  
 

# **Bibliografía**

Andina. (s. f.). Sima Perú inició proceso de modernización y ampliación de sus astilleros. https\://andina.pe/agencia/noticia-sima-peru-inicio-proceso-modernizacion-y-ampliacion-sus-astilleros-869295.aspx  
MundoMarítimo. (2026, 11 de marzo). Puertos de Perú registran más de 20.000 arribos y zarpes de naves en 2025\. https\://www\.mundomaritimo.cl/noticias/editor/55585  
Perú Retail. (2024, 12 de junio). Hyundai, el mayor astillero del mundo, construirá embarcaciones en Perú. https\://www\.peru-retail.com/hyundai-el-mayor-astillero-del-mundo-construira-embarcaciones-en-peru/  
Proactivo. (s. f.). SNP: El 90 % de la flota pesquera peruana es artesanal y de menor escala. https\://proactivo.com.pe/snp-el-90-de-la-flota-pesquera-peruana-es-artesanal-y-de-menor-escala/  
Revista Economía. (s. f.). Expansión naval: Compiten gigantes Hyundai y Fincantieri como astilleros. https\://www\.revistaeconomia.com/?p=59482  
Robbi, S. D., Kristiyono, A. E., Prawoto, A., Evrianto, H. A., Cahyaningtyas, C. K. D., & Nasution, F. (2026). Digitization of the engine room logbook to optimize the planned maintenance system (PMS) and ship inventory control. International Journal of Marine Engineering Innovation and Research, 11(3), 966–972. https\://journal.its.ac.id/index.php/ijmeir/article/view/10010  
 

# **Anexos**

## **Anexo A. Videos de exposiciones**

*\[Enlace del video de cada entrega, indicando a qué entrega corresponde.\]*
