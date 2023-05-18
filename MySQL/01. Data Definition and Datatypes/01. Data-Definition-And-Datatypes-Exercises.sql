CREATE DATABASE minions;
USE minions;

-- 1
CREATE TABLE minions(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
age INT
); 

CREATE TABLE towns(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);

-- 2
ALTER TABLE minions
ADD COLUMN town_id INT;

ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY minions(town_id)
REFERENCES towns(id);

-- 3
INSERT INTO towns (id, name)
VALUES (1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');

INSERT INTO minions (id, name, age, town_id)
VALUES (1, 'Kevin', 22, 1), (2, 'Bob', 15, 3), (3, 'Steward', null, 2);

-- 4
TRUNCATE TABLE minions;

-- 5
DROP TABLE minions;
DROP TABLE towns;

-- 6
CREATE TABLE people (
id INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
picture BLOB,
height DOUBLE(5,2),
weight DOUBLE(5,2),
gender CHAR(1) NOT NULL,
birthdate DATETIME NOT NULL,
biography TEXT
);

INSERT INTO people (id, name, gender, birthdate)
VALUES (1, 'First', 'm', NOW()), (2, 'Second', 'm', NOW()), (3, 'Third', 'f', NOW()),
(4, 'Forth', 'f', NOW()), (5, 'Fifth', 'm', NOW());

-- 7
CREATE TABLE users (
id INT PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(50) UNIQUE NOT NULL,
password VARCHAR(26) NOT NULL,
profile_picture BLOB,
last_login_time DATETIME,
is_deleted BOOLEAN
);

INSERT INTO users (username, password)
VALUES ('First user', '123'), ('Second user', 'asd'),
('Third user', 'abc'), ('Forth user', '1234'), ('Fifth user', '12345');

-- 8
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id, username);

-- 9
ALTER TABLE users
CHANGE COLUMN last_login_time
last_login_time DATETIME DEFAULT NOW();

-- 10
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id);

ALTER TABLE users
CHANGE COLUMN username
username VARCHAR(50) UNIQUE NOT NULL;

-- 11
CREATE DATABASE movies;
USE movies;

CREATE TABLE directors (
id INT PRIMARY KEY AUTO_INCREMENT,
director_name VARCHAR(50) NOT NULL,
notes TEXT
);

INSERT INTO directors (director_name)
VALUES ('Bob'),  ('Steve'), ('Josh'), ('Mark'), ('Dave');

CREATE TABLE genres (
id INT PRIMARY KEY AUTO_INCREMENT,
genre_name VARCHAR(50) NOT NULL,
notes TEXT
);

INSERT INTO genres (genre_name)
VALUES ('horror'),  ('romance'), ('comedy'), ('drama'), ('fantasy');

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(50) NOT NULL,
notes TEXT
);

INSERT INTO categories (category_name)
VALUES ('first'),  ('second'), ('third'), ('forth'), ('fifth');

CREATE TABLE movies (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
director_id INT,
copyright_year YEAR,
length DOUBLE(10,2),
genre_id INT,
category_id INT,
rating DOUBLE(5,2),
notes TEXT,
FOREIGN KEY fk_movies_directors (director_id)
REFERENCES directors(id),
FOREIGN KEY fk_movies_genres (genre_id)
REFERENCES genres(id),
FOREIGN KEY fk_movies_category (category_id)
REFERENCES categories(id)
);

INSERT INTO movies (title, director_id, category_id, genre_id)
VALUES ('Chicago Typewriter', 1, 2, 3),
  ('Carrie',  3, 3, 4), ('NFS',  5, 1, 2),
  ('TEST',  2, 1, 5), ('The Last Of Us',  4, 4, 1);

-- 12
CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
category VARCHAR(50) NOT NULL,
daily_rate DOUBLE(10,2),
weekly_rate DOUBLE(10,2),
monthly_rate DOUBLE(10,2),
weekend_rate DOUBLE (10,2)
);

INSERT INTO categories (category)
VALUES ('low'), ('normal'), ('premium');

CREATE TABLE cars (
id INT PRIMARY KEY AUTO_INCREMENT,
plate_number VARCHAR(50) NOT NULL,
make VARCHAR(50),
model VARCHAR(50),
car_year YEAR,
category_id INT,
doors INT,
picture BLOB,
car_condition VARCHAR(10),
available BOOLEAN
);

INSERT INTO cars (plate_number)
VALUES ('ABC'), ('DEF'), ('GHI');

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
title VARCHAR(50),
notes TEXT
);

INSERT INTO employees (first_name, last_name)
VALUES ('A', 'B'), ('C', 'D'), ('E', 'F');

CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
driver_licence_number INT,
full_name  VARCHAR(50) NOT NULL,
address  VARCHAR(50),
city VARCHAR(50),
zip_code VARCHAR(50),
notes TEXT
);

INSERT INTO customers (full_name)
VALUES ('A'), ('B'), ('C');

CREATE TABLE rental_orders (
id INT PRIMARY KEY AUTO_INCREMENT,
employee_id INT,
customer_id INT,
car_id INT,
car_condition VARCHAR(10),
tank_level DOUBLE (10,2),
kilometrage_start DOUBLE (10,2),
kilometrage_end DOUBLE (10,2),
total_kilometrage DOUBLE (10,2),
start_date DATETIME,
end_date DATETIME,
total_days INT,
rate_applied  DOUBLE (10,2),
tax_rate  DOUBLE (10,2),
order_status BOOLEAN,
notes TEXT,
FOREIGN KEY fk_rental_orders_employees(employee_id)
REFERENCES employees(id),
FOREIGN KEY fk_rental_orders_customer(customer_id)
REFERENCES customers(id),
FOREIGN KEY fk_rental_orders_cars(car_id)
REFERENCES cars(id)
-- FOREIGN KEY fk_rental_orders_cars2(car_condition)
-- REFERENCES cars(car_condition)
);

INSERT INTO rental_orders (employee_id, customer_id, car_id)
VALUES (1,1,1), (2,3,3), (3,2,2); 

-- 13
CREATE DATABASE softuni;
USE softuni;

CREATE TABLE towns (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

INSERT INTO towns (name)
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

CREATE TABLE addresses (
id INT PRIMARY KEY AUTO_INCREMENT,
address_text VARCHAR(255) NOT NULL,
town_id INT,
FOREIGN KEY fk_adresses_towns (town_id)
REFERENCES towns (id)
);

CREATE TABLE departments (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

INSERT INTO departments (name)
VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance');

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
middle_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
job_title VARCHAR(50),
department_id INT,
hire_date VARCHAR(50),
salary DOUBLE (10,2),
address_id INT,
FOREIGN KEY fk_employees_department (department_id)
REFERENCES departments (id),
FOREIGN KEY fk_employees_addresses (address_id)
REFERENCES addresses (id)
);

INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '01/02/2013', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '02/03/2004', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 6, '28/08/2016', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'Terziev', 2, '09/12/2007', 3000.00),
('Petar', 'Pan', 'Pan', 'Intern', 3, '28/08/2016 5', 599.88);

-- 14
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

-- 15
SELECT * FROM towns ORDER BY towns.name;
SELECT * FROM departments AS d ORDER BY d.name;
SELECT * FROM employees AS e ORDER BY e.salary DESC;

-- 16
SELECT towns.name FROM towns ORDER BY towns.name;
SELECT d.name FROM departments AS d ORDER BY d.name;
SELECT e.first_name, e.last_name, e.job_title, e.salary FROM employees AS e ORDER BY e.salary DESC;

-- 17
UPDATE employees
SET salary = salary * 1.1;
SELECT salary FROM employees;
