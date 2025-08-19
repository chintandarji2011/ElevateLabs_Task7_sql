/*Task 7:Creating Views
Objective: Learn to create and use views

Deliverables: View definitions and usage examples*/

-- Create Database Task 7
CREATE DATABASE elevatelabs_task7;

-- Enter the Task7 database
USE elevatelabs_task7;

-- Create sample tables 'departments'

CREATE TABLE departments
(
	dep_id INT PRIMARY KEY,
	dep_name VARCHAR(100) NOT NULL
);

-- Create table of 'employees'
CREATE TABLE employees
(
	emp_id INT PRIMARY KEY,
	emp_name VARCHAR(100),
	dep_id INT,
	salary DECIMAL(10,2),
	hire_date DATE,
	FOREIGN KEY(dep_id) REFERENCES departments(dep_id)
);

-- insert data in 'departments' table
INSERT INTO departments (dep_id, dep_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

-- insert data in 'employees' table
INSERT INTO employees (emp_id, emp_name, dep_id, salary, hire_date) VALUES
(101, 'Alice',     2, 65000.00, '2022-05-10'),
(102, 'Bob',       1, 48000.00, '2021-03-15'),
(103, 'Charlie',   3, 52000.00, '2020-07-20'),
(104, 'David',     2, 75000.00, '2023-01-05'),
(105, 'Evelyn',    4, 43000.00, '2019-11-01'),
(106, 'Frank',     2, 58000.00, '2022-12-11'),
(107, 'Grace',     3, 81000.00, '2018-08-24'),
(108, 'Heidi',     1, 39000.00, '2023-06-01');

SELECT * FROM departments;
SELECT * FROM employees;

-- Example 1: Create a View to Show Employee Details with Department

CREATE OR ALTER VIEW Vw_EmployeeDetais_dep
AS
SELECT e.emp_id, e.emp_name, d.dep_name, e.salary 
FROM employees e
INNER JOIN departments d ON e.dep_id = d.dep_id;

-- Usage
SELECT * FROM Vw_EmployeeDetais_dep;

--  Example 2: View Without Salary (For Security)

CREATE OR ALTER VIEW Vw_employees_public
AS
SELECT e.emp_id, e.emp_name, d.dep_name, e.hire_date
FROM employees e
INNER JOIN departments d ON e.dep_id = d.dep_id;

SELECT * FROM Vw_employees_public;

-- Example 3: High Earners View

CREATE OR ALTER VIEW Vw_HighEarner 
AS
SELECT emp_id, emp_name, salary FROM employees
WHERE salary > 50000;

-- Usage
SELECT * FROM Vw_HighEarner;

-- Example 4: Update view by 'OR ALTER' with 'CREATE'
--  Example 5: Drop a View:

DROP VIEW Vw_HighEarner;

-- Example 6:  View with Aggregation – Average Salary by Department
CREATE OR ALTER VIEW AvgSalaryDep
AS
SELECT d.dep_name, AVG(e.salary) AS Avg_Salary
FROM employees e
INNER JOIN departments d ON e.dep_id = d.dep_id
GROUP BY d.dep_name;

-- Usage
SELECT * FROM AvgSalaryDep;

-- Example 7: View with Date Filter – Recently Hired Employees
CREATE OR ALTER VIEW RecentHireEmployee
AS
SELECT emp_id, emp_name, hire_date
FROM employees
WHERE hire_date >= '2021-01-01'

-- Usage
SELECT * FROM RecentHireEmployee;

-- Example 8:  View with CASE Logic – Salary Grade Classification
CREATE OR ALTER VIEW Vw_GradClassification
AS
SELECT emp_id, emp_name, salary,
		CASE	
			WHEN salary >= 70000 THEN 'A'
			WHEN salary BETWEEN 50000 AND 69999 THEN 'B'
			ELSE 'C'
		END AS Grade
FROM employees;

-- Usage
SELECT * FROM Vw_GradClassification;

-- Example 9: Filtered Department View – Only IT Department Employees

CREATE OR ALTER VIEW Vw_FiletrITDept
AS
SELECT e.emp_id, e.emp_name, e.salary, d.dep_name
FROM employees e
INNER JOIN departments d ON d.dep_id = e.dep_id
WHERE d.dep_name = 'IT';

-- Usage
SELECT * FROM Vw_FiletrITDept;

-- Example 10: Nested View – Use a View Inside Another View
--- First create a view of High_earners
	CREATE OR ALTER VIEW Vw_HighEarners
	AS
	SELECT emp_id, emp_name, salary
	FROM employees
	WHERE salary >= 70000;
--- Create view of High_Earners_Bonus
	CREATE OR ALTER VIEW Vw_HighEarnerBonus
	AS
	SELECT emp_name, salary, (salary * 0.10) As Bonus FROM Vw_HighEarners;

SELECT * FROM Vw_HighEarnerBonus;





