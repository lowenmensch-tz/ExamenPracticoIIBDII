/*
    @author  kenneth.cruz@unah.hn
    @version 0.1.0
    @date   11/19/2021
*/

/*
    Crear un procedimiento que retorne todas las propiedades del tipo “Apartment” 
    y cuyo precio sea mayor o igual al promedio de los precios de dichas propiedades. 
    
    Mediante un bloque anónimo imprimir los datos que retorna el procedimiento. 
    Si el procedimiento no retorna nada, entonces el bloque anónimo tendrá que indicar que no hay datos. 
    (valor 15%)
*/


CREATE OR REPLACE PROCEDURE SP_GET_PROPERTYS_20141010391(
    PROP_TYPE PROPERTYS.PROPERTY_TYPE%TYPE, 
    PROPERTY_CURSOR OUT SYS_REFCURSOR
)
IS 

BEGIN 

    OPEN PROPERTY_CURSOR FOR 
        SELECT 
            * 
        FROM 
            PROPERTYS
        WHERE 
            PROPERTYS.PROPERTY_TYPE = PROP_TYPE AND 
            PROPERTYS.PRICE >=
            (
                SELECT 
                    AVG(PROPERTYS.PRICE)        
                FROM 
                    PROPERTYS
            )
        ;
END
;


DECLARE
    DATA SYS_REFCURSOR;
    MAPPING_PROPERTYS PROPERTYS%ROWTYPE;
BEGIN
    
    SP_GET_PROPERTYS_20141010391('Apartment', DATA);

    LOOP
        FETCH DATA INTO MAPPING_PROPERTYS;
        EXIT WHEN DATA%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
        DBMS_OUTPUT.PUT_LINE('ID: ' || MAPPING_PROPERTYS.ID_PROPERTY);
        DBMS_OUTPUT.PUT_LINE('NIF: ' || MAPPING_PROPERTYS.NIF_PROPERTY);
        DBMS_OUTPUT.PUT_LINE('Dirección: ' || MAPPING_PROPERTYS.ADDRESS_PROP);
        DBMS_OUTPUT.PUT_LINE('Coordenadas: ' || MAPPING_PROPERTYS.GEOGRAPHICAL_COORDS);
        DBMS_OUTPUT.PUT_LINE('Fecha de construcción: ' || MAPPING_PROPERTYS.BUILDING_DATE);
        DBMS_OUTPUT.PUT_LINE('Fecha de venta: ' || MAPPING_PROPERTYS.PUBLICATION_DATE_SALE);
        DBMS_OUTPUT.PUT_LINE('Tipo de propiedad: ' || MAPPING_PROPERTYS.PROPERTY_TYPE);
        DBMS_OUTPUT.PUT_LINE('Id sup: ' || MAPPING_PROPERTYS.ID_SUP);
        DBMS_OUTPUT.PUT_LINE('Precio: ' || MAPPING_PROPERTYS.PRICE);
        DBMS_OUTPUT.PUT_LINE(CHR(13));
        DBMS_OUTPUT.PUT_LINE(CHR(13));
    END LOOP;
END
;









