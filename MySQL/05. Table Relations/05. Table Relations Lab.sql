#1
CREATE DATABASE table_relations;

CREATE TABLE mountains (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
mountain_id INT,
CONSTRAINT fk_peaks_mountains
FOREIGN KEY (mountain_id)
REFERENCES mountains(id)
);

#2
USE camp;

SELECT 
    v.driver_id,
    v.vehicle_type,
    CONCAT_WS(' ', c.first_name, c.last_name) AS 'driver_name'
FROM
    vehicles AS v
        JOIN
    campers AS c ON c.id = v.driver_id;
    
#3
SELECT 
    r.starting_point,
    r.end_point,
    r.leader_id,
    CONCAT_WS(' ', c.first_name, c.last_name) AS 'leader_name'
FROM
    routes AS r
        JOIN
    campers AS c ON r.leader_id = c.id;

#4
DROP DATABASE table_relations;

CREATE TABLE mountains (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    mountain_id INT,
    CONSTRAINT fk_peaks_mountains FOREIGN KEY (mountain_id)
        REFERENCES mountains (id)
        ON DELETE CASCADE
);

#5
CREATE DATABASE table_relations;
USE table_relations;

CREATE TABLE clients (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(50) NOT NULL
);

CREATE TABLE projects (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    project_leaed_id INT,
    CONSTRAINT fk_projects_clients FOREIGN KEY (client_id)
        REFERENCES clients (id)
);

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    project_id INT,
    CONSTRAINT fk_employees_projects FOREIGN KEY (project_id)
        REFERENCES projects (id)
);

ALTER TABLE projects
ADD CONSTRAINT fk_projects_employees
FOREIGN KEY (project_leaed_id)
REFERENCES employees(id);
