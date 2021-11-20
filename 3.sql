/*
    @author  kenneth.cruz@unah.hn
    @version 0.1.0
    @date   11/19/2021
*/

/*

*/


-- Definición del paquete 
CREATE OR REPLACE PACKAGE PK_EMPLOYEES_20141010391
IS 
    FUNCTION FN_GET_AVG_PROP_20141010391(PROP_TYPE VARCHAR2) RETURN NUMBER;
    FUNCTION FN_GET_TOT_SALARY_20141010391(ID NUMBER) RETURN NUMBER;
END
;


-- Estructura y funcinoalidad
CREATE OR REPLACE PACKAGE BODY PK_EMPLOYEES_20141010391
IS 
    FUNCTION FN_GET_AVG_PROP_20141010391(PROP_TYPE VARCHAR2) 
    RETURN NUMBER
        IS 
            AVG_PROPERTIES PROPERTYS.PRICE%TYPE; 
        BEGIN 
            SELECT 
                AVG(PROPERTYS.PRICE)
                INTO AVG_PROPERTIES
            FROM 
                PROPERTYS
            WHERE 
                PROPERTYS.PROPERTY_TYPE = PROP_TYPE
            ;

            RETURN AVG_PROPERTIES;
        END 
    ;

    FUNCTION FN_GET_TOT_SALARY_20141010391(ID NUMBER) 
    RETURN NUMBER
        IS 
            TOTAL_SALARIES NUMBER;
        BEGIN 
            SELECT 
                SUM(EMPLOYEES.SALARY)
                INTO TOTAL_SALARIES
            FROM 
                EMPLOYEES
            INNER JOIN 
                JOBS ON EMPLOYEES.ID_JOBS = JOBS.ID_JOBS
            WHERE 
                JOBS.ID_JOBS = ID
            ;
            -- Faltó retornar valor :/
        END 
    ;

END 
;



-- 
-- Prueba del paquete
-- 

DECLARE
    -- Error dobe punto y coma
    AVG_PROPERTIES PROPERTYS.PRICE%TYPE; ;
    TOTAL_SALARIES EMPLOYEES.SALARY%TYPE;
BEGIN 

    AVG_PROPERTIES := PK_EMPLOYEES_20141010391.FN_GET_AVG_PROP_20141010391('Home');
    TOTAL_SALARIES := PK_EMPLOYEES_20141010391.FN_GET_TOT_SALARY_20141010391(1);

    DBMS_OUTPUT.PUT_LINE('Promedio de los precios de las propiedades de tipo *Home: ' || AVG_PROPERTIES);
    DBMS_OUTPUT.PUT_LINE('Suma total de salarios para empleados con trabajo (id_jobs) 1: ' || TOTAL_SALARIES);
END
;