-- =============================================
-- 1. INSERTAR PAISES
-- =============================================
-- ID 1: Hong Kong (Asia, No UE)
INSERT INTO PAISES (id, nombre, continente, nacionalidad, ue) VALUES (1, 'Hong Kong', 'AS', 'Hongkonesa', 'N');
-- ID 2: México (América, No UE)
INSERT INTO PAISES (id, nombre, continente, nacionalidad, ue) VALUES (2, 'México', 'AM', 'Mexicana', 'N');
-- ID 3: Estados Unidos (América, No UE)
INSERT INTO PAISES (id, nombre, continente, nacionalidad, ue) VALUES (3, 'Estados Unidos', 'AM', 'Estadounidense', 'N');
-- ID 4: Polonia (Europa, Si UE)
INSERT INTO PAISES (id, nombre, continente, nacionalidad, ue) VALUES (4, 'Polonia', 'EU', 'Polaca', 'S');
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
-- Estructura similar
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
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (1, 'LEGO® Store Times Square', '+852 2110 3333', 'Shop 902-3C, 9/F, Times Square, 1 Matheson Street', 1, 1, 1);
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (2, 'LEGO® Store Cityplaza', '+852 2568 0000', 'Shop 012, G/F, Cityplaza, 18 Taikoo Shing Road', 1, 2, 1);
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (3, 'LEGO® Store Popcorn', '+852 2799 9999', 'Shop F40, 1/F, PopCorn 1, 9 Tong Yin Street', 1, 3, 1);
-- México
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (4, 'LEGO® Store Altaria', '+52 449 123 4567', 'Blvd. a Zacatecas Nte. 845, Centro Comercial Altaria', 2, 1, 1);
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (5, 'LEGO® Store Galerías Monterrey', '+52 81 8333 4444', 'Av Insurgentes 2500, Vista Hermosa, Monterrey', 2, 2, 1);
-- Estados Unidos
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (6, 'LEGO® Store New York - Fifth Avenue', '+1 212-123-4567', '636 5th Ave, New York, NY 10020', 3, 1, 1);
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (7, 'LEGO® Store The Mills At Jersey Gardens', '+1 908-555-0199', '651 Kapkowski Rd, Space 2000, Elizabeth, NJ 07201', 3, 2, 1);
-- Polonia
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (8, 'LEGO® Store Warszawa', '+48 22 333 44 55', 'Al. Jana Pawla II 82, Westfield Arkadia, 00-175 Warszawa', 4, 1, 1);
INSERT INTO TIENDAS (id, nombre, nro_telefono, direccion, id_pais, id_estado, id_ciudad)VALUES (9, 'LEGO® Store Katowice', '+48 32 444 55 66', '3 Maja 30, Galeria Katowicka, 40-097 Katowice', 4, 2, 1);
-- =============================================
-- 5. INSERTAR PERSONAS (CLIENTES)
-- =============================================
-- Cliente 1: Andrés De Quintal (Venezuela/Mexico) - Grupo 5
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100001, 'Andres', 'David', 'De Quintal', 'Perez', 'andres.dq@mail.com', 'V12345678', TO_DATE('2001-05-15', 'YYYY-MM-DD'), 2, 2, 'P-MX-1001', TO_DATE('2030-01-01', 'YYYY-MM-DD'));
-- Cliente 2: Brian Reyes (USA) - Grupo 5
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100002, 'Brian', NULL, 'Reyes', 'Smith', 'brian.r@mail.com', 'US98765432', TO_DATE('2000-11-20', 'YYYY-MM-DD'), 3, 2, 'P-US-2002', TO_DATE('2029-05-15', 'YYYY-MM-DD'));
-- Cliente 3: Luis Loaiza (Hong Kong) - Grupo 5
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100003, 'Luis', 'Alberto', 'Loaiza', 'Gomez', 'luis.l@mail.com', 'HK556677', TO_DATE('2002-02-10', 'YYYY-MM-DD'), 1, 3, 'P-US-3003', TO_DATE('2032-08-20', 'YYYY-MM-DD'));
-- Cliente 4: Sebastián Pérez (Polonia) - Grupo 5
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100004, 'Sebastian', NULL, 'Perez', 'Kowalski', 'seb.p@mail.com', 'PL889900', TO_DATE('2001-07-30', 'YYYY-MM-DD'), 4, 4, 'P-PL-4004', TO_DATE('2031-12-12', 'YYYY-MM-DD'));
-- Cliente 5: Cliente Regular Hong Kong
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100005, 'Mei', 'Ling', 'Chen', 'Wong', 'mei.chen@hkmail.com', 'HK112233', TO_DATE('1990-03-25', 'YYYY-MM-DD'), 1, 1, 'P-HK-5005', TO_DATE('2028-06-30', 'YYYY-MM-DD'));
-- Cliente 6: Cliente Regular Mexico
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100006, 'Carlos', 'Eduardo', 'Sanchez', 'Ruiz', 'carlos.s@mxmail.com', 'MXINE4455', TO_DATE('1985-09-12', 'YYYY-MM-DD'), 2, 2, 'P-MX-6006', TO_DATE('2027-02-14', 'YYYY-MM-DD'));
-- Cliente 7: Cliente Regular USA
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100007, 'Emily', 'Rose', 'Johnson', 'Davis', 'emily.j@usmail.com', 'USSSN7788', TO_DATE('1995-12-05', 'YYYY-MM-DD'), 3, 3, 'P-US-7007', TO_DATE('2033-04-20', 'YYYY-MM-DD'));
-- Cliente 8: Cliente Regular Polonia
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100008, 'Jakub', NULL, 'Nowak', 'Wisniewski', 'jakub.n@plmail.com', 'PLPESEL99', TO_DATE('1988-01-18', 'YYYY-MM-DD'), 4, 4, 'P-PL-8008', TO_DATE('2026-10-10', 'YYYY-MM-DD'));
-- Cliente 9: Cliente Internacional (USA viviendo en Mexico)
INSERT INTO CLIENTES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, email, doc_identidad, fecha_nacimiento, id_pais_res, id_pais_nac, pasaporte, fecha_venc_pasa)
VALUES (100009, 'Robert', 'Alan', 'Miller', 'Taylor', 'rob.m@usmail.com', 'USPASS001', TO_DATE('1975-06-22', 'YYYY-MM-DD'), 2, 3, 'P-US-9009', TO_DATE('2025-12-31', 'YYYY-MM-DD'));
-- =============================================
-- 6. INSERTAR PERSONAS (VISITANTES MENORES)
-- =============================================
-- Hijo de Cliente 1 (Andres)
INSERT INTO VISITANTE_MENORES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, doc_identidad, fecha_nacimiento, pasaporte, id_pais_nac, id_cliente_repres, fecha_venc_pasa)
VALUES (200001, 'Santiago', NULL, 'De Quintal', 'Gomez', 'MENV111', TO_DATE('2015-08-08', 'YYYY-MM-DD'), 'PM-MX-01', 2, 100001, TO_DATE('2026-08-08', 'YYYY-MM-DD'));
-- Hija de Cliente 5 (Mei Chen)
INSERT INTO VISITANTE_MENORES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, doc_identidad, fecha_nacimiento, pasaporte, id_pais_nac, id_cliente_repres, fecha_venc_pasa)
VALUES (200002, 'Lily', NULL, 'Chen', 'Wong', 'MENHK222', TO_DATE('2018-04-12', 'YYYY-MM-DD'), 'PM-HK-02', 1, 100005, TO_DATE('2028-04-12', 'YYYY-MM-DD'));
-- Sobrino de Cliente 7 (Emily)
INSERT INTO VISITANTE_MENORES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, doc_identidad, fecha_nacimiento, pasaporte, id_pais_nac, id_cliente_repres, fecha_venc_pasa)
VALUES (200003, 'Noah', 'James', 'Williams', 'Davis', 'MENUS333', TO_DATE('2014-11-30', 'YYYY-MM-DD'), 'PM-US-03', 3, 100007, TO_DATE('2024-11-30', 'YYYY-MM-DD'));
-- Hija de Cliente 8 (Jakub)
INSERT INTO VISITANTE_MENORES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, doc_identidad, fecha_nacimiento, pasaporte, id_pais_nac, id_cliente_repres, fecha_venc_pasa)
VALUES (200004, 'Zofia', NULL, 'Nowak', 'Zielinska', 'MENPL444', TO_DATE('2016-02-14', 'YYYY-MM-DD'), 'PM-PL-04', 4, 100008, TO_DATE('2026-02-14', 'YYYY-MM-DD'));
-- Visitante sin representante registrado (Asumimos proceso especial o error, pero FK permite NULL si la lógica lo permite, aunque aquí insertaremos con FK para integridad)
INSERT INTO VISITANTE_MENORES (id_lego, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, doc_identidad, fecha_nacimiento, pasaporte, id_pais_nac, id_cliente_repres, fecha_venc_pasa)
VALUES (200005, 'Lucas', 'Daniel', 'Lopez', 'Garcia', 'MENMX555', TO_DATE('2013-09-19', 'YYYY-MM-DD'), 'PM-MX-05', 2, 100006, TO_DATE('2025-09-19', 'YYYY-MM-DD'));
-- =============================================
-- 7. INSERTAR JUGUETES_LEGO (Productos del Grupo 5)
-- =============================================
-- --- Tema: Powered Up ---
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (1, 'Grand Piano', 'Piano funcional que toca musica real', 'ADULTOS', 'D', 'S', NULL, 'instrucciones/21323.pdf', 3662);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (2, 'Audi RS Q e-tron', 'Vehiculo de rally electrico off-road', '9 A 11', 'C', 'S', NULL, 'instrucciones/42160.pdf', 914);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (3, 'Liebherr Crawler Crane LR 13000', 'Grua sobre orugas masiva con control', 'ADULTOS', 'D', 'S', NULL, 'instrucciones/42146.pdf', 2883);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (4, 'Express Passenger Train', 'Tren de pasajeros de alta velocidad', '7 A 8', 'C', 'S', NULL, 'instrucciones/60337.pdf', 764);
-- --- Tema: Ideas ---
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (5, 'LEGO Ideas Home Alone', 'Recreacion de la casa de la pelicula Home Alone', 'ADULTOS', 'D', 'S', NULL, 'instrucciones/21330.pdf', 3955);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (6, 'Disney Pixar Luxo Jr.', 'La famosa lampara de Pixar', '12P', 'B', 'S', NULL, 'instrucciones/21357.pdf', 500);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (7, 'Red London Telephone Box', 'Cabina telefonica iconica de Londres', 'ADULTOS', 'C', 'S', NULL, 'instrucciones/21347.pdf', 1460);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (8, 'Magic of Disney', 'Celebracion de la magia de Disney', '9 A 11', 'B', 'S', NULL, 'instrucciones/21352.pdf', 1103);
-- --- Tema: Jurassic World ---
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (9, 'Dinosaur Fossils: T-rex Skull', 'Craneo de Tiranosaurio Rex para exhibir', '9 A 11', 'B', 'S', NULL, 'instrucciones/76968.pdf', 577);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (10, 'Brick-Built Mosasaurus Boat', 'Mision en barco con Mosasaurio', '9 A 11', 'B', 'S', NULL, 'instrucciones/76974.pdf', 350);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (11, 'T. rex River Escape', 'Escape del rio jurasico', '7 A 8', 'B', 'S', NULL, 'instrucciones/76975.pdf', 400);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (12, 'Dinosaur Fossils: Triceratops', 'Craneo de Triceratops para armar', '9 A 11', 'B', 'S', NULL, 'instrucciones/76969.pdf', 469);
-- --- Tema: Sonic ---
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (13, 'Team Sonic Command Truck', 'Camion de comando de Sonic', '7 A 8', 'B', 'S', NULL, 'instrucciones/77006.pdf', 300);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (14, 'Shadow the Hedgehog', 'Cabeza detallada de Shadow', 'ADULTOS', 'B', 'S', NULL, 'instrucciones/77000.pdf', 720);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (15, 'Super Sonic vs. Egg Drillster', 'Batalla contra el taladro de Eggman', '7 A 8', 'B', 'S', NULL, 'instrucciones/76999.pdf', 590);
INSERT INTO JUGUETES_LEGO (id, nombre, descripcion, rango_edad, rango_precio, j_set, set_detalle, instrucciones, nro_piezas) 
VALUES (16, 'Cyclone vs. Metal Sonic', 'Avion tornado contra Metal Sonic', '7 A 8', 'A', 'S', NULL, 'instrucciones/77002.pdf', 250);
-- =============================================
-- 8. INSERTAR CATALOGO_PAISES
-- CORRECCIÓN: Columna 'id_juguete_lego' en vez de 'id_juguete'
-- =============================================
-- Hong Kong (1)
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (1, 1, 2);
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (1, 2, 5);
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (1, 5, 2); -- Home Alone
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (1, 14, 10); -- Shadow
-- México (2)
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (2, 1, 1);
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (2, 2, 3);
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (2, 9, 5); -- T-Rex Skull
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (2, 16, 5); -- Sonic Cyclone
-- Estados Unidos (3)
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) SELECT 3, id, 5 FROM JUGUETES_LEGO;
-- Polonia (4)
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (4, 3, 1); -- Crane
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (4, 7, 5); -- Telephone Box
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (4, 10, 5); -- Mosasaurus
INSERT INTO CATALOGO_PAISES (id_pais, id_juguete_lego, limite_compra) VALUES (4, 15, 5); -- Egg Drillster
-- =============================================
-- 9. INSERTAR HIST_PRECIOS (Precios actuales)
-- =============================================
-- Precios estimados basados en rango A, B, C, D
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (1, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 399.99); -- Piano (D)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (2, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 159.99); -- Audi (C)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (3, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 699.99); -- Crane (D)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (4, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 189.99); -- Train (C)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (5, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 299.99); -- Home Alone (D)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (6, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 69.99);  -- Luxo Jr (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (7, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 114.99); -- Phone Box (C)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (8, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 99.99);  -- Magic Disney (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (9, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 39.99);  -- Rex Skull (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (10, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 29.99); -- Mosasaurus (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (11, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 39.99); -- River Escape (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (12, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 34.99); -- Triceratops (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (13, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 49.99); -- Sonic Truck (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (14, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 69.99); -- Shadow (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (15, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 59.99); -- Egg Drillster (B)
INSERT INTO HIST_PRECIOS (id_juguete, fecha_inicio, fecha_fin, precio) VALUES (16, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 29.99); -- Metal Sonic (A/B)
-- =============================================
-- 10. INSERTAR PRODUCTOS_RELACION
-- =============================================
-- Relacionar productos Sonic
INSERT INTO PRODUCTOS_RELACION (id_juguete_a, id_juguete_b) VALUES (13, 15); -- Truck vs Drillster
INSERT INTO PRODUCTOS_RELACION (id_juguete_a, id_juguete_b) VALUES (15, 16); -- Drillster vs Metal Sonic
-- Relacionar productos Jurassic
INSERT INTO PRODUCTOS_RELACION (id_juguete_a, id_juguete_b) VALUES (9, 12); -- T-Rex Skull vs Triceratops Skull
INSERT INTO PRODUCTOS_RELACION (id_juguete_a, id_juguete_b) VALUES (10, 11); -- Boat vs River Escape
-- Relacionar Ideas
INSERT INTO PRODUCTOS_RELACION (id_juguete_a, id_juguete_b) VALUES (6, 8); -- Luxo Jr vs Magic Disney


