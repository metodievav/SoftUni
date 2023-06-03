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

INSERT INTO teachers (manager_id)
VALUES (NULL), (106), (106), (105), (101), (101);
