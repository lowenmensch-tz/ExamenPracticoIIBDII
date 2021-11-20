/*
    @author  kenneth.cruz@unah.hn
    @version 0.1.0
    @date   11/19/2021
*/

/*
    Crear un procedimiento almacenado que haga el llamado a la función creada en el inciso 1, 
    dentro del cuerpo del procedimiento se debe verificar que si el salario de los empleados es menor o igual que 15,000 
    entonces se le hará un aumento salarial del 10%. 
    El procedimiento debe aprobar los cambios o deshacerlos en caso de cualquier error. 
    También el procedimiento debe imprimir cuántos salarios de empleados fueron actualizados. (valor 15%)
*/


-- Actualiza el salario del empleado sí el salario es <= 15000
CREATE OR REPLACE PROCEDURE SP_INSERT_DATA_20141010391(
    ID EMPLOYEES.ID_EMPLOYEE%TYPE,
    SALARY EMPLOYEES.SALARY%TYPE,
    MESSAGE OUT NUMBER, 
    MESSAGE_ERR OUT VARCHAR2
)
IS 
BEGIN 

    IF(SALARY <= 15000) THEN 

        UPDATE EMPLOYEES
        SET  EMPLOYEES.SALARY = SALARY*1.10
        WHERE EMPLOYEES.ID_EMPLOYEE = ID;

        MESSAGE:=1;
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            MESSAGE:=0;
            MESSAGE_ERR:=SQLERRM;
END
;



CREATE OR REPLACE PROCEDURE SP_CALL_FNEMPLOYEE_20141010391(
    ADDRESS BRANCH_OFFICE.ADDRESS_BO%TYPE
)
IS 
    DATA SYS_REFCURSOR; 
    ID EMPLOYEES.ID_EMPLOYEE%TYPE; 
    SALARY EMPLOYEES.SALARY%TYPE;
    FLAG NUMBER; 
    MESSAGE NUMBER;
    MESSAGE_ERR VARCHAR2(255);
BEGIN 
    FLAG := 0;
    DATA := FN_GET_EMPLOYEE_20141010391(ADDRESS);
    LOOP
        FETCH DATA INTO ID, SALARY;
        EXIT WHEN DATA%NOTFOUND;

            SP_INSERT_DATA_20141010391(ID, SALARY, MESSAGE, MESSAGE_ERR);

            IF (MESSAGE=0) THEN
                DBMS_OUTPUT.PUT_LINE('No se pudo insertar el registro: ' || MESSAGE_ERR);
                ROLLBACK;
                
            ELSE
                DBMS_OUTPUT.PUT_LINE('Registro procesado exitosamente');
                FLAG:= FLAG + MESSAGE;
                COMMIT;
            END IF;
            
            MESSAGE:=0;
            
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total registros actualizados: ' || FLAG);

END 
;


EXECUTE SP_CALL_FNEMPLOYEE_20141010391('21 Hermina Trail');