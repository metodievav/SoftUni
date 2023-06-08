USE soft_uni;

# 1
DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
RETURN (
	SELECT COUNT(*) AS 'count'
	FROM employees AS e
			JOIN addresses AS a ON e.address_id = a.address_id
			JOIN towns AS t ON a.town_id = t.town_id
	WHERE t.name = town_name
    );
END$$
DELIMITER ;
;

SELECT ufn_count_employees_by_town_name('Sofia');

# 2
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
	UPDATE employees AS e
        JOIN departments AS d ON e.department_id = d.department_id 
	SET salary = salary * 1.05
	WHERE d.name = department_name;
END$$
DELIMITER ;
;

CALL usp_raise_salaries('Finance');

# 3
DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	DECLARE employee_id_count INT;
    SET  employee_id_count := (SELECT COUNT(*) FROM employees WHERE employee_id = id);
    
    IF (employee_id_count = 1)
	THEN
	UPDATE employees SET salary = salary * 1.05 WHERE employee_id = id;
    END IF;
END$$
DELIMITER ;
;

# 4
CREATE TABLE deleted_employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_name VARCHAR(50),
    job_title VARCHAR(50),
    department_id INT,
    salary DECIMAL(19, 4)
);

DELIMITER $$
CREATE TRIGGER tr_after_delete_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees (first_name, middle_name, last_name, job_title, department_id, salary)
    VALUES (
    OLD.employee_id,
    OLD.first_name,
    OLD.last_name,
    OLD.middle_name,
    OLD.job_title,
    OLD.department_id,
    OLD.salary
    );
END$$
DELIMITER ;
;
