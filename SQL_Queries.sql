create database employee;
use employee;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table
ORDER BY DEPT, FIRST_NAME;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
FROM emp_record_table
WHERE EMP_RATING  < 2;


SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
FROM emp_record_table
WHERE EMP_RATING > 4;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
FROM emp_record_table
WHERE (EMP_RATING BETWEEN 2 AND 4)

select CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT= 'FINANCE';

SELECT
    m.EMP_ID,
    m.FIRST_NAME,
    COUNT(*) AS REPORTERS
FROM emp_record_table e
JOIN emp_record_table m
    ON e.MANAGER_ID = m.EMP_ID
GROUP BY m.EMP_ID, m.FIRST_NAME;



SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table
WHERE DEPT = 'Healthcare'

UNION

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table
WHERE DEPT = 'Finance';

SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    ROLE,
    DEPT,
    EMP_RATING,
    MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_RATING
FROM 
    emp_record_table;
    
SELECT 
    ROLE,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY
FROM 
    emp_record_table
GROUP BY 
    ROLE;
    
SELECT 
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    ROLE, 
    DEPT, 
    EXP,
    DENSE_RANK() OVER (ORDER BY EXP DESC) AS EXPERIENCE_RANK
FROM 
    emp_record_table;
    
CREATE VIEW Employees_Salary_Above_6000 AS
SELECT 
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    ROLE, 
    DEPT, 
    COUNTRY, 
    SALARY
FROM 
    emp_record_table
WHERE 
    SALARY > 6000;
    
SELECT * FROM Employees_Salary_Above_6000;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP
FROM emp_record_table
WHERE EXP = ANY (
    SELECT EXP
    FROM emp_record_table
    WHERE EXP > 10
);

DELIMITER //

CREATE PROCEDURE GetEmployeesWithExperience()
BEGIN
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP, SALARY
    FROM emp_record_table
    WHERE EXP > 3;
END //

DELIMITER ;

CALL GetEmployeesWithExperience();

DELIMITER //

CREATE FUNCTION employee_job_profile(EXP INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE standard_role VARCHAR(50);
    
    IF EXP <= 2 THEN
        SET standard_role = 'JUNIOR DATA SCIENTIST';
    ELSEIF EXP <=5 THEN
        SET standard_role = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF EXP <=10 THEN
        SET standard_role = 'SENIOR DATA SCIENTIST';
    ELSEIF EXP <=12 THEN
        SET standard_role = 'LEAD DATA SCIENTIST';
    ELSEIF EXP <=16 THEN
        SET standard_role = 'MANAGER';
    END IF;
    RETURN standard_role;
END //
DELIMITER ;

SELECT 
	e.emp_id,
    e.first_name,
    e.last_name,
    e.role AS Assigned_Role,
    employee_job_profile(e.EXP) AS Expected_Role,
    CASE 
        WHEN e.role = employee_job_profile(e.EXP) THEN 'MATCHES'
        ELSE 'DOES NOT MATCH'
    END AS Role_Match_Status
FROM 
     data_science_team e;
     
explain select EMP_ID, FIRST_NAME, LAST_NAME
from emp_record_table
where FIRST_NAME = 'Eric';

create index idx_first_name on emp_record_table(FIRST_NAME);

explain select EMP_ID, FIRST_NAME, LAST_NAME
from emp_record_table
where FIRST_NAME = 'Eric';
 

select EMP_ID, FIRST_NAME, LAST_NAME,
ROLE, DEPT, EXP, SALARY, EMP_RATING,
(0.05*SALARY) * EMP_RATING AS Bonus
from emp_record_table;

SELECT 
    continent, 
    country, 
    AVG(salary) AS avg_salary
FROM 
    emp_record_table
GROUP BY 
    continent, 
    country
ORDER BY 
    continent, 
    country;