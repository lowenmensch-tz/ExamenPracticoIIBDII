/*
    @author  kenneth.cruz@unah.hn
    @version 0.1.0
    @date   11/19/2021
*/

/*
    Crear una función que obtenga y retorne todos los empleados asignados a la sucursal 
    “21 Hermina Trail”. Se desea retornar solamente el id de empleado y el salario. 
    (valor 10%)
*/

CREATE OR REPLACE FUNCTION FN_GET_EMPLOYEE_20141010391(ADDRESS_OFFICE VARCHAR2)
RETURN SYS_REFCURSOR
    IS 
        CURSOR_EMPLOYEE SYS_REFCURSOR
    BEGIN 
        OPEN CURSOR_EMPLOYEE FOR 
            SELECT 
                EMPLOYEES.ID_EMPLOYEE, 
                EMPLOYEES.SALARY 
            FROM 
                EMPLOYEES
            INNER JOIN 
                BRANCH_OFFICE ON EMPLOYEES.ID_BOFFICE = BRANCH_OFFICE.ID_BOFFICE
            WHERE 
                BRANCH_OFFICE.ADDRESS_BO = ADDRESS_OFFICE
            ; 
        
        RETURN CURSOR_EMPLOYEE;
    END 
;


--
-- Visualizar los datos de los animales
--

DECLARE
    DATA SYS_REFCURSOR;
    ID EMPLOYEES.ID_EMPLOYEE%TYPE; 
    SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    DATA := FN_GET_EMPLOYEE_20141010391('21 Hermina Trail');
    LOOP
        FETCH DATA INTO ID, SALARY;
        EXIT WHEN DATA%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
        DBMS_OUTPUT.PUT_LINE('ID: ' || ID);
        DBMS_OUTPUT.PUT_LINE('Salario: ' || SALARY);
        DBMS_OUTPUT.PUT_LINE(CHR(13));
        DBMS_OUTPUT.PUT_LINE(CHR(13));
    END LOOP;
END
;
