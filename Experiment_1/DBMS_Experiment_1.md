# Worksheet No. 1

**Student Name:** Ankush Kumar  
**UID:** 25MCA20305  
**Branch:** MCA  
**Section/Group:** 1A  
**Semester:** 2nd  
**Date of Performance:** 6th Jan, 2026  

**Subject Name:** Technical Training  
**Subject Code:** 25CAP-652  

---

## Aim / Overview of the Practical

To design and implement a **Department–Employee database system** using **DDL, DML, and DCL**
commands, including schema creation, data manipulation, and role-based access control to
ensure data integrity and secure read-only access.

## Objective

To gain practical experience in implementing:
- Data Definition Language (DDL)
- Data Manipulation Language (DML)
- Data Control Language (DCL)

using a real-world **Department, Employee, and Project** database model.

## Input / Apparatus Used

- PostgreSQL  
- pgAdmin  

---

## Procedure / Algorithm / Code

### Create Tables

```sql
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
```

### Insert Data

```sql
INSERT INTO department VALUES
(1, 'Engineering', 'Bangalore'),
(2, 'HR', 'Delhi');

INSERT INTO employee VALUES
(101, 'Amit Kumar', 'amit@gmail.com', 60000, 1),
(102, 'Neha Sharma', 'neha@gmail.com', 50000, 2);

INSERT INTO project(project_id, project_name, emp_id, start_date, end_date)
VALUES
(1001, 'Employee Management System', 101, '2025-01-10', NULL);
```

### Retrieve Data

```sql
SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM project;
```

### Update Records

```sql
UPDATE employee
SET salary = salary + 5000
WHERE emp_id = 101;
```

### Delete Records

```sql
DELETE FROM department WHERE dept_id = 2;
```

### Role Creation and Permissions

```sql
CREATE ROLE app_user
WITH LOGIN PASSWORD 'ankudata';

GRANT SELECT ON department, employee, project TO app_user;
```

---

## Output

- Department, employee, and project records displayed successfully  
- Employee salary updated correctly  
- Role `app_user` created with read-only access  

---

## Learning Outcomes

1. Learned to design a real-world **Department–Employee** relational schema.
2. Understood one-to-many relationships using foreign keys.
3. Practiced CRUD operations on multiple related tables.
4. Applied business logic such as salary updates.
5. Learned role-based access control using DCL commands.

