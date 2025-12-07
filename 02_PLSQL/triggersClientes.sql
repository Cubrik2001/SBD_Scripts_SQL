CREATE OR REPLACE TRIGGER trg_bi_valida_pasaporte_cliente
BEFORE INSERT OR UPDATE ON CLIENTES
FOR EACH ROW
BEGIN
    -- Solo validamos si el usuario ingresó una fecha de vencimiento
    IF :NEW.fecha_venc_pasa IS NOT NULL THEN
        -- Si la fecha de vencimiento es MENOR a hoy (TRUNC quita la hora), es error
        IF :NEW.fecha_venc_pasa < TRUNC(SYSDATE) THEN
            RAISE_APPLICATION_ERROR(-20030, 
                'Error de Documentación: El pasaporte del cliente ' || :NEW.primer_nombre || 
                ' está vencido (Vence: ' || TO_CHAR(:NEW.fecha_venc_pasa, 'DD/MM/YYYY') || ').');
        END IF;
        
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_bi_valida_pasaporte_menor
BEFORE INSERT OR UPDATE ON VISITANTE_MENORES
FOR EACH ROW
BEGIN
    IF :NEW.fecha_venc_pasa IS NOT NULL THEN
        IF :NEW.fecha_venc_pasa < TRUNC(SYSDATE) THEN
            RAISE_APPLICATION_ERROR(-20031, 
                'Error de Documentación: El pasaporte del visitante menor ' || :NEW.primer_nombre || 
                ' está vencido.');
        END IF;
    END IF;
END;
/