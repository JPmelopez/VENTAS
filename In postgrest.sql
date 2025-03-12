-- Tabla DISTRITO
CREATE TABLE distrito (
    cod_dis CHAR(5) PRIMARY KEY,
    nom_dis VARCHAR(50) NOT NULL
);

-- Tabla CLIENTE
CREATE TABLE cliente (
    cod_cli CHAR(5) PRIMARY KEY,
    rso_cli CHAR(30) NOT NULL,
    dir_cli VARCHAR(100) NOT NULL,
    tlf_cli CHAR(9),
    ruc_cli CHAR(11),
    cod_dis CHAR(5) REFERENCES distrito(cod_dis),
    fec_reg DATE,
    tip_cli VARCHAR(10),
    con_cli VARCHAR(30)
);

-- Tabla VENDEDOR
CREATE TABLE vendedor (
    cod_ven CHAR(3) PRIMARY KEY,
    nom_ven VARCHAR(20) NOT NULL,
    ape_ven VARCHAR(20) NOT NULL,
    sue_ven NUMERIC(10,2),
    fin_ven DATE,
    tip_ven VARCHAR(10),
    cod_dis CHAR(5) REFERENCES distrito(cod_dis)
);

-- Tabla PROVEEDOR
CREATE TABLE proveedor (
    cod_prv CHAR(5) PRIMARY KEY,
    rso_prv VARCHAR(80) NOT NULL,
    dir_prv VARCHAR(100) NOT NULL,
    tel_prv CHAR(15),
    cod_dis CHAR(5) REFERENCES distrito(cod_dis),
    rep_prv VARCHAR(80)
);

-- Tabla PRODUCTO
CREATE TABLE producto (
    cod_pro CHAR(5) PRIMARY KEY,
    des_pro VARCHAR(30) NOT NULL,
    pre_pro NUMERIC(10,2),
    sac_pro INT,
    smi_pro INT,
    uni_pro VARCHAR(30),
    lin_pro VARCHAR(30),
    imp_pro VARCHAR(10)
);

-- Tabla FACTURA
CREATE TABLE factura (
    num_fac VARCHAR(12) PRIMARY KEY,
    fec_fac DATE NOT NULL,
    cod_cli CHAR(5) REFERENCES cliente(cod_cli),
    fec_can DATE,
    est_fac VARCHAR(10),
    cod_ven CHAR(3) REFERENCES vendedor(cod_ven),
    por_igv NUMERIC(8,2)
);

-- Tabla DETALLE_FACTURA
CREATE TABLE detalle_factura (
    num_fac VARCHAR(12) REFERENCES factura(num_fac),
    cod_pro CHAR(5) REFERENCES producto(cod_pro),
    can_ven INT NOT NULL,
    pre_ven NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (num_fac, cod_pro)
);

-- Tabla ORDEN_COMPRA
CREATE TABLE orden_compra (
    num_oco CHAR(5) PRIMARY KEY,
    fec_oco DATE NOT NULL,
    cod_prv CHAR(5) REFERENCES proveedor(cod_prv),
    fat_oco DATE,
    est_oco CHAR(1)
);

-- Tabla DETALLE_COMPRA
CREATE TABLE detalle_compra (
    num_oco CHAR(5) REFERENCES orden_compra(num_oco),
    cod_pro CHAR(5) REFERENCES producto(cod_pro),
    can_det INT NOT NULL,
    PRIMARY KEY (num_oco, cod_pro)
);

-- Tabla ABASTECIMIENTO
CREATE TABLE abastecimiento (
    cod_prv CHAR(5) REFERENCES proveedor(cod_prv),
    cod_pro CHAR(5) REFERENCES producto(cod_pro),
    pre_aba NUMERIC(10,2),
    PRIMARY KEY (cod_prv, cod_pro)
);
