/* ==========================================
   ARCHIVO: 01_tablas.sql
   DESCRIPCIÓN: Creación de tablas con correcciones de edad y constraints.
   CAMBIOS REALIZADOS DEL DOC
   ========================================== */

-- 1. TABLAS DE UBICACIÓN
CREATE TABLE PAISES (
    id              NUMBER(3) NOT NULL,
    nombre          VARCHAR2(25) NOT NULL UNIQUE,
    continente      VARCHAR2(2) NOT NULL,
    nacionalidad    VARCHAR2(15) NOT NULL,
    ue              VARCHAR2(1) NOT NULL,
    CONSTRAINT PK_PAIS PRIMARY KEY (id),
    CONSTRAINT CK_CONTINENTE CHECK (continente IN ('AM','EU','OC','AS','AF')),
    CONSTRAINT CK_UE CHECK (ue IN ('S','N'))
);

CREATE TABLE ESTADOS (
    id_pais         NUMBER(3) NOT NULL,
    id_estado       NUMBER(5) NOT NULL,
    nombre          VARCHAR2(25) NOT NULL,
    CONSTRAINT PK_ESTADOS PRIMARY KEY (id_pais, id_estado),
    CONSTRAINT FK_ESTADOS_PAIS FOREIGN KEY (id_pais) REFERENCES PAISES (id)
);

CREATE TABLE CIUDADES (
    id_pais         NUMBER(3) NOT NULL,
    id_estado       NUMBER(5) NOT NULL,
    id_ciudad       NUMBER(5) NOT NULL,
    nombre          VARCHAR2(25) NOT NULL,
    CONSTRAINT PK_CIUDADES PRIMARY KEY (id_pais, id_estado, id_ciudad),
    CONSTRAINT FK_CIUDADES_ESTADO FOREIGN KEY (id_pais, id_estado) 
        REFERENCES ESTADOS (id_pais, id_estado)
);

-- 2. PERSONAS (CLIENTES Y VISITANTE_MENORES)

CREATE TABLE CLIENTES (
    id_lego             NUMBER(6)   NOT NULL,
    primer_nombre       VARCHAR2(20) NOT NULL,
    primer_apellido     VARCHAR2(20) NOT NULL,
    segundo_apellido    VARCHAR2(20) NOT NULL,
    email               VARCHAR2(30) NOT NULL UNIQUE,
    fecha_nacimiento    DATE NOT NULL,
    id_pais_res         NUMBER(3) NOT NULL,
    id_pais_nac         NUMBER(3) NOT NULL,
    segundo_nombre      VARCHAR2(20),
    doc_identidad       VARCHAR2(10) UNIQUE,
    pasaporte           VARCHAR2(16),
    fecha_venc_pasa     DATE,
    CONSTRAINT CK_DNI CHECK((doc_identidad IS NULL AND pasaporte IS NOT NULL) OR (doc_identidad IS NOT NULL AND pasaporte IS NULL)),
    CONSTRAINT PK_CLIENTES PRIMARY KEY (id_lego),
    CONSTRAINT FK_CLIENTE_PAIS_RES FOREIGN KEY (id_pais_res) REFERENCES PAISES (id),
    CONSTRAINT FK_CLIENTE_PAIS_NAC FOREIGN KEY (id_pais_nac) REFERENCES PAISES (id)
);

CREATE TABLE VISITANTE_MENORES (
    id_lego             NUMBER(6) NOT NULL,
    primer_nombre       VARCHAR2(20) NOT NULL,
    primer_apellido     VARCHAR2(20) NOT NULL,
    segundo_apellido    VARCHAR2(20) NOT NULL,
    doc_identidad       VARCHAR2(10) NOT NULL UNIQUE,
    fecha_nacimiento    DATE NOT NULL,
    pasaporte           VARCHAR2(10) NOT NULL,
    id_pais_nac         NUMBER(3) NOT NULL,
    id_cliente_repres   NUMBER(6), -- Puede ser nulo si es mayor de 18
    segundo_nombre      VARCHAR2(20),
    fecha_venc_pasa     DATE,
    CONSTRAINT PK_VISITANTE_MENORES PRIMARY KEY (id_lego),
    CONSTRAINT FK_VISITANTE_PAIS FOREIGN KEY (id_pais_nac) REFERENCES PAISES (id),
    CONSTRAINT FK_VISITANTE_REPRES FOREIGN KEY (id_cliente_repres) REFERENCES CLIENTES (id_lego)
);

