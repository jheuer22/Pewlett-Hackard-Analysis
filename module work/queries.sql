

SELECT * 
From departments; 

select first_name, Last_name
from employees
where birth_date BETWEEN '1952-01-01' AND '1955-12-31'

select first_name, Last_name
from employees
where birth_date BETWEEN '1952-01-01' AND '1952-12-31'

select first_name, Last_name
from employees
where birth_date BETWEEN '1953-01-01' AND '1953-12-31'

select first_name, Last_name
from employees
where birth_date BETWEEN '1954-01-01' AND '1954-12-31'

select first_name, Last_name
from employees
where birth_date BETWEEN '1955-01-01' AND '1955-12-31'

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Retirement eligibility count
SELECT count(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

SELECT first_name, last_name
into retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

--select first_name, last_name, title 
--from employees as e 
--left join titles as t on e.emp_no = t.emp_no 

drop table retirement_info; 

-- Create new table for retiring employees 
select emp_no, first_name, last_name
into retirement_info 
from employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31'); 
-- check the table 
SELECT * FROM retirement_info;

-- Joining departments and dept_manager table 
select departments.dept_name, 
	dept_manager.emp_no, 
	dept_manager.from_date, 
	dept_manager.to_date
from departments 
inner join dept_manager
on departments.dept_no = dept_manager.dept_no; 

-- rerun with aliases 
select d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
from departments as d 
inner join dept_manager as dm 
on d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables 
-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
from retirement_info 
left join dept_emp
on retirement_info.emp_no = dept_emp.emp_no;

--re run with aliases
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;
	
--Join retirement_info to dept_emp to get employment status 
select ri.emp_no, 
	ri.first_name, 
	ri.last_name, 
de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no 
where de.to_date = ('9999-01-01')

--Employee count by department number 
select Count(ce.emp_no), de.dept_no
into ri_totals_by_dept
from current_emp as ce 
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;
	
--New query for 
SELECT emp_no, 
	first_name, 
last_name
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


drop table emp_info 


SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
      AND (de.to_date = '9999-01-01');
      
      
-- List of managers per department
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
        
-- Department retirees Info
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);
		
	
        
-- Department retirees Info for sales
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info_sales
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
where d.dept_name = 'Sales';

-- Department retirees Info for Sales & Development
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info_sales_Dev
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
where d.dept_name in ('Sales', 'Development');