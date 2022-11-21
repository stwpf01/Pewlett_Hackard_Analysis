-- DELIVERABLE 1 
SELECT e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date 
INTO retirement_titles 
FROM employees AS e   
INNER JOIN titles as ti ON (e.emp_no  = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,first_name,last_name,title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT COUNT(title), title INTO retiring_titles
FROM unique_titles
GROUP BY title ORDER BY COUNT(title) DESC;

--DELIVERABLE 2
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, de.from_date, de.to_date, ti.title
INTO mentorship_eligibility 
FROM employees AS e
INNER JOIN dept_emp as de ON (de.emp_no = e.emp_no)
INNER JOIN titles as ti ON (ti.emp_no = e.emp_no)
WHERE (de.to_date = '9999-01-01') AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

--DELIVERABLE 3 ADDITIONAL QUERIES

-- Specific Count of Eligible Mentorees by Title
SELECT COUNT(title), title FROM mentorship_eligibility
GROUP BY title ORDER BY COUNT(title) DESC;

-- Managers Retiring and their Department
SELECT u.emp_no, u.first_name, u.last_name, dm.dept_no, d.dept_name, u.title
FROM unique_titles AS u 
INNER JOIN dept_manager AS dm ON (dm.emp_no = u.emp_no)
INNER JOIN departments AS d ON (dm.dept_no = d.dept_no)
WHERE (title = 'Manager');