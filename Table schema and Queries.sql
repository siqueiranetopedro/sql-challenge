--Data Engineering-- TABLE SCHEMA--

CREATE TABLE departments (
--     id INT PRIMARY KEY,
    dept_no VARCHAR(255)NOT NULL,
    dept_name VARCHAR(255)NOT NULL
	PRIMARY KEY ("dept_no")
);
CREATE TABLE dept_emp (
--     id INT PRIMARY KEY,
    emp_no VARCHAR(255)NOT NULL,
    dept_no VARCHAR(255)NOT NULL
	PRIMARY KEY("emp_no")
);

CREATE TABLE dept_manager (
--     id INT PRIMARY KEY,
    dept_no VARCHAR(255)NOT NULL,
   emp_no VARCHAR(255)NOT NULL
);

CREATE TABLE employees (
--     id INT PRIMARY KEY,
    emp_no VARCHAR(255)NOT NULL,
    emp_title_id VARCHAR(255)NOT NULL,
    birth_date VARCHAR(255)NOT NULL,
	first_name VARCHAR(255)NOT NULL,
	last_name VARCHAR(255)NOT NULL,
	sex VARCHAR(255)NOT NULL,
	hire_date VARCHAR(255)NOT NULL
	PRIMARY KEY("emp_no")
);

CREATE TABLE salaries (
--     id INT PRIMARY KEY,
   emp_no VARCHAR(255)NOT NULL,
   salary VARCHAR(255)NOT NULL
	PRIMARY KEY("salary")
 );

CREATE TABLE titles (
--     id INT PRIMARY KEY,
   title_id VARCHAR(255)NOT NULL,
   title VARCHAR(255)NOT NULL
	PRIMARY KEY("title_id")
 );
 
--DATA ANALYSIS-- QUERIES--
 --List the employee number, last name, first name, sex, and salary of each employee 
 
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986

SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'

--List the manager of each department along with their department number, department name, employee number, last name, and first name

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name 

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name

SELECT d.dept_name, e.last_name, e.first_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name 

SELECT DISTINCT departments
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no IN (SELECT dept_no FROM departments WHERE dept_name IN ('Sales', 'Development'));


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) 

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

