-- Tabla que almacena los distritos
CREATE TABLE TB_DISTRITO (
    COD_DIS CHAR(5) PRIMARY KEY,  -- Código único del distrito
    NOM_DIS VARCHAR2(50)          -- Nombre del distrito
);

-- Tabla que almacena los clientes
CREATE TABLE TB_CLIENTE (
    COD_CLI CHAR(5) PRIMARY KEY,  -- Código único del cliente
    RSO_CLI CHAR(30),             -- Razón social del cliente
    DIR_CLI VARCHAR2(100),        -- Dirección del cliente
    TLF_CLI CHAR(9),              -- Teléfono del cliente
    RUC_CLI CHAR(11),             -- RUC del cliente
    COD_DIS CHAR(5),              -- Código de distrito (clave foránea)
    FEC_REG DATE,                 -- Fecha de registro
    TIP_CLI VARCHAR2(10),         -- Tipo de cliente
    CON_CLI VARCHAR2(30),         -- Contacto del cliente
    FOREIGN KEY (COD_DIS) REFERENCES TB_DISTRITO(COD_DIS) ON DELETE CASCADE -- Relación con TB_DISTRITO
);

-- Tabla que almacena los vendedores
CREATE TABLE TB_VENDEDOR (
    COD_VEN CHAR(5) PRIMARY KEY,  -- Código único del vendedor
    NOM_VEN VARCHAR2(20),         -- Nombre del vendedor
    APE_VEN VARCHAR2(20),         -- Apellido del vendedor
    SUE_VEN DECIMAL(10,2),        -- Sueldo del vendedor
    FIN_VEN DATE,                 -- Fecha de ingreso
    TIP_VEN VARCHAR2(10),         -- Tipo de vendedor
    COD_DIS CHAR(5),              -- Código de distrito (clave foránea)
    FOREIGN KEY (COD_DIS) REFERENCES TB_DISTRITO(COD_DIS) ON DELETE CASCADE -- Relación con TB_DISTRITO
);

-- Tabla que almacena los proveedores
CREATE TABLE TB_PROVEEDOR (
    COD_PRV CHAR(5) PRIMARY KEY,  -- Código único del proveedor
    RSO_PRV VARCHAR2(80),         -- Razón social del proveedor
    DIR_PRV VARCHAR2(100),        -- Dirección del proveedor
    TEL_PRV CHAR(15),             -- Teléfono del proveedor
    COD_DIS CHAR(5),              -- Código de distrito (clave foránea)
    REP_PRV VARCHAR2(80),         -- Representante del proveedor
    FOREIGN KEY (COD_DIS) REFERENCES TB_DISTRITO(COD_DIS) ON DELETE CASCADE -- Relación con TB_DISTRITO
);

-- Tabla que almacena las facturas
CREATE TABLE TB_FACTURA (
    NUM_FAC VARCHAR2(12) PRIMARY KEY,  -- Número único de la factura
    FEC_FAC DATE,                      -- Fecha de emisión de la factura
    COD_CLI CHAR(5),                    -- Código del cliente (clave foránea)
    FEC_CAN DATE,                       -- Fecha de cancelación
    EST_FAC CHAR(1) CHECK (EST_FAC IN ('P', 'N')), -- Estado de la factura (Pagado/No pagado)
    COD_VEN CHAR(5),                    -- Código del vendedor (clave foránea)
    POR_IGV DECIMAL(5,2),               -- Porcentaje de IGV aplicado
    FOREIGN KEY (COD_CLI) REFERENCES TB_CLIENTE(COD_CLI) ON DELETE CASCADE, -- Relación con TB_CLIENTE
    FOREIGN KEY (COD_VEN) REFERENCES TB_VENDEDOR(COD_VEN) ON DELETE CASCADE -- Relación con TB_VENDEDOR
);

-- Tabla que almacena los productos
CREATE TABLE TB_PRODUCTO (
    COD_PRO CHAR(5) PRIMARY KEY,  -- Código único del producto
    DES_PRO VARCHAR2(50),         -- Descripción del producto
    PRE_PRO DECIMAL(10,2),        -- Precio del producto
    SAC_PRO INT,                  -- Stock actual del producto
    SMI_PRO INT,                  -- Stock mínimo del producto
    UNI_PRO VARCHAR2(30),         -- Unidad de medida
    LIN_PRO VARCHAR2(30),         -- Línea de producto
    IMP_PRO DECIMAL(5,2)          -- Impuesto aplicado al producto
);

-- Tabla que almacena el detalle de las facturas
CREATE TABLE TB_DETALLE_FACTURA (
    NUM_FAC VARCHAR2(12),   -- Número de la factura (clave foránea)
    COD_PRO CHAR(5),        -- Código del producto (clave foránea)
    CAN_VEN INT,           -- Cantidad vendida
    PRE_VEN DECIMAL(10,2), -- Precio de venta
    PRIMARY KEY (NUM_FAC, COD_PRO),  -- Clave primaria compuesta
    FOREIGN KEY (NUM_FAC) REFERENCES TB_FACTURA(NUM_FAC) ON DELETE CASCADE, -- Relación con TB_FACTURA
    FOREIGN KEY (COD_PRO) REFERENCES TB_PRODUCTO(COD_PRO) -- Relación con TB_PRODUCTO
);

-- Tabla que almacena las órdenes de compra
CREATE TABLE TB_ORDEN_COMPRA (
    NUM_OCO CHAR(5) PRIMARY KEY,  -- Número único de la orden de compra
    FEC_OCO DATE,                 -- Fecha de emisión de la orden
    COD_PRV CHAR(5),              -- Código del proveedor (clave foránea)
    FAT_OCO DATE,                 -- Fecha de facturación de la orden
    EST_OCO CHAR(1) CHECK (EST_OCO IN ('A', 'C')), -- Estado de la orden (Activo/Cancelado)
    FOREIGN KEY (COD_PRV) REFERENCES TB_PROVEEDOR(COD_PRV) ON DELETE CASCADE -- Relación con TB_PROVEEDOR
);

-- Tabla que almacena el detalle de las órdenes de compra
CREATE TABLE TB_DETALLE_COMPRA (
    NUM_OCO CHAR(5),   -- Número de la orden de compra (clave foránea)
    COD_PRO CHAR(5),   -- Código del producto (clave foránea)
    CAN_DET INT,       -- Cantidad solicitada
    PRIMARY KEY (NUM_OCO, COD_PRO),  -- Clave primaria compuesta
    FOREIGN KEY (NUM_OCO) REFERENCES TB_ORDEN_COMPRA(NUM_OCO) ON DELETE CASCADE, -- Relación con TB_ORDEN_COMPRA
    FOREIGN KEY (COD_PRO) REFERENCES TB_PRODUCTO(COD_PRO) -- Relación con TB_PRODUCTO
);

-- Tabla que almacena el abastecimiento de productos por proveedores
CREATE TABLE TB_ABASTECIMIENTO (
    COD_PRV CHAR(5),  -- Código del proveedor (clave foránea)
    COD_PRO CHAR(5),  -- Código del producto (clave foránea)
    PRE_ABA DECIMAL(10,2), -- Precio de abastecimiento
    PRIMARY KEY (COD_PRV, COD_PRO),  -- Clave primaria compuesta
    FOREIGN KEY (COD_PRV) REFERENCES TB_PROVEEDOR(COD_PRV) ON DELETE CASCADE, -- Relación con TB_PROVEEDOR
    FOREIGN KEY (COD_PRO) REFERENCES TB_PRODUCTO(COD_PRO) -- Relación con TB_PRODUCTO
);
