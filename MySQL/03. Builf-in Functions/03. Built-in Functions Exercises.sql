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
        AND YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;


-- 4
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    job_title NOT LIKE '%engineer%';
 
 -- 5
SELECT 
    name
FROM
    towns
WHERE
    LENGTH(name) = 5 OR LENGTH(name) = 6
ORDER BY name;

-- 6
SELECT 
    *
FROM
    towns
WHERE
    LEFT(name, 1) LIKE 'B%'
        OR LEFT(name, 1) LIKE 'M%'
        OR LEFT(name, 1) LIKE 'K%'
        OR LEFT(name, 1) LIKE 'E%'
ORDER BY name;

-- 7
SELECT 
    *
FROM
    towns
WHERE
    name NOT LIKE 'R%'
        AND name NOT LIKE 'B%'
        AND name NOT LIKE 'D%'
ORDER BY name;
 
 -- 8
 CREATE VIEW v_employees_hired_after_2000 AS
 SELECT 
    first_name, last_name
FROM
    employees
WHERE YEAR(hire_date) > 2000;

-- 9
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    CHAR_LENGTH(last_name) = 5;
    
-- 10
USE geography;

SELECT 
    country_name, iso_code
FROM
    countries
WHERE
    country_name LIKE '%a%a%a%'
ORDER BY iso_code;

-- 11

SELECT 
    p.peak_name,
    r.river_name,
    LOWER(CONCAT(p.peak_name, SUBSTRING(r.river_name, 2))) AS 'mix'
FROM
    peaks AS p,
    rivers AS r
WHERE
    LOWER(RIGHT(p.peak_name, 1) = LEFT(r.river_name, 1))
ORDER BY mix;

-- 12
USE diablo;

SELECT 
    name, DATE_FORMAT(start, '%Y-%m-%d') AS 'start'
FROM
    games
WHERE
    YEAR(start) IN (2011 , 2012)
ORDER BY start, name
LIMIT 50;


