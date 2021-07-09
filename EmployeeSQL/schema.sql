/*Creating all the tables in accordance to their data which they share with other tables
and is use to create PRIMARY KEYS and FOREIGN KEYS.*/

--Dropping tables in case if they exist and would throw an error--

DROP TABLE titles;
DROP TABLE employees;
DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE salaries;

--Creating titles table--
CREATE TABLE titles(
title_ID VARCHAR(10) not null PRIMARY KEY,
title VARCHAR(50) not null
);

SELECT * FROM titles;

--Creating employees table--
CREATE TABLE employees(
emp_no INTEGER not null PRIMARY KEY,
emp_title_ID VARCHAR(10) not null,
birth_date DATE not null,
first_name VARCHAR(50) not null,
last_name VARCHAR(50) not null,
sex VARCHAR(6) not null,
hire_date DATE not null,
FOREIGN KEY(emp_title_ID) REFERENCES titles(title_ID)
);

SELECT * FROM employees;

--Creating departments table--
CREATE TABLE departments(
dept_no VARCHAR(10) not null PRIMARY KEY,
dept_name VARCHAR(50) not Null
);

SELECT * FROM departments;

--Creating employees department table--
CREATE TABLE dept_emp(
emp_no INTEGER not null,
dept_no VARCHAR(10) not null,
PRIMARY KEY(emp_no, dept_no),
FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp;

--Creating managers department table--
CREATE TABLE dept_manager(
dept_no VARCHAR(10) not null,
emp_no INTEGER not null,
PRIMARY KEY(emp_no, dept_no),
FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_manager;

--Creating salaries table--
CREATE TABLE salaries(
emp_no INTEGER not null PRIMARY KEY,
salary INTEGER not null,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries;

/*DATA ANALYSIS No:1 
Details of each employee: employee number, last name, first name, sex, and salary.*/

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex,
	salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

/*DATA ANALYSIS No:2 
First name, last name, and hire date for employees who were hired in 1986.*/

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

/*DATA ANALYSIS No:3 
Information of manager of each department: department number, 
department name, the manager's employee number, last name, first name.*/

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, 
	employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

/*DATA ANALYSIS No:4 
Department of each employee: employee number,
last name, first name, and department name.*/

SELECT employees.emp_no, employees.last_name, employees.first_name, 
	departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

/*DATA ANALYSIS No:5 
First name, last name, and sex for employees whose first name is "Hercules"
and last names begin with "B".*/

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

/*DATA ANALYSIS No:6 
Employees in the Sales department, including their employee number, last name, 
first name, and department name.*/

SELECT employees.emp_no, employees.last_name, employees.first_name,
	departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';

/*DATA ANALYSIS No:7 
Employees in the Sales and Development departments, including their employee number, 
last name, first name, and department name.*/

SELECT employees.emp_no, employees.last_name, employees.first_name,
	departments.dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

/*DATA ANALYSIS No:8 
In descending order, list the frequency count of employee last names, i.e., 
how many employees share each last name.*/

SELECT COUNT(emp_no), last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(emp_no) DESC;