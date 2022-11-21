# Pewlett_Hackard_Analysis

## Overview of Analysis

The purpose of this analysis was to determine, using PostgreSQL, the employees who are eligible for retirement through their title as well as which employees are eligible for the mentorship program. The SQL querey code written to find these results is in the [Employee_Database_challenge]() file in the [Queries]() folder. Results and examples of these queries will be detailed below.

## Results
Results: Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed
- It was first determined to write a query to find the employees who are at or near retirement age: 
``` 
SELECT e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date 
INTO retirement_titles 
FROM employees AS e   
INNER JOIN titles as ti ON (e.emp_no  = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no;
```
- Numerous employees held multiple titles, therefore a query was written to limit the results to their most recent title and placed into tables:
```
SELECT DISTINCT ON (emp_no) emp_no,first_name,last_name,title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT COUNT(title), title INTO retiring_titles
FROM unique_titles
GROUP BY title ORDER BY COUNT(title) DESC;
```
![Retiring_Titles]()

- Since all of these roles cannot be left empty, it was determined who would eligible for mentorship by finding those employees who were born in 1965. 

```
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, de.from_date, de.to_date, ti.title
INTO mentorship_eligibility 
FROM employees AS e
INNER JOIN dept_emp as de ON (de.emp_no = e.emp_no)
INNER JOIN titles as ti ON (ti.emp_no = e.emp_no)
WHERE (de.to_date = '9999-01-01') AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;
```
- Since there were employees who left the company still on file, these queries had to be filtered further by the `to_date` column to equal `9999-01-01` to the `WHERE` clause. `9999-01-01` means that the employee is still currently working at the company.


## Summary

Assuming all roles will need to be filled there will be over 70,000 openings left from those retiring. Comparing that count to the count of mentorship ready employees (Shown with query):

![Mentorship_Count]()

There are plenty of retirement ready employees to mentor. If anything, there needs to be more mentorees to help fill the roles that will be left after the retirees leave. Expanding it beyond employees born in 1965 would be beneficial. Another aspect that is somewhat worrying is  that there are two managers ready to retire with no one seemingly to replace them (Shown with query):

![Retiring_Managers]()

Two employees who are mentorship ready should be mentored to take over for these two managers once they decide to retire.

