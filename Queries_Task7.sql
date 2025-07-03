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
-- create view_employees_details
CREATE VIEW view_employees_details AS 
SELECT e.emp_id, e.emp_name, d.dep_name, e.salary, e.hire_date
FROM employees e
JOIN departments d ON e.dep_id = d.dep_id;

-- call view_employees_details
SELECT * FROM view_employees_details;


--  Example 2: View Without Salary (For Security)
-- create view_employees_public
CREATE VIEW view_employees_public AS
SELECT emp_id, emp_name, dep_id, hire_date
FROM employees;
-- call view_employees_public
SELECT * FROM view_employees_public;

-- Example 3: High Earners View
-- create view_high_salary grater than 50000
CREATE VIEW view_high_salary AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 50000;

-- call view_high_salary
SELECT * FROM view_high_salary;

-- Example 4: Update view
-- update view_high_salary grater than 60000
CREATE OR REPLACE VIEW view_high_salary AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 60000;

-- call view_high_salary
SELECT * FROM view_high_salary;

--  Example 5: Drop a View:
DROP VIEW IF EXISTS view_high_salary;


-- Example 6:  View with Aggregation – Average Salary by Department
-- create view_avg_salary_by_departments
CREATE VIEW view_avg_salary_by_departments AS
SELECT d.dep_name, ROUND(AVG(e.salary)) AS avg_salary 
FROM departments d 
JOIN employees e ON e.dep_id = d.dep_id
GROUP BY d.dep_name;

-- call view_avg_salary_by_departments

SELECT * FROM view_avg_salary_by_departments;

-- Example 7: View with Date Filter – Recently Hired Employees
-- create view view_recent_hires
CREATE VIEW  view_recent_hires AS
SELECT emp_id, emp_name, hire_date
FROM employees 
WHERE hire_date >= DATE('2022-01-01');

-- call view_recent_hires
SELECT * FROM view_recent_hires;

-- Example 8:  View with CASE Logic – Salary Grade Classification
-- create view_salary_grade
CREATE VIEW view_salary_grade AS 
SELECT emp_id, emp_name, salary,
      CASE WHEN salary >= 70000 THEN 'A'
           WHEN salary >= 50000 THEN 'B'
           ELSE 'C'
      END AS salary_garde
FROM employees;

-- call view_salary_grade

SELECT * FROM view_salary_grade;

-- Example 9: Filtered Department View – Only IT Department Employees
-- create view_it_employees
CREATE VIEW view_it_employees AS
SELECT emp_id, emp_name, salary
FROM employees 
WHERE dep_id = (SELECT dep_id FROM departments WHERE dep_name = 'IT');

-- call view_it_employees

SELECT * FROM view_it_employees;
  
-- Example 10: Nested View – Use a View Inside Another View
-- First create a view_high_earners of high earners 
CREATE VIEW view_high_earners AS 
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 60000;

-- Now, create a new view_high_earners_bonus to show their name and salary with bonus
CREATE VIEW view_high_earners_bonus AS 
SELECT emp_name, salary, salary * 0.10 AS bonus
FROM view_high_earners;

-- call view_high_earners_bonus
SELECT * FROM view_high_earners_bonus;