CREATE DATABASE gamebar;
USE gamebar;

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name  VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
name  VARCHAR(50) NOT NULL
);

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name  VARCHAR(50) NOT NULL,
category_id INT NOT NULL
);

INSERT INTO employees (id, first_name, last_name)
VALUES (1, 'test1', 'test1'), (2, 'test2', 'test2'), (3, 'test3', 'test3');

ALTER TABLE employees
ADD COLUMN middle_name VARCHAR(50);

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY products(category_id)
REFERENCES categories(id);

ALTER TABLE employees
CHANGE COLUMN middle_name
middle_name VARCHAR(100);