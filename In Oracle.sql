-- Tabla que almacena los distritos
CREATE TABLE DISTRITO (
    COD_DIS CHAR(5) PRIMARY KEY,  -- Código único del distrito
    NOM_DIS VARCHAR2(50)          -- Nombre del distrito
);

-- Tabla que almacena los clientes
CREATE TABLE CLIENTE (
    COD_CLI CHAR(5) PRIMARY KEY,  -- Código único del cliente
    RSO_CLI CHAR(30),             -- Razón social del cliente
    DIR_CLI VARCHAR2(100),        -- Dirección del cliente
    TLF_CLI CHAR(9),              -- Teléfono del cliente
    RUC_CLI CHAR(11),             -- RUC del cliente
    COD_DIS CHAR(5),              -- Código de distrito (clave foránea)
    FEC_REG DATE,                 -- Fecha de registro
    TIP_CLI VARCHAR2(10),         -- Tipo de cliente
    CON_CLI VARCHAR2(30),         -- Contacto del cliente
    FOREIGN KEY (COD_DIS) REFERENCES DISTRITO(COD_DIS)  -- Relación con DISTRITO
);

-- Tabla que almacena los vendedores
CREATE TABLE VENDEDOR (
    COD_VEN CHAR(3) PRIMARY KEY,  -- Código único del vendedor
    NOM_VEN VARCHAR2(20),         -- Nombre del vendedor
    APE_VEN VARCHAR2(20),         -- Apellido del vendedor
    SUE_VEN FLOAT,                -- Sueldo del vendedor
    FIN_VEN DATE,                 -- Fecha de ingreso
    TIP_VEN VARCHAR2(10),         -- Tipo de vendedor
    COD_DIS CHAR(5),              -- Código de distrito (clave foránea)
    FOREIGN KEY (COD_DIS) REFERENCES DISTRITO(COD_DIS)  -- Relación con DISTRITO
);

-- Tabla que almacena los proveedores
CREATE TABLE PROVEEDOR (
    COD_PRV CHAR(5) PRIMARY KEY,  -- Código único del proveedor
    RSO_PRV VARCHAR2(80),         -- Razón social del proveedor
    DIR_PRV VARCHAR2(100),        -- Dirección del proveedor
    TEL_PRV CHAR(15),             -- Teléfono del proveedor
    COD_DIS CHAR(5),              -- Código de distrito (clave foránea)
    REP_PRV VARCHAR2(80),         -- Representante del proveedor
    FOREIGN KEY (COD_DIS) REFERENCES DISTRITO(COD_DIS)  -- Relación con DISTRITO
);

-- Tabla que almacena las facturas
CREATE TABLE FACTURA (
    NUM_FAC VARCHAR2(12) PRIMARY KEY,  -- Número único de la factura
    FEC_FAC DATE,                      -- Fecha de emisión de la factura
    COD_CLI CHAR(5),                    -- Código del cliente (clave foránea)
    FEC_CAN DATE,                       -- Fecha de cancelación
    EST_FAC CHAR(1),                    -- Estado de la factura
    COD_VEN CHAR(3),                    -- Código del vendedor (clave foránea)
    POR_IGV DECIMAL(18,0),              -- Porcentaje de IGV aplicado
    FOREIGN KEY (COD_CLI) REFERENCES CLIENTE(COD_CLI), -- Relación con CLIENTE
    FOREIGN KEY (COD_VEN) REFERENCES VENDEDOR(COD_VEN) -- Relación con VENDEDOR
);

-- Tabla que almacena los productos
CREATE TABLE PRODUCTO (
    COD_PRO CHAR(5) PRIMARY KEY,  -- Código único del producto
    DES_PRO VARCHAR2(50),         -- Descripción del producto
    PRE_PRO FLOAT,                -- Precio del producto
    SAC_PRO INT,                  -- Stock actual del producto
    SMI_PRO INT,                  -- Stock mínimo del producto
    UNI_PRO VARCHAR2(30),         -- Unidad de medida
    LIN_PRO VARCHAR2(30),         -- Línea de producto
    IMP_PRO VARCHAR2(10)          -- Impuesto aplicado al producto
);

-- Tabla que almacena el detalle de las facturas
CREATE TABLE DETALLE_FACTURA (
    NUM_FAC VARCHAR2(12),   -- Número de la factura (clave foránea)
    COD_PRO CHAR(5),        -- Código del producto (clave foránea)
    CAN_VEN INT,           -- Cantidad vendida
    PRE_VEN FLOAT,         -- Precio de venta
    PRIMARY KEY (NUM_FAC, COD_PRO),  -- Clave primaria compuesta
    FOREIGN KEY (NUM_FAC) REFERENCES FACTURA(NUM_FAC), -- Relación con FACTURA
    FOREIGN KEY (COD_PRO) REFERENCES PRODUCTO(COD_PRO) -- Relación con PRODUCTO
);

-- Tabla que almacena las órdenes de compra
CREATE TABLE ORDEN_COMPRA (
    NUM_OCO CHAR(5) PRIMARY KEY,  -- Número único de la orden de compra
    FEC_OCO DATE,                 -- Fecha de emisión de la orden
    COD_PRV CHAR(5),              -- Código del proveedor (clave foránea)
    FAT_OCO DATE,                 -- Fecha de facturación de la orden
    EST_OCO CHAR(1),              -- Estado de la orden
    FOREIGN KEY (COD_PRV) REFERENCES PROVEEDOR(COD_PRV) -- Relación con PROVEEDOR
);

-- Tabla que almacena el detalle de las órdenes de compra
CREATE TABLE DETALLE_COMPRA (
    NUM_OCO CHAR(5),   -- Número de la orden de compra (clave foránea)
    COD_PRO CHAR(5),   -- Código del producto (clave foránea)
    CAN_DET INT,       -- Cantidad solicitada
    PRIMARY KEY (NUM_OCO, COD_PRO),  -- Clave primaria compuesta
    FOREIGN KEY (NUM_OCO) REFERENCES ORDEN_COMPRA(NUM_OCO), -- Relación con ORDEN_COMPRA
    FOREIGN KEY (COD_PRO) REFERENCES PRODUCTO(COD_PRO) -- Relación con PRODUCTO
);

-- Tabla que almacena el abastecimiento de productos por proveedores
CREATE TABLE ABASTECIMIENTO (
    COD_PRV CHAR(5),  -- Código del proveedor (clave foránea)
    COD_PRO CHAR(5),  -- Código del producto (clave foránea)
    PRE_ABA FLOAT,    -- Precio de abastecimiento
    PRIMARY KEY (COD_PRV, COD_PRO),  -- Clave primaria compuesta
    FOREIGN KEY (COD_PRV) REFERENCES PROVEEDOR(COD_PRV), -- Relación con PROVEEDOR
    FOREIGN KEY (COD_PRO) REFERENCES PRODUCTO(COD_PRO) -- Relación con PRODUCTO
);
