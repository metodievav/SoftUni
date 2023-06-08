CREATE DATABASE my_restaurant;
USE my_restaurant;

# 1 - Table Design

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL UNIQUE,
type VARCHAR(30) NOT NULL,
price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE clients (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birthdate DATE NOT NULL,
card VARCHAR(50),
review TEXT
);

CREATE TABLE `tables` (
id INT PRIMARY KEY AUTO_INCREMENT,
floor INT NOT NULL,
reserved BOOLEAN,
capacity INT NOT NULL
);

CREATE TABLE waiters (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50),
salary DECIMAL(10, 2)
); 

CREATE TABLE orders (
id INT PRIMARY KEY AUTO_INCREMENT,
table_id INT NOT NULL,
waiter_id INT NOT NULL,
order_time TIME NOT NULL,
payed_status BOOLEAN
);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_tables
	FOREIGN KEY (table_id)
		REFERENCES `tables`(id),
ADD CONSTRAINT fk_orders_waiters
	FOREIGN KEY (waiter_id) 
		REFERENCES waiters(id);

CREATE TABLE orders_clients (
order_id INT,
client_id INT,
CONSTRAINT fk_orders_clients_orders
	FOREIGN KEY (order_id) 
		REFERENCES orders(id),
CONSTRAINT fk_orders_clients_clients
	FOREIGN KEY (client_id) 
		REFERENCES clients(id)
);

CREATE TABLE orders_products (
order_id INT,
product_id INT,
CONSTRAINT fk_orders_products_orders
	FOREIGN KEY (order_id) 
		REFERENCES orders(id),
CONSTRAINT fk_orders_products_products
	FOREIGN KEY (product_id) 
		REFERENCES products(id)
);

# 2 - Data Manipulation // Inset

INSERT INTO products (name, type, price) 
(
SELECT
	CONCAT(last_name, ' specialty'),
	'Cocktail',
	CEILING(0.01 * salary)
FROM waiters
WHERE id > 6
);

# 3 - Data Manipulation // Update

UPDATE orders
SET table_id = table_id - 1
WHERE id BETWEEN 12 AND 23;

# 4 - Data Manipulation // Delete

DELETE FROM waiters AS w
WHERE (SELECT COUNT(*) FROM orders WHERE w.id = waiter_id) = 0;

# 5 Querying // Clients

SELECT *
FROM clients
ORDER BY birthdate DESC, id DESC;

# 6 Querying // Birthdate

SELECT first_name, last_name, birthdate, review
FROM clients
WHERE card IS NULL
	AND birthdate BETWEEN '1978-01-01' AND '1993-01-01'
ORDER BY last_name DESC, id
LIMIT 5;

# 7 Querying // Accounts

SELECT CONCAT(last_name, first_name, CHAR_LENGTH(first_name), 'Restaurant') AS 'username',
		REVERSE(SUBSTRING(email, 2, 12)) AS 'password'
FROM waiters
WHERE salary IS NOT NULL
ORDER BY `password` DESC;

# 8 Querying // Top from menu

SELECT p.id, p.name, COUNT(op.product_id) AS 'count'
FROM products AS p
	JOIN orders_products AS op ON p.id = op.product_id
GROUP BY op.product_id
HAVING count >= 5
ORDER BY count DESC, name;

# 9 Querying // Availability

SELECT t.id AS 'table_id',
		t.capacity,
        COUNT(oc.client_id) AS 'count_clients',
        (
        CASE
			WHEN t.capacity > (SELECT COUNT(oc.client_id)) THEN 'Free seats'
            WHEN t.capacity = (SELECT COUNT(oc.client_id)) THEN 'Full'
            ELSE 'Extra seats'
		END
        ) AS 'availability'
FROM `tables` AS t
	JOIN orders AS o ON t.id = o.table_id
    JOIN orders_clients AS oc ON o.id = oc.order_id
WHERE t.floor = 1
GROUP BY t.id
ORDER BY t.id DESC;

# 10 - Programmability // Extra Bill

DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
RETURNS DECIMAL(19, 2)
DETERMINISTIC
BEGIN
RETURN (
	SELECT SUM(p.price) AS 'bill'
	FROM clients AS c
	JOIN orders_clients AS oc ON c.id = oc.client_id
	JOIN orders AS o ON oc.order_id = o.id
	JOIN orders_products AS op ON o.id = op.order_id
	JOIN products AS p ON op.product_id = p.id
	WHERE CONCAT(c.first_name, ' ', c.last_name) = full_name
	GROUP BY c.id
    );
END$$
DELIMITER ;
;

SELECT udf_client_bill('Silvio Blyth');

# 11 - Programmability // Happy Hour

DELIMITER $$
CREATE PROCEDURE udp_happy_hour(product_type VARCHAR(50))
BEGIN
	UPDATE products
	SET price = price * 0.8
	WHERE price >= 10 AND type = product_type;
END$$
DELIMITER ;
;

CALL udp_happy_hour('Cognac');

SELECT *
FROM products
WHERE type = 'Cognac';