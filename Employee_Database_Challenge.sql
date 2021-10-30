-- Create new table from employee and titles table for retiring employees & Titles 

SELECT  em.emp_no,
        em.first_name,
        em.last_name,
        t.title,
        t.from_date,
        t.to_date
INTO retirement_titles_info
FROM employees as em
    INNER JOIN titles as t
        ON (em.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;



-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO Unique_Titles
FROM retirement_titles_info as rt
ORDER BY rt.emp_no, rt.to_date DESC;

--retrieve the number of employees in their most recent roles who are about to retire. 
SELECT Title, COUNT(title) AS "count_titles"
INTO retiring_titles
FROM Unique_Titles
GROUP BY title
ORDER BY "count_titles" DESC;

--DROP TABLE IF EXISTS retiring_titles 

-- Write a query to create a Mentorship Eligibility Table 

SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date, 
    t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
      AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;