# 1
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name
	FROM employees
	WHERE salary > 35000
	ORDER BY first_name, last_name, employee_id;
END$$
DELIMITER ;
;

# 2
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(salary DECIMAL(19,4))
BEGIN
	SELECT e.first_name, e.last_name
	FROM employees AS e
	WHERE e.salary >= `salary`
	ORDER BY e.first_name, e.last_name, e.employee_id;
END$$
DELIMITER ;
;

# 3
DELIMITER %%
CREATE PROCEDURE usp_get_towns_starting_with(letter VARCHAR(50))
BEGIN
	SELECT name
	FROM towns
	WHERE name LIKE CONCAT(letter, '%')
    ORDER BY name;
END%%
DELIMITER ;
;

# 4
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT e.first_name, e.last_name
	FROM employees AS e
		JOIN addresses AS a ON e.address_id = a.address_id
		JOIN towns AS t ON a.town_id = t.town_id
	WHERE t.name = town_name
	ORDER BY e.first_name, e.last_name, e.employee_id;
END$$
DELIMITER ;
;

# 5
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(given_salary DECIMAL(19,4))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE `return` VARCHAR(10);
    SET `return` := CASE
						WHEN given_salary < 30000 THEN 'Low'
						WHEN given_salary <= 50000 THEN 'Average'
						ELSE 'High'
						END;
	RETURN `return`;
END$$
DELIMITER ;
;

# 6
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN
	SELECT first_name, last_name
		FROM employees
        WHERE (salary < 30000 AND salary_level = 'Low')
        OR (salary BETWEEN 30000 AND 50000 AND salary_level = 'Average')
        OR (salary > 50000 AND salary_level = 'High')
        ORDER BY first_name DESC, last_name DESC;
END$$
DELIMITER ;
;

CALL usp_get_employees_by_salary_level('High');

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level2(salary_level VARCHAR(10))
BEGIN
	SELECT first_name, last_name
		FROM employees
        WHERE (SELECT ufn_get_salary_level(salary)) = salary_level
        OR (SELECT ufn_get_salary_level(salary)) = salary_level
        OR (SELECT ufn_get_salary_level(salary)) = salary_level
        ORDER BY first_name DESC, last_name DESC;
END$$
DELIMITER ;
;

CALL usp_get_employees_by_salary_level2('High');

# 7
DELIMITER $$
CREATE FUNCTION  ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS BIT
DETERMINISTIC
BEGIN
	RETURN word REGEXP (CONCAT('^[', set_of_letters, ']+$'));
END$$
DELIMITER ;
;

SELECT ufn_is_word_comprised('oistmiahf', 'sofia');

# 8
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(first_name, ' ', last_name) AS 'full_name'
	FROM account_holders
	ORDER BY full_name;
END$$
DELIMITER ;
;

# 9
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(amount INT)
BEGIN
	SELECT ah.first_name, ah.last_name
	FROM account_holders AS ah
		JOIN accounts AS a ON ah.id = a.account_holder_id
	GROUP BY a.account_holder_id
	HAVING SUM(a.balance) > amount
	ORDER BY a.account_holder_id;
END$$
DELIMITER ;
;

# 10
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(19,4), yearly_interest_rate DOUBLE(10,2), number_of_years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
	DECLARE future_value_of_initial_sum DECIMAL(19,4);
    SET future_value_of_initial_sum = (
    SELECT initial_sum * POWER((1 + yearly_interest_rate), number_of_years)
    );
    
    RETURN future_value_of_initial_sum;
END$$
DELIMITER ;

SELECT ufn_calculate_future_value(1000,0.5,5);

# 11
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_rate DOUBLE(10,2))
BEGIN
	SELECT ah.id,
			ah.first_name,
			ah.last_name,
			a.balance AS 'current_balance',
			ufn_calculate_future_value(a.balance, interest_rate, 5) AS 'balabce_in_5_years'
	FROM account_holders AS ah
		JOIN accounts AS a ON ah.id = a.account_holder_id
	WHERE a.id = account_id;
END$$
DELIMITER ;
;

# 12
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF ((money_amount > 0) AND (SELECT COUNT(*) FROM accounts AS a WHERE a.id <> 1))
    THEN
		UPDATE accounts AS a
		SET a.balance = a.balance + money_amount
			WHERE a.id = account_id;
    END IF;
END$$
DELIMITER ;
;

# 13
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money2(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF ((money_amount > 0) AND (SELECT COUNT(*) FROM accounts AS a WHERE a.id <> 1))
    THEN
		UPDATE accounts AS a
		SET a.balance = a.balance - money_amount
			WHERE a.id = account_id;
		
		IF ((SELECT balance FROM accounts WHERE account_id = accounts.id) < money_amount)
        THEN
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
    END IF;
END$$
DELIMITER ;
;

# 14
CALL usp_withdraw_money2(1, 10);
SELECT * FROM accounts