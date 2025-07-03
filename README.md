# ElevateLabs_Task7_sql
Author - Darji Chintankumar Dineshchandra

# Task 7: Creating Views in SQL

## Objective
This task demonstrates how to create and use **SQL Views** to simplify complex queries, abstract business logic, and enhance security in a relational database.

## Tools Used
- DB Browser for SQLite
- MySQL Workbench

## Key Concepts
- Views are **virtual tables** based on SELECT statements.
- Used for **reusability**, **data abstraction**, and **security**.
- Do **not** store data themselves – only logic.
-  **View** can be retrive like **table** using SELECT statements.

## What We Did

### 1. Created sample `employees` and `departments` tables
### 2. Created views for:
- Joining employee and department info
- Hiding salary data for public access
- Filtering high-earning employees

### 3. Queried data from the views like normal tables

## Examples

### Example 1: View: Employee Details with Department
> Create a View to Show Employee Details with Department
```sql
CREATE VIEW view_employee_details AS
SELECT e.emp_id, e.emp_name, d.dep_name, e.salary, e.hire_date
FROM employees e
JOIN departments d ON e.dep_id = d.dep_id;
```
### Example 2: View Without Salary (For Security)
> Create a view to show employees without salary in publice view, due to security reasions
```sql
CREATE VIEW view_employees_public AS
SELECT emp_id, emp_name, dep_id, hire_date
FROM employees;
```

### Example 3: High Earners View
> Create a view to show high salary employees
```sql
CREATE VIEW view_high_salary AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 50000;
```

### Example 4: Update view
> Update the view by using `REPLACE` command (MySql) and `ALTER` command (SQL server), you can use it with `OR` during the createtion of views.
```sql
CREATE OR REPLACE VIEW view_high_salary AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 60000;
```

### Example 5: Drop a View
> delete or remove view by using `DROP`.
```sql
DROP VIEW IF EXISTS view_high_salary;
```
### Example 6:  View with Aggregation – Average Salary by Department
> Create the view to calculate avergae salary department wise by using `AVG` aggrigate function and `GROUP BY` clause.
```sql
CREATE VIEW view_avg_salary_by_departments AS
SELECT d.dep_name, ROUND(AVG(e.salary)) AS avg_salary 
FROM departments d 
JOIN employees e ON e.dep_id = d.dep_id
GROUP BY d.dep_name;
```

###  Example 7: View with Date Filter – Recently Hired Employees
> Create the view for display recentaly hired employees after `2022-01-01`
```sql
CREATE VIEW  view_recent_hires AS
SELECT emp_id, emp_name, hire_date
FROM employees 
WHERE hire_date >= DATE('2022-01-01');
```

### Example 8:  View with CASE Logic – Salary Grade Classification
> Create the view to assign Grad by using `CASE` and display salary grade classification of employees
```sql
CREATE VIEW view_salary_grade AS 
SELECT emp_id, emp_name, salary,
      CASE WHEN salary >= 70000 THEN 'A'
           WHEN salary >= 50000 THEN 'B'
           ELSE 'C'
      END AS salary_garde
FROM employees;
```

### Example 9: Filtered Department View – Only IT Department Employees
> Create the view for retives employees of department `IT`
```sql
CREATE VIEW view_it_employees AS
SELECT emp_id, emp_name, salary
FROM employees 
WHERE dep_id = (SELECT dep_id FROM departments WHERE dep_name = 'IT');
```

### Example 10: Nested View – Use a View Inside Another View
> Create views to use in nesting, to display the high earning employees (whose `Salary >60000`) and their `10%` bonus amount in seprate column `Bonus`.
```sql
-- First create a view_high_earners of high earners 
CREATE VIEW view_high_earners AS 
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 60000;

-- Now, create a new view_high_earners_bonus to show their name and salary with bonus
CREATE VIEW view_high_earners_bonus AS 
SELECT emp_name, salary, salary * 0.10 AS bonus
FROM view_high_earners;

```
