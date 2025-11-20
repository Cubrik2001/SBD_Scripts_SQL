/* ==========================================
   ARCHIVO: 01_triggers.sql
   DESCRIPCIÓN: Validaciones de negocio
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