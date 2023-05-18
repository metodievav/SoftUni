USE soft_uni;

-- 1
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    first_name LIKE 'Sa%'
ORDER BY employee_id;

-- 2
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    last_name LIKE '%ei%'
ORDER BY employee_id;

-- 3
SELECT 
    first_name
FROM
    employees
WHERE
    department_id IN (3 , 10)
        AND CAST(hire_date AS YEAR) BETWEEN '1995' AND '2005'
ORDER BY employee_id;


-- 4
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    job_title NOT LIKE '%engineer%';
 
 
 
 
