-- Module Exercise 7.3.1

-- Simple query of employees born between 1952 and 1955
SELECT first_name, last_name FROM employees
	WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Simple query of employees born in 1952
SELECT first_name, last_name FROM employees
	WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Simple query of employees born in 1953
SELECT first_name, last_name FROM employees
	WHERE birth_date BETWEEN '1953-01-01' AND '1952-12-31';
	
-- Simple query of employees born in 1954
SELECT first_name, last_name FROM employees
	WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Simple query of employees born in 1955
SELECT first_name, last_name FROM employees
	WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';
	
-- Query for birthdate in a range and hire date in a range (Retirement eligibility)
SELECT first_name,last_name FROM employees
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Count number eligible for retirement
SELECT COUNT(first_name) FROM employees
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Make a new table from retirement eligible employees
SELECT first_name,last_name
	INTO retirement_info
	FROM employees
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	
SELECT * from retirement_info;