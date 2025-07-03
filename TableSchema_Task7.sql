-- Task:7 creating views

-- Table1: departments
CREATE TABLE departments
(
	dep_id INT PRIMARY KEY,
	dep_name VARCHAR(50) NOT NULL
);

-- Table2: employees
CREATE TABLE employees
(
	emp_id INT PRIMARY KEY,
	emp_name VARCHAR(50),
	dep_id INT,
	salary DECIMAL(10,2),
	hire_date DATE,
	FOREIGN KEY(dep_id) REFERENCES departments(dep_id)
);



