-- ============================================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS FÍSICA: BD_Keel
-- Startup: DALERST | Producto: Keel
-- Sistema de Gestión de Reparaciones y Mantenimiento de Embarcaciones
-- SGBD: Microsoft SQL Server 2025
-- ============================================================================

IF DB_ID('BD_Keel') IS NOT NULL
BEGIN
    ALTER DATABASE BD_Keel SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BD_Keel;
END
GO

CREATE DATABASE BD_Keel
COLLATE Modern_Spanish_CI_AS;
GO

USE BD_Keel;
GO

-- Habilitar soporte de diagramas de base de datos en SSMS asignando dbo a sa
ALTER AUTHORIZATION ON DATABASE::BD_Keel TO sa;
GO

-- ============================================================================
-- 1. TABLA: cliente
-- ============================================================================
CREATE TABLE cliente (
    id_cliente INT IDENTITY(1,1) NOT NULL,
    razon_social VARCHAR(150) NOT NULL,
    ruc CHAR(11) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY CLUSTERED (id_cliente),
    CONSTRAINT uq_cliente_ruc UNIQUE (ruc),
    CONSTRAINT chk_cliente_ruc CHECK (LEN(ruc) = 11 AND ruc NOT LIKE '%[^0-9]%')
);
GO

-- ============================================================================
-- 2. TABLA: representante
-- ============================================================================
CREATE TABLE representante (
    id_representante INT IDENTITY(1,1) NOT NULL,
    id_cliente INT NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    CONSTRAINT pk_representante PRIMARY KEY CLUSTERED (id_representante),
    CONSTRAINT fk_representante_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_representante_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);
GO

