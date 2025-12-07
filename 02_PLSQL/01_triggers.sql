/* ==========================================
   ARCHIVO: 01_triggers.sql
   DESCRIPCIÓN: Validaciones de negocio
   ========================================== */
-- PARTE 3 Triggers de venta fisica 
CREATE OR REPLACE TRIGGER trg_bi_fact_tienda_cliente
BEFORE INSERT ON FACTURAS_TIENDA
FOR EACH ROW
DECLARE
    v_fecha_nacimiento DATE;
BEGIN
    -- 1. Obtenemos la fecha de nacimiento del cliente que se está intentando usar en la factura
    SELECT fecha_nacimiento 
    INTO v_fecha_nacimiento
    FROM CLIENTES
    WHERE id_lego = :NEW.id_cliente_lego;

    -- 2. Validamos la edad.
    -- Usamos ADD_MONTHS para sumar 21 años (21 * 12 meses) a la fecha de nacimiento.
    -- Si la fecha resultante es mayor a la fecha actual (TRUNC(SYSDATE)), 
    -- significa que aún no ha cumplido los 21.
    IF ADD_MONTHS(v_fecha_nacimiento, 21 * 12) > TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error: El cliente titular debe tener al menos 21 años para realizar esta compra.');
    END IF;

EXCEPTION
    -- Manejo de error por si el ID de cliente no existe (aunque la FK lo detectaría después, es buena práctica)
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error: El cliente especificado no existe en la base de datos.');
END;
/

CREATE OR REPLACE TRIGGER trg_bi_det_tienda_limite
BEFORE INSERT ON DETALLES_FACTURA_TIENDA
FOR EACH ROW
DECLARE
    v_id_pais_tienda    NUMBER(3);
    v_id_cliente        NUMBER(6);
    v_limite_permitido  NUMBER(2);
    v_cantidad_historia NUMBER(5);
    v_nombre_juguete    VARCHAR2(40);
BEGIN
    -- 1. Obtener el País de la tienda y el Cliente de la factura
    --    (Necesitamos cruzar FACTURAS_TIENDA y TIENDAS)
    BEGIN
        SELECT t.id_pais, f.id_cliente_lego
        INTO v_id_pais_tienda, v_id_cliente
        FROM FACTURAS_TIENDA f
        JOIN TIENDAS t ON f.id_tienda = t.id
        WHERE f.nro_factura = :NEW.nro_factura_t
          AND f.id_tienda = :NEW.id_tienda_c;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Error: No se encuentra la factura o tienda asociada.');
    END;

    -- 2. Obtener el Límite de compra definido en el Catálogo de ese país
    BEGIN
        SELECT limite_compra
        INTO v_limite_permitido
        FROM CATALOGO_PAISES
        WHERE id_pais = v_id_pais_tienda
          AND id_juguete_lego = :NEW.id; -- Asumimos que :NEW.id es el ID del producto
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Si no está en el catálogo, asumimos límite 0 (no se puede vender) 
            -- o podrías dejarlo pasar. Aquí asumiremos que NO se puede vender.
            RAISE_APPLICATION_ERROR(-20004, 'Error: Este producto no está habilitado para venta en el país de la tienda.');
    END;

    -- 3. Calcular cuánto ha comprado YA este cliente de este producto anteriormente
    SELECT NVL(SUM(d.cantidad), 0)
    INTO v_cantidad_historia
    FROM DETALLES_FACTURA_TIENDA d
    JOIN FACTURAS_TIENDA f ON d.nro_factura_t = f.nro_factura AND d.id_tienda_c = f.id_tienda
    WHERE f.id_cliente_lego = v_id_cliente
      AND d.id = :NEW.id;

    -- 4. Validar: (Lo que ya compró + lo que quiere comprar ahora) > Límite
    IF (v_cantidad_historia + :NEW.cantidad) > v_limite_permitido THEN
        
        -- (Opcional) Obtenemos el nombre del juguete para un mensaje de error más bonito
        SELECT nombre INTO v_nombre_juguete FROM JUGUETES_LEGO WHERE id = :NEW.id;

        RAISE_APPLICATION_ERROR(-20005, 
            'Error de Límite: El cliente ' || v_id_cliente || 
            ' intenta acumular ' || (v_cantidad_historia + :NEW.cantidad) || 
            ' unidades de "' || v_nombre_juguete || 
            '", pero el límite en este país es de ' || v_limite_permitido || '.');
    END IF;

