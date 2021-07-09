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