-- ============================================================================
-- 3. TABLA: embarcacion
-- ============================================================================
CREATE TABLE embarcacion (
    id_embarcacion INT IDENTITY(1,1) NOT NULL,
    id_cliente INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    matricula VARCHAR(30) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    puerto_base VARCHAR(100) NOT NULL,
    CONSTRAINT pk_embarcacion PRIMARY KEY CLUSTERED (id_embarcacion),
    CONSTRAINT uq_embarcacion_matricula UNIQUE (matricula),
    CONSTRAINT fk_embarcacion_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- ============================================================================
-- 4. TABLA: equipo
-- ============================================================================
CREATE TABLE equipo (
    id_equipo INT IDENTITY(1,1) NOT NULL,
    id_embarcacion INT NOT NULL,
    tipo_equipo VARCHAR(100) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(100) NULL,
    ubicacion_a_bordo VARCHAR(150) NOT NULL,
    refrigerante VARCHAR(50) NOT NULL,
    CONSTRAINT pk_equipo PRIMARY KEY CLUSTERED (id_equipo),
    CONSTRAINT fk_equipo_embarcacion FOREIGN KEY (id_embarcacion)
        REFERENCES embarcacion(id_embarcacion) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- ============================================================================
-- 5. TABLA: empleado
-- ============================================================================
CREATE TABLE empleado (
    id_empleado INT IDENTITY(1,1) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni CHAR(8) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    especialidad VARCHAR(100) NULL,
    telefono VARCHAR(20) NOT NULL,
    activo BIT NOT NULL DEFAULT 1,
    CONSTRAINT pk_empleado PRIMARY KEY CLUSTERED (id_empleado),
    CONSTRAINT uq_empleado_dni UNIQUE (dni),
    CONSTRAINT chk_empleado_dni CHECK (LEN(dni) = 8 AND dni NOT LIKE '%[^0-9]%'),
    CONSTRAINT chk_empleado_rol CHECK (rol IN ('Operaciones', 'Jefe Tecnico', 'Tecnico', 'Almacen', 'Compras', 'SSOMA', 'Administracion'))
);
GO

-- ============================================================================
-- 6. TABLA: solicitud
-- ============================================================================
CREATE TABLE solicitud (
    id_solicitud INT IDENTITY(1,1) NOT NULL,
    id_cliente INT NOT NULL,
    id_representante INT NOT NULL,
    id_embarcacion INT NOT NULL,
    fecha_recepcion DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    canal VARCHAR(50) NOT NULL,
    problema_reportado VARCHAR(MAX) NOT NULL,
    urgencia VARCHAR(20) NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Recibida',
    CONSTRAINT pk_solicitud PRIMARY KEY CLUSTERED (id_solicitud),
    CONSTRAINT fk_solicitud_cliente FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_solicitud_representante FOREIGN KEY (id_representante)
        REFERENCES representante(id_representante) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_solicitud_embarcacion FOREIGN KEY (id_embarcacion)
        REFERENCES embarcacion(id_embarcacion) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_solicitud_canal CHECK (canal IN ('Correo', 'Telefono', 'Presencial', 'WhatsApp', 'Plataforma Web')),
    CONSTRAINT chk_solicitud_urgencia CHECK (urgencia IN ('Baja', 'Media', 'Alta', 'Critica')),
    CONSTRAINT chk_solicitud_estado CHECK (estado IN ('Recibida', 'Inspeccionada', 'Cotizada', 'Aprobada', 'Archivada'))
);
GO

-- ============================================================================
-- 7. TABLA: inspeccion
-- ============================================================================
CREATE TABLE inspeccion (
    id_inspeccion INT IDENTITY(1,1) NOT NULL,
    id_solicitud INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha DATE NOT NULL,
    observaciones VARCHAR(MAX) NOT NULL,
    mediciones VARCHAR(MAX) NULL,
    alcance_inicial VARCHAR(MAX) NOT NULL,
    costo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_inspeccion PRIMARY KEY CLUSTERED (id_inspeccion),
    CONSTRAINT fk_inspeccion_solicitud FOREIGN KEY (id_solicitud)
        REFERENCES solicitud(id_solicitud) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_inspeccion_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_inspeccion_costo CHECK (costo >= 0)
);
GO

-- ============================================================================
-- 8. TABLA: articulo
-- ============================================================================
CREATE TABLE articulo (
    id_articulo INT IDENTITY(1,1) NOT NULL,
    codigo VARCHAR(30) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    unidad VARCHAR(30) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    stock_actual DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock_minimo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_articulo PRIMARY KEY CLUSTERED (id_articulo),
    CONSTRAINT uq_articulo_codigo UNIQUE (codigo),
    CONSTRAINT chk_articulo_tipo CHECK (tipo IN ('Repuesto', 'Material', 'Herramienta', 'Gas')),
    CONSTRAINT chk_articulo_stock_actual CHECK (stock_actual >= 0),
    CONSTRAINT chk_articulo_stock_minimo CHECK (stock_minimo >= 0),
    CONSTRAINT chk_articulo_precio CHECK (precio_unitario >= 0)
);
GO

-- ============================================================================
-- 9. TABLA: cotizacion (pre-creación sin fk_cotizacion_orden para evitar ciclo)
-- ============================================================================
CREATE TABLE cotizacion (
    id_cotizacion INT IDENTITY(1,1) NOT NULL,
    id_solicitud INT NOT NULL,
    id_orden INT NULL, -- Se referencia a orden_servicio más adelante
    id_representante_aprueba INT NULL,
    numero VARCHAR(30) NOT NULL,
    version INT NOT NULL DEFAULT 1,
    tipo VARCHAR(30) NOT NULL DEFAULT 'Principal',
    fecha_emision DATE NOT NULL,
    moneda CHAR(3) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    igv DECIMAL(12,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    plazo_dias INT NOT NULL,
    fecha_vigencia DATE NOT NULL,
    condiciones VARCHAR(MAX) NOT NULL,
    archivo_pdf VARCHAR(255) NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Borrador',
    fecha_aprobacion DATE NULL,
    evidencia_aprobacion VARCHAR(255) NULL,
    CONSTRAINT pk_cotizacion PRIMARY KEY CLUSTERED (id_cotizacion),
    CONSTRAINT uq_cotizacion_num_ver UNIQUE (numero, version),
    CONSTRAINT fk_cotizacion_solicitud FOREIGN KEY (id_solicitud)
        REFERENCES solicitud(id_solicitud) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_cotizacion_rep_aprueba FOREIGN KEY (id_representante_aprueba)
        REFERENCES representante(id_representante) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_cotizacion_version CHECK (version >= 1),
    CONSTRAINT chk_cotizacion_tipo CHECK (tipo IN ('Principal', 'Adicional')),
    CONSTRAINT chk_cotizacion_moneda CHECK (moneda IN ('PEN', 'USD')),
    CONSTRAINT chk_cotizacion_subtotal CHECK (subtotal >= 0),
    CONSTRAINT chk_cotizacion_igv CHECK (igv >= 0),
    CONSTRAINT chk_cotizacion_total CHECK (total >= 0),
    CONSTRAINT chk_cotizacion_plazo CHECK (plazo_dias > 0),
    CONSTRAINT chk_cotizacion_estado CHECK (estado IN ('Borrador', 'Enviada', 'Aprobada', 'Rechazada', 'Vencida', 'Archivada'))
);
GO

-- ============================================================================
-- 10. TABLA: detalle_cotizacion
-- ============================================================================
CREATE TABLE detalle_cotizacion (
    id_detalle INT IDENTITY(1,1) NOT NULL,
    id_cotizacion INT NOT NULL,
    id_articulo INT NULL,
    concepto VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    unidad VARCHAR(30) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_detalle_cotizacion PRIMARY KEY CLUSTERED (id_detalle),
    CONSTRAINT fk_det_cot_cotizacion FOREIGN KEY (id_cotizacion)
        REFERENCES cotizacion(id_cotizacion) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_det_cot_articulo FOREIGN KEY (id_articulo)
        REFERENCES articulo(id_articulo) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_det_cot_concepto CHECK (concepto IN ('Mano de obra', 'Repuesto', 'Material', 'Gas', 'Traslado', 'Otros')),
    CONSTRAINT chk_det_cot_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_det_cot_precio CHECK (precio_unitario >= 0),
    CONSTRAINT chk_det_cot_subtotal CHECK (subtotal >= 0)
);
GO

-- ============================================================================
-- 11. TABLA: orden_servicio
-- ============================================================================
CREATE TABLE orden_servicio (
    id_orden INT IDENTITY(1,1) NOT NULL,
    id_cotizacion INT NOT NULL,
    id_embarcacion INT NOT NULL,
    id_jefe_tecnico INT NOT NULL,
    numero VARCHAR(30) NOT NULL,
    fecha_apertura DATE NOT NULL,
    fecha_cierre DATE NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Abierta',
    condiciones_garantia VARCHAR(MAX) NULL,
    fecha_fin_garantia DATE NULL,
    CONSTRAINT pk_orden_servicio PRIMARY KEY CLUSTERED (id_orden),
    CONSTRAINT uq_orden_numero UNIQUE (numero),
    CONSTRAINT fk_orden_cotizacion FOREIGN KEY (id_cotizacion)
        REFERENCES cotizacion(id_cotizacion) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_orden_embarcacion FOREIGN KEY (id_embarcacion)
        REFERENCES embarcacion(id_embarcacion) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_orden_jefe_tecnico FOREIGN KEY (id_jefe_tecnico)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_orden_estado CHECK (estado IN ('Abierta', 'En ejecucion', 'En pruebas', 'Entregada', 'Pagada', 'Cerrada')),
    CONSTRAINT chk_orden_fechas CHECK (fecha_cierre IS NULL OR fecha_cierre >= fecha_apertura)
);
GO

-- Conectar id_orden en cotización (para cotizaciones de adicionales)
ALTER TABLE cotizacion
ADD CONSTRAINT fk_cotizacion_orden FOREIGN KEY (id_orden)
    REFERENCES orden_servicio(id_orden) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- ============================================================================
-- 12. TABLA: trabajo
-- ============================================================================
CREATE TABLE trabajo (
    id_trabajo INT IDENTITY(1,1) NOT NULL,
    id_orden INT NOT NULL,
    id_responsable INT NOT NULL,
    id_trabajo_previo INT NULL,
    descripcion VARCHAR(MAX) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    fecha_inicio_prevista DATE NOT NULL,
    fecha_fin_prevista DATE NOT NULL,
    fecha_inicio_real DATE NULL,
    fecha_fin_real DATE NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    motivo_espera VARCHAR(255) NULL,
    CONSTRAINT pk_trabajo PRIMARY KEY CLUSTERED (id_trabajo),
    CONSTRAINT fk_trabajo_orden FOREIGN KEY (id_orden)
        REFERENCES orden_servicio(id_orden) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_trabajo_responsable FOREIGN KEY (id_responsable)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_trabajo_previo FOREIGN KEY (id_trabajo_previo)
        REFERENCES trabajo(id_trabajo) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_trabajo_estado CHECK (estado IN ('Pendiente', 'En ejecucion', 'En espera', 'En pruebas', 'Terminado')),
    CONSTRAINT chk_trabajo_fechas_previstas CHECK (fecha_fin_prevista >= fecha_inicio_prevista),
    CONSTRAINT chk_trabajo_fechas_reales CHECK (fecha_fin_real IS NULL OR fecha_inicio_real IS NULL OR fecha_fin_real >= fecha_inicio_real)
);
GO

-- ============================================================================
-- 13. TABLA: participacion_trabajo
-- ============================================================================
CREATE TABLE participacion_trabajo (
    id_trabajo INT NOT NULL,
    id_empleado INT NOT NULL,
    funcion VARCHAR(50) NOT NULL,
    horas_trabajadas DECIMAL(6,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_participacion_trabajo PRIMARY KEY CLUSTERED (id_trabajo, id_empleado),
    CONSTRAINT fk_part_trab_trabajo FOREIGN KEY (id_trabajo)
        REFERENCES trabajo(id_trabajo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_part_trab_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_part_trab_funcion CHECK (funcion IN ('Responsable', 'Apoyo')),
    CONSTRAINT chk_part_trab_horas CHECK (horas_trabajadas >= 0)
);
GO

-- ============================================================================
-- 14. TABLA: avance_trabajo
-- ============================================================================
CREATE TABLE avance_trabajo (
    id_avance INT IDENTITY(1,1) NOT NULL,
    id_trabajo INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_hora DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    descripcion VARCHAR(MAX) NOT NULL,
    estado_reportado VARCHAR(30) NOT NULL,
    porcentaje_avance DECIMAL(5,2) NOT NULL,
    CONSTRAINT pk_avance_trabajo PRIMARY KEY CLUSTERED (id_avance),
    CONSTRAINT fk_avance_trabajo FOREIGN KEY (id_trabajo)
        REFERENCES trabajo(id_trabajo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_avance_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_avance_porcentaje CHECK (porcentaje_avance BETWEEN 0 AND 100)
);
GO

-- ============================================================================
-- 15. TABLA: proveedor
-- ============================================================================
CREATE TABLE proveedor (
    id_proveedor INT IDENTITY(1,1) NOT NULL,
    razon_social VARCHAR(150) NOT NULL,
    ruc CHAR(11) NOT NULL,
    contacto VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    CONSTRAINT pk_proveedor PRIMARY KEY CLUSTERED (id_proveedor),
    CONSTRAINT uq_proveedor_ruc UNIQUE (ruc),
    CONSTRAINT chk_proveedor_ruc CHECK (LEN(ruc) = 11 AND ruc NOT LIKE '%[^0-9]%')
);
GO

-- ============================================================================
-- 16. TABLA: orden_compra
-- ============================================================================
CREATE TABLE orden_compra (
    id_compra INT IDENTITY(1,1) NOT NULL,
    id_proveedor INT NOT NULL,
    id_trabajo INT NULL,
    id_empleado INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado VARCHAR(30) NOT NULL DEFAULT 'Solicitada',
    total DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_orden_compra PRIMARY KEY CLUSTERED (id_compra),
    CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor)
        REFERENCES proveedor(id_proveedor) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_compra_trabajo FOREIGN KEY (id_trabajo)
        REFERENCES trabajo(id_trabajo) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_compra_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_compra_estado CHECK (estado IN ('Solicitada', 'Recibida parcialmente', 'Recibida', 'Anulada')),
    CONSTRAINT chk_compra_total CHECK (total >= 0)
);
GO

-- ============================================================================
-- 17. TABLA: detalle_compra
-- ============================================================================
CREATE TABLE detalle_compra (
    id_detalle_compra INT IDENTITY(1,1) NOT NULL,
    id_compra INT NOT NULL,
    id_articulo INT NOT NULL,
    cantidad_pedida DECIMAL(10,2) NOT NULL,
    cantidad_recibida DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_recepcion DATE NULL,
    condicion_recepcion VARCHAR(255) NULL,
    CONSTRAINT pk_detalle_compra PRIMARY KEY CLUSTERED (id_detalle_compra),
    CONSTRAINT fk_det_comp_compra FOREIGN KEY (id_compra)
        REFERENCES orden_compra(id_compra) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_det_comp_articulo FOREIGN KEY (id_articulo)
        REFERENCES articulo(id_articulo) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_det_comp_cant_pedida CHECK (cantidad_pedida > 0),
    CONSTRAINT chk_det_comp_cant_recibida CHECK (cantidad_recibida >= 0),
    CONSTRAINT chk_det_comp_precio CHECK (precio_unitario >= 0)
);
GO

-- ============================================================================
-- 18. TABLA: movimiento_almacen
-- ============================================================================
CREATE TABLE movimiento_almacen (
    id_movimiento INT IDENTITY(1,1) NOT NULL,
    id_articulo INT NOT NULL,
    id_trabajo INT NULL,
    id_empleado INT NOT NULL,
    id_detalle_compra INT NULL,
    tipo VARCHAR(30) NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    fecha DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    fecha_devolucion_prevista DATE NULL,
    observacion VARCHAR(MAX) NULL,
    CONSTRAINT pk_movimiento_almacen PRIMARY KEY CLUSTERED (id_movimiento),
    CONSTRAINT fk_mov_articulo FOREIGN KEY (id_articulo)
        REFERENCES articulo(id_articulo) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_mov_trabajo FOREIGN KEY (id_trabajo)
        REFERENCES trabajo(id_trabajo) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_mov_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_mov_det_compra FOREIGN KEY (id_detalle_compra)
        REFERENCES detalle_compra(id_detalle_compra) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_mov_tipo CHECK (tipo IN ('Salida', 'Devolucion', 'Prestamo', 'Ingreso', 'Ajuste')),
    CONSTRAINT chk_mov_cantidad CHECK (cantidad > 0)
);
GO

-- ============================================================================
-- 19. TABLA: prueba
-- ============================================================================
CREATE TABLE prueba (
    id_prueba INT IDENTITY(1,1) NOT NULL,
    id_trabajo INT NOT NULL,
    id_empleado INT NOT NULL,
    tipo_prueba VARCHAR(100) NOT NULL,
    parametro VARCHAR(100) NOT NULL,
    valor_medido DECIMAL(10,2) NOT NULL,
    unidad VARCHAR(30) NOT NULL,
    valor_minimo DECIMAL(10,2) NOT NULL,
    valor_maximo DECIMAL(10,2) NOT NULL,
    resultado VARCHAR(20) NOT NULL,
    numero_intento INT NOT NULL DEFAULT 1,
    fecha DATE NOT NULL,
    CONSTRAINT pk_prueba PRIMARY KEY CLUSTERED (id_prueba),
    CONSTRAINT fk_prueba_trabajo FOREIGN KEY (id_trabajo)
        REFERENCES trabajo(id_trabajo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_prueba_empleado FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_prueba_resultado CHECK (resultado IN ('Conforme', 'No conforme')),
    CONSTRAINT chk_prueba_intento CHECK (numero_intento >= 1)
);
GO

-- ============================================================================
-- 20. TABLA: observacion_ssoma
-- ============================================================================
CREATE TABLE observacion_ssoma (
    id_observacion INT IDENTITY(1,1) NOT NULL,
    id_orden INT NOT NULL,
    id_trabajo INT NULL,
    id_responsable INT NOT NULL,
    fecha DATE NOT NULL,
    momento VARCHAR(20) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    riesgo VARCHAR(150) NOT NULL,
    descripcion VARCHAR(MAX) NOT NULL,
    accion_requerida VARCHAR(MAX) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Abierta',
    CONSTRAINT pk_observacion_ssoma PRIMARY KEY CLUSTERED (id_observacion),
    CONSTRAINT fk_ssoma_orden FOREIGN KEY (id_orden)
        REFERENCES orden_servicio(id_orden) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_ssoma_trabajo FOREIGN KEY (id_trabajo)
        REFERENCES trabajo(id_trabajo) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_ssoma_responsable FOREIGN KEY (id_responsable)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_ssoma_momento CHECK (momento IN ('Antes', 'Durante', 'Despues')),
    CONSTRAINT chk_ssoma_tipo CHECK (tipo IN ('Control', 'Observacion', 'Incidente')),
    CONSTRAINT chk_ssoma_estado CHECK (estado IN ('Abierta', 'Cerrada'))
);
GO

-- ============================================================================
-- 21. TABLA: evidencia
-- ============================================================================
CREATE TABLE evidencia (
    id_evidencia INT IDENTITY(1,1) NOT NULL,
    id_inspeccion INT NULL,
    id_avance INT NULL,
    id_prueba INT NULL,
    id_observacion INT NULL,
    tipo VARCHAR(30) NOT NULL,
    archivo_url VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    fecha DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT pk_evidencia PRIMARY KEY CLUSTERED (id_evidencia),
    CONSTRAINT fk_evid_inspeccion FOREIGN KEY (id_inspeccion)
        REFERENCES inspeccion(id_inspeccion) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_evid_avance FOREIGN KEY (id_avance)
        REFERENCES avance_trabajo(id_avance) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_evid_prueba FOREIGN KEY (id_prueba)
        REFERENCES prueba(id_prueba) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_evid_observacion FOREIGN KEY (id_observacion)
        REFERENCES observacion_ssoma(id_observacion) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT chk_evid_tipo CHECK (tipo IN ('Fotografia', 'Documento', 'Medicion'))
);
GO

-- ============================================================================
-- 22. TABLA: informe_tecnico
-- ============================================================================
CREATE TABLE informe_tecnico (
    id_informe INT IDENTITY(1,1) NOT NULL,
    id_orden INT NOT NULL,
    id_jefe_tecnico INT NOT NULL,
    fecha_emision DATE NOT NULL,
    problema_inicial VARCHAR(MAX) NOT NULL,
    diagnostico VARCHAR(MAX) NOT NULL,
    trabajos_realizados VARCHAR(MAX) NOT NULL,
    resultado_pruebas VARCHAR(MAX) NOT NULL,
    estado_conformidad VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    fecha_conformidad DATE NULL,
    medio_conformidad VARCHAR(50) NULL,
    CONSTRAINT pk_informe_tecnico PRIMARY KEY CLUSTERED (id_informe),
    CONSTRAINT fk_informe_orden FOREIGN KEY (id_orden)
        REFERENCES orden_servicio(id_orden) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_informe_jefe_tecnico FOREIGN KEY (id_jefe_tecnico)
        REFERENCES empleado(id_empleado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_informe_conformidad CHECK (estado_conformidad IN ('Pendiente', 'Conforme', 'Con observaciones'))
);
GO

-- ============================================================================
-- 23. TABLA: observacion_cliente
-- ============================================================================
CREATE TABLE observacion_cliente (
    id_obs_cliente INT IDENTITY(1,1) NOT NULL,
    id_informe INT NOT NULL,
    descripcion VARCHAR(MAX) NOT NULL,
    fecha DATE NOT NULL,
    dentro_del_alcance BIT NOT NULL DEFAULT 1,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    fecha_atencion DATE NULL,
    CONSTRAINT pk_observacion_cliente PRIMARY KEY CLUSTERED (id_obs_cliente),
    CONSTRAINT fk_obs_cliente_informe FOREIGN KEY (id_informe)
        REFERENCES informe_tecnico(id_informe) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_obs_cliente_estado CHECK (estado IN ('Pendiente', 'Atendida'))
);
GO

-- ============================================================================
-- 24. TABLA: pago
-- ============================================================================
CREATE TABLE pago (
    id_pago INT IDENTITY(1,1) NOT NULL,
    id_orden INT NOT NULL,
    fecha DATE NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    moneda CHAR(3) NOT NULL,
    medio_pago VARCHAR(50) NOT NULL,
    numero_operacion VARCHAR(50) NOT NULL,
    verificado BIT NOT NULL DEFAULT 0,
    fecha_verificacion DATE NULL,
    tipo_comprobante VARCHAR(30) NOT NULL,
    numero_comprobante VARCHAR(30) NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY CLUSTERED (id_pago),
    CONSTRAINT fk_pago_orden FOREIGN KEY (id_orden)
        REFERENCES orden_servicio(id_orden) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT chk_pago_monto CHECK (monto > 0),
    CONSTRAINT chk_pago_moneda CHECK (moneda IN ('PEN', 'USD')),
    CONSTRAINT chk_pago_medio CHECK (medio_pago IN ('Transferencia', 'Cheque', 'Efectivo', 'Tarjeta de Credito', 'Deposito Bancario')),
    CONSTRAINT chk_pago_comprobante CHECK (tipo_comprobante IN ('Factura', 'Boleta de Venta'))
);
GO

-- ============================================================================
-- CREACIÓN DE ÍNDICES NO AGRUPADOS (NON-CLUSTERED) PARA OPTIMIZACIÓN DE JOINS
-- ============================================================================
CREATE NONCLUSTERED INDEX ix_representante_cliente ON representante(id_cliente);
CREATE NONCLUSTERED INDEX ix_embarcacion_cliente ON embarcacion(id_cliente);
CREATE NONCLUSTERED INDEX ix_equipo_embarcacion ON equipo(id_embarcacion);
CREATE NONCLUSTERED INDEX ix_solicitud_cliente ON solicitud(id_cliente);
CREATE NONCLUSTERED INDEX ix_solicitud_embarcacion ON solicitud(id_embarcacion);
CREATE NONCLUSTERED INDEX ix_inspeccion_solicitud ON inspeccion(id_solicitud);
CREATE NONCLUSTERED INDEX ix_cotizacion_solicitud ON cotizacion(id_solicitud);
CREATE NONCLUSTERED INDEX ix_cotizacion_orden ON cotizacion(id_orden);
CREATE NONCLUSTERED INDEX ix_detalle_cot_cotizacion ON detalle_cotizacion(id_cotizacion);
CREATE NONCLUSTERED INDEX ix_orden_servicio_cotizacion ON orden_servicio(id_cotizacion);
CREATE NONCLUSTERED INDEX ix_orden_servicio_embarcacion ON orden_servicio(id_embarcacion);
CREATE NONCLUSTERED INDEX ix_trabajo_orden ON trabajo(id_orden);
CREATE NONCLUSTERED INDEX ix_trabajo_responsable ON trabajo(id_responsable);
CREATE NONCLUSTERED INDEX ix_participacion_empleado ON participacion_trabajo(id_empleado);
CREATE NONCLUSTERED INDEX ix_avance_trabajo ON avance_trabajo(id_trabajo);
CREATE NONCLUSTERED INDEX ix_orden_compra_proveedor ON orden_compra(id_proveedor);
CREATE NONCLUSTERED INDEX ix_detalle_compra_compra ON detalle_compra(id_compra);
CREATE NONCLUSTERED INDEX ix_movimiento_articulo ON movimiento_almacen(id_articulo);
CREATE NONCLUSTERED INDEX ix_movimiento_trabajo ON movimiento_almacen(id_trabajo);
CREATE NONCLUSTERED INDEX ix_prueba_trabajo ON prueba(id_trabajo);
CREATE NONCLUSTERED INDEX ix_ssoma_orden ON observacion_ssoma(id_orden);
CREATE NONCLUSTERED INDEX ix_informe_orden ON informe_tecnico(id_orden);
CREATE NONCLUSTERED INDEX ix_pago_orden ON pago(id_orden);
GO