END;
/
-- PARTE 4 Triggers de Venta online


-- PARTE 5 Triggers de historico de precios 

CREATE OR REPLACE TRIGGER trg_bi_hist_precio_fechas
FOR INSERT ON HIST_PRECIOS
COMPOUND TRIGGER

    -- Declaramos una colección para guardar los IDs de los juguetes que estamos insertando
    TYPE t_juguete_list IS TABLE OF HIST_PRECIOS.id_juguete%TYPE INDEX BY PLS_INTEGER;
    v_juguetes t_juguete_list;
    v_idx PLS_INTEGER := 0;

    -- =========================================================
    -- PASO 1: BEFORE EACH ROW
    -- Preparamos la NUEVA fila para que entre limpia
    -- =========================================================
    BEFORE EACH ROW IS
    BEGIN
        -- 1. Forzamos que la fecha de inicio sea la fecha actual (sin hora para facilitar consultas)
        :NEW.fecha_inicio := TRUNC(SYSDATE);
        
        -- 2. Forzamos que la fecha fin sea NULL (es el precio vigente)
        :NEW.fecha_fin := NULL;

        -- 3. Guardamos el ID del juguete en memoria para procesar el cierre del precio viejo después
        v_idx := v_idx + 1;
        v_juguetes(v_idx) := :NEW.id_juguete;
    END BEFORE EACH ROW;

    -- =========================================================
    -- PASO 2: AFTER STATEMENT
    -- Cerramos los precios VIEJOS (Aquí ya es seguro hacer UPDATE)
    -- =========================================================
    AFTER STATEMENT IS
    BEGIN
        FOR i IN 1 .. v_idx LOOP
            UPDATE HIST_PRECIOS
            SET fecha_fin = TRUNC(SYSDATE)
            WHERE id_juguete = v_juguetes(i)   -- Buscamos el juguete
              AND fecha_fin IS NULL            -- Que esté abierto actualmente
              AND fecha_inicio < TRUNC(SYSDATE); -- IMPORTANTE: Que no sea el que acabamos de insertar
        END LOOP;
    END AFTER STATEMENT;

END trg_bi_hist_precio_fechas;
/


















/* ==========================================
  
   DESCRIPCIÓN: TRIGGERS ANTIGUOS (NO SE SI LOS VAMOS A USAR TAMBIEN)
   ========================================== */





-- Trigger 1: Validar Cliente (Edad > 21)
CREATE OR REPLACE TRIGGER TRG_VALIDAR_EDAD_CLIENTE
BEFORE INSERT OR UPDATE ON CLIENTES
FOR EACH ROW
DECLARE
    v_edad NUMBER;
BEGIN
    -- Se calcula la edad exacta dividiendo meses / 12
    v_edad := TRUNC(MONTHS_BETWEEN(SYSDATE, :NEW.fecha_nacimiento) / 12);
    
    IF v_edad <= 21 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El Cliente debe ser mayor de 21 años. Edad calculada: ' || v_edad);
    END IF;
END;
/

-- Trigger 2: Validar Visitante (12-20 años y Representante)
CREATE OR REPLACE TRIGGER TRG_VALIDAR_VISITANTE
BEFORE INSERT OR UPDATE ON VISITANTES
FOR EACH ROW
DECLARE
    v_edad NUMBER;
BEGIN
    v_edad := TRUNC(MONTHS_BETWEEN(SYSDATE, :NEW.fecha_nacimiento) / 12);

    -- Regla A: El visitante debe tener entre 12 y 20 años (menor a 21)
    IF v_edad < 12 OR v_edad >= 21 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El Visitante debe tener entre 12 y 20 años. Edad calculada: ' || v_edad);
    END IF;

    -- Regla B: Si es menor de 18, REQUIERE representante
    IF v_edad < 18 THEN
        IF :NEW.id_cliente_repres IS NULL THEN
            RAISE_APPLICATION_ERROR(-20003, 'El visitante menor de edad (' || v_edad || ' años) debe tener un representante asignado.');
        END IF;
    END IF;
    
    -- Regla C: Si es >= 18, el representante es opcional (No hacemos nada, Oracle permite NULL por defecto)
END;
/
