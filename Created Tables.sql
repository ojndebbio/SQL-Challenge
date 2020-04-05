--Drop table 
Drop table if exists departments;
Drop table if exists employees;
Drop table if exists dept_emp;
Drop table if exists dept_manager;
Drop table if exists salaries;
Drop table if exists tites;

CREATE TABLE "departments" (
    "dept_no" varchar(20) ,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(10)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(20)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

select * from departments

select * from employees

select * from dept_emp

select * from dept_manager

select * from salaries

select * from titles

-- Solving for Homework questions:
-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
from employees left join salaries on employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.
select * 
from employees 
where hire_date > '01-01-1986'

-- 3a. List the manager of each department with the following information:
-- 3b. department number, department name, the manager's employee number, last name, first name, 
-- and start and end employment dates.
select employees.emp_no, dept_manager.dept_no, employees.first_name, employees.last_name, employees.hire_date, dept_manager.from_date, dept_manager.to_date
from dept_manager
		left join departments on dept_manager.dept_no = departments.dept_no
		left join employees on dept_manager.emp_no = employees.emp_no
		
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
       from employees
	   		   left join dept_emp on employees.emp_no = dept_emp.emp_no
			   left join departments on dept_emp.dept_no = departments.dept_no
			   
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees
where first_name like 'Hercules' and last_name like 'B%'

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
		left join dept_emp on employees.emp_no = dept_emp.emp_no
		left join departments  on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales'

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
		left join dept_emp on employees.emp_no = dept_emp.emp_no
		left join departments on dept_emp.dept_no = departments.dept_no
where departments.dept_name in ('Sales', 'Development')

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count (last_name) as frequency
from employees
group by last_name
order by frequency desc
