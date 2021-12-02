-- Module 7.3.2 to 7.3.6 Exercises

-- Make a table with retirement eligible employees by department.
-- 1. Drop previously made retirement_info table in order to recreate table with employee number
DROP TABLE retirement_info;
--2. Make retirement_info table again with employee ID number
SELECT emp_no,first_name,last_name
	INTO retirement_info
	FROM employees
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	
SELECT * FROM retirement_info;

-- Join departments and dept_manager tables
SELECT 
-- select statement should have all columns you want from the joined table
	departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments INNER JOIN dept_manager
ON departments.dept_no=dept_manager.dept_no;


-- Join retirment and dept_emp tables to capture who is eligible and currently employed
SELECT retirement_info.emp_no,
	retirement_info.first_name, 
	retirement_info.last_name, 
	dept_emp.to_date
	FROM retirement_info LEFT JOIN dept_emp
	ON retirement_info.emp_no=dept_emp.emp_no;

-- Using aliases
SELECT ri.emp_no,
	ri.first_name, 
	ri.last_name, 
	de.to_date
	FROM retirement_info as ri LEFT JOIN dept_emp as de
	ON ri.emp_no=de.emp_no;

SELECT 
	d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d INNER JOIN dept_manager as dm
ON d.dept_no=dm.dept_no;


-- Create new table from join of retirement_info and dept_emp, filtered on current employees
SELECT ri.emp_no,
	ri.first_name, 
	ri.last_name, 
	de.to_date
	INTO current_emp
	FROM retirement_info as ri LEFT JOIN dept_emp as de
	ON ri.emp_no=de.emp_no
	WHERE de.to_date=('9999-01-01');

SELECT * from current_emp;


-- COUNT employees by department by joining current_emp and dept_emp
SELECT COUNT(ce.emp_no),de.dept_no
-- Select gives you columns you want displayed
	INTO dept_retire_eligible
	FROM current_emp as ce
	LEFT JOIN dept_emp as de
	ON ce.emp_no=de.emp_no
	GROUP BY de.dept_no
	ORDER BY de.dept_no;


-- Make list of retirement eligible employees with id, names, gender and salary
SELECT * FROM salaries ORDER BY to_date DESC;

SELECT 
	e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
	INTO retire_emp_info
	FROM employees as e
		INNER JOIN salaries as s
		ON e.emp_no=s.emp_no
		INNER JOIN dept_emp as de
		ON e.emp_no=de.emp_no
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
		AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
		AND (de.to_date = '9999-01-01');

SELECT * from retire_emp_info;


-- Make list of managers with dept# and name, id, names, to and from dates
-- Use current_emp table = current retirement eligible employees
-- List new table of managers with dept info and date info
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
	INTO manager_info
	FROM dept_manager AS dm
   		INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    	INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

SELECT * FROM manager_info;


-- Update current_emp table with departments
SELECT 
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
	INTO dept_info
	FROM current_emp as ce
		INNER JOIN dept_emp as de
			ON (ce.emp_no=de.emp_no)
		INNER JOIN departments as d
			ON (de.dept_no=d.dept_no);

SELECT * FROM dept_info;


-- Create new table from retirement_info but only for sales dept
-- NOTE: using current_employees instead b/c this table filtered for current employees
SELECT
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	di.dept_name
	INTO sales_retire
	FROM current_emp as ce
		INNER JOIN dept_info as di
			ON ce.emp_no=di.emp_no
	WHERE dept_name = 'Sales';

-- Create same table as above for Sales and Development
SELECT
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	di.dept_name
	INTO sales_dev_retire
	FROM current_emp as ce
		INNER JOIN dept_info as di
			ON ce.emp_no=di.emp_no
	WHERE dept_name IN ('Sales','Development');

