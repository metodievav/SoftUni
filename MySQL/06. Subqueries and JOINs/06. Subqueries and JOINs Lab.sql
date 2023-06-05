#1
SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name) AS 'full_name',
    d.department_id,
    d.name AS 'depatment_name'
FROM
    employees AS e
        JOIN
    departments AS d ON d.manager_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;

#2
SELECT 
    t.town_id, t.name AS 'town_name', a.address_text
FROM
    addresses AS a
        JOIN
    towns AS t ON a.town_id = t.town_id
WHERE
    t.name IN ('San Francisco' , 'Sofia', 'Carnation')
ORDER BY t.town_id;

#3
SELECT 
    employee_id, first_name, last_name, department_id, salary
FROM
    employees
WHERE
    manager_id IS NULL;
    
#4
SELECT 
    COUNT(e.employee_id) AS 'count'
FROM
    employees AS e
WHERE
    e.salary > (SELECT 
            AVG(salary) AS salary
        FROM
            employees);