-- Deliverable 1

-- Create retirement_titles table
SELECT employees.emp_no AS emp_no, first_name, last_name, title, from_date, to_date
    INTO retirement_titles
    FROM employees INNER JOIN titles
        ON titles.emp_no = employees.emp_no
    WHERE employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
    ORDER BY employees.emp_no;


SELECT emp_no, first_name, last_name, title
	FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no, to_date) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- get counts of retiring employees by job title
SELECT COUNT(emp_no) AS count, title
    INTO retirement_titles
    FROM unique_titles
    GROUP BY title
    ORDER BY count DESC;


-- Deliverable 2

-- Get employees eligible for mentorship program
SELECT DISTINCT ON (emp_no) employees.emp_no AS emp_no, first_name, last_name, birth_date,
    dept_emp.from_date AS from_date, dept_emp.to_date AS to_date, titles.title AS title
    INTO mentorship_eligibility
    FROM employees INNER JOIN dept_emp
        ON employees.emp_no = dept_emp.emp_no INNER JOIN titles
            ON employees.emp_no = titles.emp_no
    WHERE (dept_emp.to_date = '9999-01-01') AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    ORDER BY emp_no;
