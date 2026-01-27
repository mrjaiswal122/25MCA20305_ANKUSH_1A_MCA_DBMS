CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100)
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary INT CHECK (salary > 0),
    dept_id INT REFERENCES department(dept_id)
);

CREATE TABLE project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    emp_id INT REFERENCES employee(emp_id),
    start_date DATE,
    end_date DATE
);

INSERT INTO department VALUES
(1, 'Engineering', 'Bangalore'),
(2, 'HR', 'Delhi'),
(3, 'Civil', 'Goa');

INSERT INTO employee VALUES
(101, 'Amit Kumar', 'amit@gmail.com', 65000, 1),
(102, 'Neha Sharma', 'neha@gmail.com', 50000, 2);

-- PROJECT ASSIGNMENT
INSERT INTO project(project_id, project_name, emp_id, start_date, end_date)
VALUES
(1001, 'Employee Management System', 101, '2025-01-10', NULL);

SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM project;

-- UPDATE EMPLOYEE SALARY
UPDATE employee
SET salary = salary + 5000
WHERE emp_id = 101;

-- DELETE DEPARTMENT
DELETE FROM department WHERE dept_id = 3;

CREATE ROLE app_users
WITH LOGIN PASSWORD 'ankudata';

GRANT SELECT ON department, employee, project TO app_user;
