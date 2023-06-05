#1
CREATE TABLE people (
person_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
salary DECIMAL(19, 4) NOT NULL,
passport_id INT
);

CREATE TABLE passports (
passport_id INT AUTO_INCREMENT PRIMARY KEY,
passport_number VARCHAR(10) NOT NULL UNIQUE
) AUTO_INCREMENT = 101;

ALTER TABLE people
ADD CONSTRAINT fk_people_passports
FOREIGN KEY (passport_id)
REFERENCES passports(passport_id);

INSERT INTO passports (passport_number)
VALUES ('N34FG21B'), ('K65LO4R7'), ('ZE657QP2');

INSERT INTO people (person_id, first_name, salary, passport_id)
VALUES (1, 'Roberto', 43300.00, 102), (2, 'Tom', 56100.00, 103), (3, 'Yana', 60200.00, 101);

#2
CREATE TABLE manufacturers (
manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
established_on DATE NOT NULL
);

CREATE TABLE models (
model_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
manufacturer_id INT,
CONSTRAINT fk_models_manufacturers
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(manufacturer_id)
);

ALTER TABLE models AUTO_INCREMENT = 101;

INSERT INTO manufacturers (name, established_on) 
VALUES ('BMW', '1916-03-01'), ('Tesla', '2003-01-01'), ('Lada', '1966-05-01');

INSERT INTO models (name, manufacturer_id)
VALUES ('X1', 1), ('i6', 1), ('Model S', 2), ('Model X', 2), ('Model 3', 2), ('Nova', 3);

#3
CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL
);


CREATE TABLE exams (
exam_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL
);

ALTER TABLE exams AUTO_INCREMENT = 101;

CREATE TABLE students_exams (
student_id INT NOT NULL,
exam_id INT NOT NULL,
CONSTRAINT pk_students_exams
PRIMARY KEY (student_id, exam_id),
CONSTRAINT fk_students_exams
FOREIGN KEY (student_id) 
REFERENCES students(student_id),
CONSTRAINT fk_exams_students
FOREIGN KEY (exam_id)
REFERENCES exams(exam_id)
);

INSERT INTO students (name)
VALUES ('Mila'), ('Toni'), ('Ron');

INSERT INTO exams (name)
VALUES ('Spring MVC'), ('Neo4j'), ('Oracle 11g');

INSERT INTO students_exams (student_id, exam_id)
VALUES (1, 101), (1, 102), (2, 101), (3, 103), (2, 102), (2, 103);

#4
CREATE TABLE teachers (
teacher_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30),
manager_id INT
);

ALTER TABLE teachers
ADD CONSTRAINT fk_teachers_manager
FOREIGN KEY (manager_id)
REFERENCES teachers(teacher_id);

ALTER TABLE teachers AUTO_INCREMENT = 101;

INSERT INTO teachers (name)
VALUES ('John'), ('Maya'), ('Silvia'), ('Ted'), ('Mark'), ('Greta');

UPDATE teachers
SET manager_id = 106 WHERE name = 'Maya';

UPDATE teachers
SET manager_id = 106 WHERE name = 'Silvia';

UPDATE teachers
SET manager_id = 105 WHERE name = 'Ted';

UPDATE teachers
SET manager_id = 101 WHERE name = 'Mark' OR name = 'Greta';

#5
CREATE DATABASE online_store;
USE online_store;

CREATE TABLE cities (
city_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
birthdate DATE,
city_id INT,
CONSTRAINT fk_customers_cities
FOREIGN KEY (city_id)
REFERENCES cities(city_id)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

CREATE TABLE item_types (
item_type_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

CREATE TABLE items (
item_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
item_type_id INT,
CONSTRAINT fk_items_item_types
FOREIGN KEY (item_type_id)
REFERENCES item_types(item_type_id)
);

CREATE TABLE order_items (
order_id INT,
item_id INT,
CONSTRAINT pk_order_items PRIMARY KEY (order_id, item_id),
CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT fk_order_items_items FOREIGN KEY (item_id) REFERENCES items(item_id)
);

#6
CREATE DATABASE university;
USE university;

CREATE TABLE subjects (
subject_id INT PRIMARY KEY AUTO_INCREMENT,
subject_name VARCHAR(50) NOT NULL
);

CREATE TABLE majors (
major_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_number VARCHAR(12) NOT NULL,
student_name VARCHAR(50) NOT NULL,
major_id INT,
CONSTRAINT fk_students_majors
FOREIGN KEY (major_id)
REFERENCES majors(major_id)
);

CREATE TABLE payments (
payment_id INT PRIMARY KEY AUTO_INCREMENT,
payment_date DATE NOT NULL,
payment_amount DECIMAL(8,2) NOT NULL,
student_id INT,
CONSTRAINT fk_payments_students
FOREIGN KEY (student_id)
REFERENCES students(student_id)
);

CREATE TABLE agenda (
student_id INT,
subject_id INT,
CONSTRAINT pk_agenda PRIMARY KEY (student_id, subject_id),
CONSTRAINT fk_agenda_students FOREIGN KEY (student_id) REFERENCES students(student_id),
CONSTRAINT fk_agenda_subjects FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

#9
SELECT 
    m.mountain_range,
    p.peak_name,
    p.elevation AS 'peak_elevation'
FROM
    peaks AS p
        JOIN
    mountains AS m ON p.mountain_id = m.id
WHERE
    mountain_range = 'Rila'
ORDER BY peak_elevation DESC;