-- 3. PRODUCTOS Y CATÁLOGO
CREATE TABLE JUGUETES_LEGO (
    id              NUMBER(4) NOT NULL,
    nombre          VARCHAR2(40) NOT NULL UNIQUE,
    descripcion     VARCHAR2(250) NOT NULL,
    rango_edad      VARCHAR2(20) NOT NULL,
    rango_precio    VARCHAR2(20) NOT NULL,
    j_set           VARCHAR2(1) NOT NULL,
    set_detalle     NUMBER(4), --Puede ser nulo
    instrucciones   VARCHAR2(3000), --Puede ser nulo
    nro_piezas      NUMBER(4),
    CONSTRAINT PK_PRODUCTOS PRIMARY KEY (id),
    CONSTRAINT FK_PROD_SET_DETALLE FOREIGN KEY (set_detalle) REFERENCES JUGUETES_LEGO (id),
    CONSTRAINT CK_SET CHECK (j_set IN ('S','N')),
    CONSTRAINT CK_RANGO_EDAD check (rango_edad IN ('0 A 2','3 A 4','5 A 6','7 A 8','9 A 11','12P','ADULTOS')),
    CONSTRAINT CK_RANGO_PRECIO check (rango_precio IN ('A','B','C','D'))
);

CREATE TABLE CATALOGO_PAISES (
    id_pais         NUMBER(3) NOT NULL,
    id_juguete_lego NUMBER(4) NOT NULL,
    limite_compra   NUMBER(2) NOT NULL,
    CONSTRAINT PK_CATALOGO_PAIS PRIMARY KEY (id_pais,id_juguete_lego),
    CONSTRAINT FK_CATALOGO_PAIS FOREIGN KEY (id_pais) REFERENCES PAISES (id),
    CONSTRAINT FK_CATALOGO_PROD FOREIGN KEY (id_juguete_lego) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE HIST_PRECIOS (
    id_juguete     NUMBER(4) NOT NULL,
    fecha_inicio    DATE NOT NULL,
    fecha_fin       DATE,
    precio          NUMBER(10, 2) NOT NULL,
    CONSTRAINT PK_HIST_PRECIOS PRIMARY KEY (id_juguete, fecha_inicio),
    CONSTRAINT FK_HIST_PROD FOREIGN KEY (id_juguete) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE PRODUCTOS_RELACION (
    id_juguete_a   NUMBER NOT NULL,
    id_juguete_b   NUMBER NOT NULL,
    CONSTRAINT PK_PROD_RELACION PRIMARY KEY (id_juguete_a, id_juguete_b),
    CONSTRAINT FK_REL_PROD_A FOREIGN KEY (id_juguete_a) REFERENCES JUGUETES_LEGO (id),
    CONSTRAINT FK_REL_PROD_B FOREIGN KEY (id_juguete_b) REFERENCES JUGUETES_LEGO (id)
);

-- 4. TEMAS Y TOURS
CREATE TABLE TEMAS (
    id                  NUMBER(2) NOT NULL,
    nombre              VARCHAR2(20) NOT NULL,
    descripcion         VARCHAR2(250) NOT NULL,
    tipo                VARCHAR2(1) NOT NULL,
    id_tema_principal   NUMBER(2),
    CONSTRAINT PK_TEMAS PRIMARY KEY (id),
    CONSTRAINT UQ_TEMAS_NOMBRE UNIQUE (nombre), 
    CONSTRAINT CK_TIPO_TEMA CHECK (tipo IN ('T','S')),--(T = Tema) y( S = Serie)
    CONSTRAINT FK_TEMAS_RECURSIVA FOREIGN KEY (id_tema_principal) REFERENCES TEMAS (id)
);

CREATE TABLE TEMAS_JUGUETES (
    id_tema    NUMBER(2) NOT NULL,
    id_juguete NUMBER(4) NOT NULL,
    CONSTRAINT PK_TEMAS_PRODUCTOS PRIMARY KEY (id_tema, id_juguete),
    CONSTRAINT FK_TP_TEMA FOREIGN KEY (id_tema) REFERENCES TEMAS (id),
    CONSTRAINT FK_TP_JUG FOREIGN KEY (id_juguete) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE TOURS (
    fecha_inicio        DATE  NOT NULL,
    precio_por_persona  NUMBER(10, 2) NOT NULL,
    capacidad_maxima    NUMBER(2) NOT NULL,
    regala_producto     VARCHAR2(1) NOT NULL,
    descripcion_producto VARCHAR2(250),
    CONSTRAINT PK_TOURS PRIMARY KEY (fecha_inicio),
    CONSTRAINT CK_REGALA CHECK (regala_producto IN ('S', 'N'))
);

CREATE TABLE INSCRIPCIONES (
    fecha_tour      DATE NOT NULL,
    numero          NUMBER(6) NOT NULL,
    fecha           DATE NOT NULL,
    costo_total     NUMBER(10,2) NOT NULL,
    status          VARCHAR2(9) NOT NULL, 
    CONSTRAINT PK_INSCRIPCION PRIMARY KEY (fecha_tour, numero),
    CONSTRAINT FK_INSCRIPCION_TOUR FOREIGN KEY (fecha_tour) REFERENCES TOURS (fecha_inicio)
);

CREATE TABLE INSCRITOS (
    fecha_tour_inscrito DATE NOT NULL,
    nro_inscripcion     NUMBER(6) NOT NULL,
    id                  NUMBER(4) NOT NULL,
    id_visitante_lego   NUMBER(6),             
    id_cliente_lego     NUMBER(6),             
    
    CONSTRAINT PK_INSCRITOS PRIMARY KEY (fecha_tour_inscrito, nro_inscripcion, id),
    CONSTRAINT CK_ARCO_PARTICIPANTE CHECK((id_visitante_lego IS NULL AND id_cliente_lego IS NOT NULL) OR (id_visitante_lego IS NOT NULL AND id_cliente_lego IS NULL)),
    CONSTRAINT FK_INSCRITOS_INSCRIP FOREIGN KEY (fecha_tour_inscrito, nro_inscripcion) REFERENCES INSCRIPCIONES (fecha_tour, numero),
    CONSTRAINT FK_INSCRITOS_VISIT FOREIGN KEY (id_visitante_lego) REFERENCES VISITANTE_MENORES (id_lego),
    CONSTRAINT FK_INSCRITOS_CLIENTE FOREIGN KEY (id_cliente_lego) REFERENCES CLIENTES (id_lego)
);

CREATE TABLE ENTRADAS (
    fecha_tour_ins DATE NOT NULL,
    nro_inscripcion_tour NUMBER(6) NOT NULL,
    id              NUMBER(6) NOT NULL,
    tipo_cliente    VARCHAR2(1) NOT NULL,
    CONSTRAINT CK_TIPO_CLIENTE_ENTRADA CHECK (tipo_cliente IN ('A', 'N')), --‘A’ significa ADULTO, ‘N’ significa NINO
    CONSTRAINT PK_ENTRADAS PRIMARY KEY (fecha_tour_ins,nro_inscripcion_tour, id),
    CONSTRAINT FK_ENTRADAS_INSCRIP FOREIGN KEY (fecha_tour_ins,nro_inscripcion_tour) REFERENCES INSCRIPCIONES (fecha_tour,numero)
);

CREATE TABLE TIENDAS (
    id              NUMBER(4) NOT NULL,
    nombre          VARCHAR2(25) NOT NULL UNIQUE,
    nro_telefono    VARCHAR2(20) NOT NULL,
    direccion       VARCHAR2(200) NOT NULL,
    id_pais         NUMBER(3) NOT NULL,
    id_estado       NUMBER(5) NOT NULL,
    id_ciudad       NUMBER(5) NOT NULL,
    CONSTRAINT PK_TIENDAS PRIMARY KEY (id),
    CONSTRAINT FK_TIENDAS_CIUDAD FOREIGN KEY (id_pais, id_estado, id_ciudad) REFERENCES CIUDADES (id_pais, id_estado, id)
);

CREATE TABLE HORARIOS (
    id_tienda_ap    NUMBER(4) NOT NULL,
    dia_semana      NUMBER(1) NOT NULL,
    hora_apertura   DATE NOT NULL,
    hora_cierre     DATE NOT NULL,
    CONSTRAINT PK_HORARIOS PRIMARY KEY (id_tienda_ap,dia_semana),
    CONSTRAINT FK_HORARIOS_TIENDA FOREIGN KEY (id_tienda_ap) REFERENCES TIENDAS (id)
);

-- 6. FACTURACIÓN E INVENTARIO
CREATE TABLE FACTURAS_TIENDA (
    nro_factura     NUMBER(6) NOT NULL,
    id_tienda       NUMBER(4) NOT NULL,
    total           NUMBER(10, 2) NOT NULL,
    fecha_emision   DATE NOT NULL,
    id_cliente_lego NUMBER(6) NOT NULL,
    CONSTRAINT PK_FACTURAS_TIENDA PRIMARY KEY (nro_factura,id_tienda),
    CONSTRAINT FK_FACT_TIENDA FOREIGN KEY (id_tienda) REFERENCES TIENDAS (id),
    CONSTRAINT FK_FACT_CLIENTE FOREIGN KEY (id_cliente_lego) REFERENCES CLIENTES (id_lego)
);


CREATE TABLE DETALLES_FACTURA_TIENDA (
    nro_factura_t   NUMBER(6) NOT NULL,
    id_tienda_c     NUMBER(4) NOT NULL,
    id              NUMBER(6) NOT NULL,
    cantidad        NUMBER(2) NOT NULL,
    tipo_cliente    VARCHAR2(2) CHECK (tipo_cliente IN ('A', 'N')) NOT NULL,

--// ‘A’ significa ADULTO, ‘N’ significa NINO

    CONSTRAINT PK_DETALLES_FACTURA_TIENDA PRIMARY KEY (nro_factura_t,id_tienda_c, id),
    CONSTRAINT FK_DET_FACTURA FOREIGN KEY (nro_factura_t,id_tienda_c) REFERENCES FACTURAS_TIENDA (nro_factura,id_tienda)
);

CREATE TABLE LOTES_INVENTARIO (
    id_tienda       NUMBER(4) NOT NULL,
    id_juguete     NUMBER(4) NOT NULL,
    id_lote         NUMBER(4) NOT NULL,
    cantidad        NUMBER(2) NOT NULL,
    CONSTRAINT CK_CANT CHECK(cantidad >= 0),
    CONSTRAINT PK_LOTES PRIMARY KEY (id_tienda,id_juguete,id_lote),
    CONSTRAINT FK_LOTES_TIENDA FOREIGN KEY (id_tienda) REFERENCES TIENDAS (id),
    CONSTRAINT FK_LOTES_PROD FOREIGN KEY (id_juguete) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE DESCUENTO_L_INVENTARIO (
    id_tienda       NUMBER(4) NOT NULL,
    id_juguete     NUMBER(4) NOT NULL,
    id_lote         NUMBER(4) NOT NULL,
    id              NUMBER(4) NOT NULL,
    fecha           DATE NOT NULL,
    cant_descontar  NUMBER(2) NOT NULL,
    CONSTRAINT PK_DESC_INVENTARIO PRIMARY KEY (id_tienda ,id_juguete,id_lote ,id),
    CONSTRAINT FK_DESC_LOTE_COMPLETO FOREIGN KEY (id_tienda, id_juguete, id_lote) 
        REFERENCES LOTES_INVENTARIO (id_tienda, id_juguete, id_lote)
);

CREATE TABLE FACTURAS_ONLINE (
    numero_venta     number(7) NOT NULL,
    fecha_venta     DATE NOT NULL,
    gratis          VARCHAR2(1) NOT NULL,
    id_lego_cliente NUMBER(6) NOT NULL,
    total           NUMBER(4,2) NOT NULL,
    puntos_generados NUMBER(3) NOT NULL,
    CONSTRAINT PK_FACTURAS_ONLINE PRIMARY KEY(numero_venta),
    CONSTRAINT CK_GRATIS check (gratis IN ('S','N')),
    CONSTRAINT FK_FACTURA_ONLINE_CLIENTE FOREIGN KEY (id_lego_cliente) REFERENCES Clientes (id_lego)
);

CREATE TABLE DET_FACTURAS_ONLINE (
    numeroventa     NUMBER(7) NOT NULL,
    id              NUMBER(2) NOT NULL,
    cantidad        NUMBER(2) NOT NULL,
    tipo_cliente    VARCHAR2(1) NOT NULL,
    id_juguete_cat  NUMBER(4) NOT NULL,
    id_pais_cat     NUMBER(3) NOT NULL,
    CONSTRAINT CK_TIPO_CLIENTE_DETALLE_ONLINE CHECK (tipo_cliente IN ('A','J','M')), --ADULTO,JOVEN O MENOR
    CONSTRAINT FK_DETALLE_ONLINE_FACTURA_ONLINE FOREIGN KEY (numeroventa) REFERENCES FACTURAS_ONLINE (numero_venta),
    CONSTRAINT FK_DETALLE_ONLINE_CATALOGO_PAISES FOREIGN KEY (id_pais_cat,id_juguete_cat) REFERENCES CATALOGO_PAISES (id_pais,id_juguete_lego),
    CONSTRAINT PK_DETALLE_FACTURA_VENTAS_ONLINE PRIMARY KEY (numeroventa,id)
);


























/* ==========================================


   DESCRIPCIÓN: COPIA DEL PRIMER COMMIT PORCIA  IMPORTANTE 


   ========================================== */

-- 1. TABLAS DE UBICACIÓN
CREATE TABLE PAIS (
    id              NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nombre          VARCHAR2(100) NOT NULL,
    continente      VARCHAR2(50) NOT NULL,
    nacionalidad    VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_PAIS PRIMARY KEY (id),
    CONSTRAINT UQ_PAIS_NOMBRE UNIQUE (nombre)
);

CREATE TABLE ESTADOS (
    id_pais         NUMBER NOT NULL,
    id              NUMBER NOT NULL,
    nombre          VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_ESTADOS PRIMARY KEY (id_pais, id),
    CONSTRAINT FK_ESTADOS_PAIS FOREIGN KEY (id_pais) REFERENCES PAIS (id)
);

CREATE TABLE CIUDADES (
    id_pais         NUMBER NOT NULL,
    id_estado       NUMBER NOT NULL,
    id              NUMBER NOT NULL,
    nombre          VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_CIUDADES PRIMARY KEY (id_pais, id_estado, id),
    CONSTRAINT FK_CIUDADES_ESTADO FOREIGN KEY (id_pais, id_estado) 
        REFERENCES ESTADOS (id_pais, id)
);

-- 2. PERSONAS (CLIENTES Y VISITANTE_MENORES)

CREATE TABLE CLIENTES (
    id_lego             NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    primer_nombre       VARCHAR2(100) NOT NULL,
    segundo_nombre      VARCHAR2(100),
    primer_apellido     VARCHAR2(100) NOT NULL,
    segundo_apellido    VARCHAR2(100),
    email               VARCHAR2(150) NOT NULL,
    doc_identidad       VARCHAR2(50) NOT NULL,
    fecha_venc_pasa     DATE,
    fecha_nacimiento    DATE NOT NULL,
    id_pais_res         NUMBER NOT NULL,
    id_pais_nac         NUMBER NOT NULL,
    CONSTRAINT PK_CLIENTES PRIMARY KEY (id_lego),
    CONSTRAINT UQ_CLIENTES_EMAIL UNIQUE (email),
    CONSTRAINT UQ_CLIENTES_DOC UNIQUE (doc_identidad),
    CONSTRAINT FK_CLIENTE_PAIS_RES FOREIGN KEY (id_pais_res) REFERENCES PAIS (id),
    CONSTRAINT FK_CLIENTE_PAIS_NAC FOREIGN KEY (id_pais_nac) REFERENCES PAIS (id)
);

CREATE TABLE VISITANTE_MENORES (
    id_lego             NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    primer_nombre       VARCHAR2(100) NOT NULL,
    segundo_nombre      VARCHAR2(100),
    primer_apellido     VARCHAR2(100) NOT NULL,
    segundo_apellido    VARCHAR2(100),
    doc_identidad       VARCHAR2(50) NOT NULL,
    fecha_venc_pasa     DATE,
    fecha_nacimiento    DATE NOT NULL,
    id_pais_nac         NUMBER NOT NULL,
    id_cliente_repres   NUMBER, -- Puede ser nulo si es mayor de 18
    CONSTRAINT PK_VISITANTE_MENORES PRIMARY KEY (id_lego),
    CONSTRAINT UQ_VISITANTE_MENORES_DOC UNIQUE (doc_identidad),
    CONSTRAINT FK_VISITANTE_PAIS FOREIGN KEY (id_pais_nac) REFERENCES PAIS (id),
    CONSTRAINT FK_VISITANTE_REPRES FOREIGN KEY (id_cliente_repres) REFERENCES CLIENTES (id_lego)
);

-- 3. PRODUCTOS Y CATÁLOGO
CREATE TABLE JUGUETES_LEGO (
    id              NUMBER(4) NOT NULL,
    nombre          VARCHAR2(150) NOT NULL,
    nro_piezas      NUMBER,
    descripcion     VARCHAR2(4000),
    instrucciones   VARCHAR2(255),
    rango_edad      VARCHAR2(50),
    rango_precio    VARCHAR2(50),
    j_set           CHAR(2) CHECK (j_set IN ('SI', 'NO')),
    set_detalle     NUMBER,
    CONSTRAINT PK_PRODUCTOS PRIMARY KEY (id),
    CONSTRAINT UQ_PRODUCTOS_NOMBRE UNIQUE (nombre),
    CONSTRAINT FK_PROD_SET_DETALLE FOREIGN KEY (set_detalle) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE CATALOGO_PAIS (
    id_pais         NUMBER NOT NULL,
    limite_compra   NUMBER NOT NULL,
    id_juguete_lego NUMBER NOT NULL,
    CONSTRAINT PK_CATALOGO_PAIS PRIMARY KEY (id_pais),
    CONSTRAINT FK_CATALOGO_PAIS FOREIGN KEY (id_pais) REFERENCES PAIS (id),
    CONSTRAINT FK_CATALOGO_PROD FOREIGN KEY (id_juguete_lego) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE HIST_PRECIOS (
    id_juguete     NUMBER NOT NULL,
    fecha_inicio    DATE NOT NULL,
    fecha_fin       DATE,
    precio          NUMBER(10, 2) NOT NULL,
    CONSTRAINT PK_HIST_PRECIOS PRIMARY KEY (id_juguete, fecha_inicio),
    CONSTRAINT FK_HIST_PROD FOREIGN KEY (id_juguete) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE PRODUCTOS_RELACION (
    id_juguete_a   NUMBER NOT NULL,
    id_juguete_b   NUMBER NOT NULL,
    CONSTRAINT PK_PROD_RELACION PRIMARY KEY (id_juguete_a, id_juguete_b),
    CONSTRAINT FK_REL_PROD_A FOREIGN KEY (id_juguete_a) REFERENCES JUGUETES_LEGO (id),
    CONSTRAINT FK_REL_PROD_B FOREIGN KEY (id_juguete_b) REFERENCES JUGUETES_LEGO (id)
);

-- 4. TEMAS Y TOURS
CREATE TABLE TEMAS (
    id                  NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nombre              VARCHAR2(100) NOT NULL,
    descripcion         VARCHAR2(4000) NOT NULL,
    tipo                VARCHAR2(20) CHECK (tipo IN ('TEMA', 'SERIE')) NOT NULL,
    id_tema_principal   NUMBER,
    CONSTRAINT PK_TEMAS PRIMARY KEY (id),
    CONSTRAINT UQ_TEMAS_NOMBRE UNIQUE (nombre),
    CONSTRAINT FK_TEMAS_RECURSIVA FOREIGN KEY (id_tema_principal) REFERENCES TEMAS (id)
);

CREATE TABLE TEMAS_PRODUCTOS (
    id_tema     NUMBER NOT NULL,
    id_juguete NUMBER NOT NULL,
    CONSTRAINT PK_TEMAS_PRODUCTOS PRIMARY KEY (id_tema, id_juguete),
    CONSTRAINT FK_TP_TEMA FOREIGN KEY (id_tema) REFERENCES TEMAS (id),
    CONSTRAINT FK_TP_PROD FOREIGN KEY (id_juguete) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE TOURS (
    id                  NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    fecha_inicio        DATE NOT NULL,
    precio_por_persona  NUMBER(10, 2) NOT NULL,
    capacidad_maxima    NUMBER NOT NULL,
    regala_producto     CHAR(2) CHECK (regala_producto IN ('SI', 'NO')) NOT NULL,
    descripcion_producto VARCHAR2(4000),
    CONSTRAINT PK_TOURS PRIMARY KEY (id)
);

-- 5. OPERACIONES
CREATE TABLE INSCRIPCION (
    numero          NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    fecha           DATE NOT NULL,
    costo_total     NUMBER(10, 2) NOT NULL,
    status          NUMBER DEFAULT 1 NOT NULL, 
    id_tour         NUMBER,
    CONSTRAINT PK_INSCRIPCION PRIMARY KEY (numero),
    CONSTRAINT FK_INSCRIPCION_TOUR FOREIGN KEY (id_tour) REFERENCES TOURS (id)
);

CREATE TABLE INSCRITOS (
    id                  NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nro_inscripcion     NUMBER NOT NULL,
    id_visitante_lego   NUMBER NOT NULL,
    id_cliente_lego     NUMBER NOT NULL,
    CONSTRAINT PK_INSCRITOS PRIMARY KEY (id),
    CONSTRAINT FK_INSCRITOS_INSCRIP FOREIGN KEY (nro_inscripcion) REFERENCES INSCRIPCION (numero),
    CONSTRAINT FK_INSCRITOS_VISIT FOREIGN KEY (id_visitante_lego) REFERENCES VISITANTE_MENORES (id_lego),
    CONSTRAINT FK_INSCRITOS_CLIENTE FOREIGN KEY (id_cliente_lego) REFERENCES CLIENTES (id_lego)
);

CREATE TABLE ENTRADAS (
    nro_inscripcion NUMBER NOT NULL,
    id              NUMBER NOT NULL,
    tipo_cliente    VARCHAR2(20) CHECK (tipo_cliente IN ('ADULTO', 'NINO')) NOT NULL,
    CONSTRAINT PK_ENTRADAS PRIMARY KEY (nro_inscripcion, id),
    CONSTRAINT FK_ENTRADAS_INSCRIP FOREIGN KEY (nro_inscripcion) REFERENCES INSCRIPCION (numero)
);

CREATE TABLE TIENDAS (
    id              NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    nombre          VARCHAR2(100) NOT NULL,
    nro_telefono    VARCHAR2(20) NOT NULL,
    direccion       VARCHAR2(200) NOT NULL,
    id_pais         NUMBER NOT NULL,
    id_estado       NUMBER NOT NULL,
    id_ciudad       NUMBER NOT NULL,
    CONSTRAINT PK_TIENDAS PRIMARY KEY (id),
    CONSTRAINT UQ_TIENDAS_NOMBRE UNIQUE (nombre),
    CONSTRAINT FK_TIENDAS_CIUDAD FOREIGN KEY (id_pais, id_estado, id_ciudad) 
        REFERENCES CIUDADES (id_pais, id_estado, id)
);

CREATE TABLE HORARIOS (
    dia_semana      VARCHAR2(20) NOT NULL,
    hora_apertura   VARCHAR2(10) NOT NULL,
    hora_cierre     VARCHAR2(10) NOT NULL,
    id_tienda       NUMBER NOT NULL,
    CONSTRAINT PK_HORARIOS PRIMARY KEY (dia_semana),
    CONSTRAINT FK_HORARIOS_TIENDA FOREIGN KEY (id_tienda) REFERENCES TIENDAS (id)
);

-- 6. FACTURACIÓN E INVENTARIO
CREATE TABLE FACTURAS_TIENDA (
    nro_factura     NUMBER(6),
    total           NUMBER(10, 2) NOT NULL,
    fecha_emision   DATE NOT NULL,
    id_tienda       NUMBER NOT NULL,
    id_cliente_lego NUMBER NOT NULL,
    CONSTRAINT PK_FACTURAS_TIENDA PRIMARY KEY (nro_factura),
    CONSTRAINT FK_FACT_TIENDA FOREIGN KEY (id_tienda) REFERENCES TIENDAS (id),
    CONSTRAINT FK_FACT_CLIENTE FOREIGN KEY (id_cliente_lego) REFERENCES CLIENTES (id_lego)
);

CREATE TABLE DETALLES_FACTURA (
    nro_factura     NUMBER(6) NOT NULL,
    id              NUMBER(6) NOT NULL,
    cantidad        NUMBER(2),
    tipo_cliente    CHAR(1) NOT NULL,
    CONSTRAINT PK_DETALLES_FACTURA PRIMARY KEY (nro_factura, id),
    CONSTRAINT FK_DET_FACTURA FOREIGN KEY (nro_factura) REFERENCES FACTURAS_TIENDA (nro_factura),
    CONSTRAINT CK_TIPO_CLIENTE_FACT CHECK (tipo_cliente IN ('A', 'N'))
);

CREATE TABLE LOTES_INVENTARIO (
    id_tienda       NUMBER(4) NOT NULL,
    id_juguete     NUMBER(4) NULL,
    id_lote         NUMBER(4) NOT NULL,
    cantidad        NUMBER NOT NULL,
    CONSTRAINT PK_LOTES PRIMARY KEY (id_lote),
    CONSTRAINT FK_LOTES_TIENDA FOREIGN KEY (id_tienda) REFERENCES TIENDAS (id),
    CONSTRAINT FK_LOTES_PROD FOREIGN KEY (id_juguete) REFERENCES JUGUETES_LEGO (id)
);

CREATE TABLE DESCUENTO_L_INVENTARIO (
    id_lote         NUMBER NOT NULL,
    id              NUMBER NOT NULL,
    fecha           DATE NOT NULL,
    cant_descontar  NUMBER NOT NULL,
    es_salida       BOOLEAN NOT NULL, 
    CONSTRAINT PK_DESC_INVENTARIO PRIMARY KEY (id_lote, id),
    CONSTRAINT FK_DESC_LOTE FOREIGN KEY (id_lote) REFERENCES LOTES_INVENTARIO (id_lote)
);
