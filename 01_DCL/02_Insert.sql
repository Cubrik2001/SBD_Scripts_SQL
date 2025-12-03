-- =============================================
-- 1. INSERTAR PAÍSES
-- =============================================
INSERT INTO PAIS (id, nombre, continente, nacionalidad) VALUES (1, 'Hong Kong', 'Asia', 'Hongkonesa');
INSERT INTO PAIS (id, nombre, continente, nacionalidad) VALUES (2, 'México', 'América', 'Mexicana');
INSERT INTO PAIS (id, nombre, continente, nacionalidad) VALUES (3, 'Estados Unidos', 'América', 'Estadounidense');
INSERT INTO PAIS (id, nombre, continente, nacionalidad) VALUES (4, 'Polonia', 'Europa', 'Polaca');

-- =============================================
-- 2. INSERTAR ESTADOS
-- =============================================
-- Hong Kong
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (1, 1, 'Wan Chai District');
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (1, 2, 'Eastern District');
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (1, 3, 'Sai Kung District');
-- México
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (2, 1, 'Aguascalientes');
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (2, 2, 'Nuevo León');
-- Estados Unidos
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (3, 1, 'New York');
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (3, 2, 'New Jersey');
-- Polonia
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (4, 1, 'Mazowieckie');
INSERT INTO ESTADOS (id_pais, id, nombre) VALUES (4, 2, 'Slaskie');

-- =============================================
-- 3. INSERTAR CIUDADES
-- =============================================
-- Hong Kong
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (1, 1, 1, 'Causeway Bay');
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (1, 2, 1, 'Taikoo Shing');
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (1, 3, 1, 'Tseung Kwan O');
-- México
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (2, 1, 1, 'Aguascalientes');
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (2, 2, 1, 'Monterrey');
-- Estados Unidos
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (3, 1, 1, 'New York City');
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (3, 2, 1, 'Elizabeth');
-- Polonia
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (4, 1, 1, 'Warszawa');
INSERT INTO CIUDADES (id_pais, id_estado, id, nombre) VALUES (4, 2, 1, 'Katowice');

-- =============================================
-- 4. INSERTAR TIENDAS
-- =============================================
-- Hong Kong
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store Times Square', '+852 2110 3333', 'Shop 902-3C, 9/F, Times Square, 1 Matheson Street', 1, 1, 1);
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store Cityplaza', '+852 2568 0000', 'Shop 012, G/F, Cityplaza, 18 Taikoo Shing Road', 1, 2, 1);
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store Popcorn', '+852 2799 9999', 'Shop F40, 1/F, PopCorn 1, 9 Tong Yin Street', 1, 3, 1);
-- México
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store Altaria', '+52 449 123 4567', 'Blvd. a Zacatecas Nte. 845, Centro Comercial Altaria', 2, 1, 1);
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store Galerías Monterrey', '+52 81 8333 4444', 'Av Insurgentes 2500, Vista Hermosa, Monterrey', 2, 2, 1);
-- Estados Unidos
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store New York - Fifth Avenue', '+1 212-123-4567', '636 5th Ave, New York, NY 10020', 3, 1, 1);
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store The Mills At Jersey Gardens', '+1 908-555-0199', '651 Kapkowski Rd, Space 2000, Elizabeth, NJ 07201', 3, 2, 1);
-- Polonia
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store Warszawa', '+48 22 333 44 55', 'Al. Jana Pawla II 82, Westfield Arkadia, 00-175 Warszawa', 4, 1, 1);
INSERT INTO TIENDAS (nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)
VALUES ('LEGO® Store Katowice', '+48 32 444 55 66', '3 Maja 30, Galeria Katowicka, 40-097 Katowice', 4, 2, 1);
