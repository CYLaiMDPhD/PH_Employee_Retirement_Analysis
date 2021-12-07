-- Deliverable 1

-- Steps 1-8
-- NOTE: per challenge instructions, this query does not filter for hire dates or current employee status
SELECT
	e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date,t.to_date
INTO retirement_titles
FROM employees as e
	INNER JOIN titles as t
		ON e.emp_no=t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Steps 9-14
SELECT DISTINCT ON (emp_no)
	emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;


-- Steps 15-21
SELECT
	COUNT(1) as "Count",
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "Count" DESC;



-- Deliverable 2

-- Steps 1-11
SELECT DISTINCT ON (e.emp_no)
	e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
	JOIN dept_emp as de
		ON e.emp_no=de.emp_no
	JOIN titles as t
		ON e.emp_no=t.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, t.to_date DESC;
-- NOTE: the above query also orders the data by to_date from the titles chart so that the most recent title for each employee is captured.
-- I believe there is a mistake in the module's example output for this deliverable.
-- Please look at employee #10762 (Lech Himler). His most recent title should be "Senior Staff", not "Staff".



-- ADDITIONAL QUERIES used for readme:

-- Left Join unique_titles and dept_emp to filter for currently employeed and eligible to retire
-- This corrects unique_titles table to show only current employees
SELECT DISTINCT ON (ut.emp_no)
	ut.emp_no, ut.first_name, ut.last_name, ut.title,
	de.from_date, de.to_date, de.dept_no
INTO current_unique_titles
FROM unique_titles as ut
	INNER JOIN dept_emp as de
		ON ut.emp_no=de.emp_no
WHERE de.to_date='9999-01-01'
ORDER BY ut.emp_no, de.to_date DESC;

SELECT * from current_unique_titles;
SELECT COUNT(1) from current_unique_titles;


-- A slightly different query to confirm that the above query returns the right number of current employees eligible to retire
SELECT count(1)
	FROM employees as e
		INNER JOIN dept_emp as de
			ON e.emp_no=de.emp_no
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (de.to_date='9999-01-01');


-- Correct retiring_titles table by counting titles in current_unique_titles, filtered on current employees eligible to retire
SELECT
	COUNT(1) as "Count",
	title
INTO current_retiring_titles
FROM current_unique_titles
GROUP BY title
ORDER BY "Count" DESC;

SELECT * FROM current_retiring_titles;



-- Added counts by departments to current_unique_titles
SELECT 
	COUNT(1) as "Total Count",
	cut.title, 
	COUNT(1) FILTER (WHERE cut.dept_no='d001') as "Marketing",
	COUNT(1) FILTER (WHERE cut.dept_no='d002') as "Finance",
	COUNT(1) FILTER (WHERE cut.dept_no='d003') as "Human Resources",
	COUNT(1) FILTER (WHERE cut.dept_no='d004') as "Production",
	COUNT(1) FILTER (WHERE cut.dept_no='d005') as "Development",
	COUNT(1) FILTER (WHERE cut.dept_no='d006') as "Quality Management",
	COUNT(1) FILTER (WHERE cut.dept_no='d007') as "Sales",
	COUNT(1) FILTER (WHERE cut.dept_no='d008') as "Research",
	COUNT(1) FILTER (WHERE cut.dept_no='d009') as "Customer Service"
FROM current_unique_titles as cut
	LEFT JOIN departments as d
		ON cut.dept_no=d.dept_no
GROUP BY cut.title
ORDER BY "Total Count" DESC;	


-- Find percentage of retiring employees by department
-- First find total current employees in departments
SELECT 
	COUNT(1),
	d.dept_name
INTO curr_emp_dept
FROM dept_emp as de
	LEFT JOIN departments as d
		ON de.dept_no=d.dept_no
WHERE de.to_date='9999-01-01'
GROUP BY d.dept_no
ORDER BY d.dept_no;

-- Count current retirement eligible employees by department from current_unique_titles table
SELECT
	COUNT (1),
	d.dept_name
INTO retire_dept
FROM current_unique_titles as cut
	INNER JOIN departments as d
		ON cut.dept_no=d.dept_no
GROUP BY d.dept_no
ORDER BY d.dept_no;
-- The above 2 tables were imported into pandas to calculate percentages



-- Break down mentorship eligibility by titles and departments to see if list needs to be expanded
-- Mentorship eligibility with department name first created as a separate table!
SELECT DISTINCT ON (e.emp_no)
	e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date, 
	t.title,
	d.dept_name
INTO mentorship_eligibility_dept
FROM employees as e
	JOIN dept_emp as de
		ON e.emp_no=de.emp_no
	JOIN titles as t
		ON e.emp_no=t.emp_no
	JOIN departments as d
		ON de.dept_no=d.dept_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, t.to_date DESC;

SELECT * FROM mentorship_eligibility_dept;

-- Count mentees by title from above table
SELECT
	COUNT(1) as "Count",
	dept_name
INTO mentee_bydept
FROM mentorship_eligibility_dept
GROUP BY dept_name
ORDER BY "Count" DESC;

-- Count mentees by title AND department from above table
SELECT 
	COUNT(1) as "Total Count",
	med.title, 
	COUNT(1) FILTER (WHERE med.dept_name='Marketing') as "Marketing",
	COUNT(1) FILTER (WHERE med.dept_name='Finance') as "Finance",
	COUNT(1) FILTER (WHERE med.dept_name='Human Resources') as "Human Resources",
	COUNT(1) FILTER (WHERE med.dept_name='Production') as "Production",
	COUNT(1) FILTER (WHERE med.dept_name='Development') as "Development",
	COUNT(1) FILTER (WHERE med.dept_name='Quality Management') as "Quality Management",
	COUNT(1) FILTER (WHERE med.dept_name='Sales') as "Sales",
	COUNT(1) FILTER (WHERE med.dept_name='Research') as "Research",
	COUNT(1) FILTER (WHERE med.dept_name='Customer Service') as "Customer Service"
INTO mentees_titles_dept
FROM mentorship_eligibility_dept as med
GROUP BY med.title
ORDER BY "Total Count" DESC;



