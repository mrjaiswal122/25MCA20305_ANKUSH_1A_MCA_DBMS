# Worksheet No. - 6

**Student Name:** Ankush kumar\
**UID:** 25MCA20305\
**Branch:** MCA\
**Section/Group:** 1A\
**Semester:** 2nd\
**Date of Performance:** 27th Jan, 2026\
**Subject Name:** TECHNICAL TRAINING\
**Subject Code:** 25CAP-652

------------------------------------------------------------------------

## Aim/Overview of the Practical

Learn how to create, query, and manage views in SQL to simplify database
queries and provide a layer of abstraction for end-users.

(Company Tags: Amazon, Zoho, ServiceNow)

------------------------------------------------------------------------

## Objectives

-   **Data Abstraction:** To understand how to hide complex table joins
    and calculations behind a simple virtual table interface.\
-   **Enhanced Security:** To learn how to restrict user access to
    sensitive columns by providing views instead of direct table
    access.\
-   **Query Simplification:** To master the creation of views that
    pre-join multiple tables, making reporting easier for non-technical
    users.\
-   **View Management:** To understand the syntax for creating,
    altering, and dropping views, as well as the naming conventions
    required for efficient data access.

------------------------------------------------------------------------

## Input/Apparatus Used

-   PostgreSQL\
-   pgAdmin

------------------------------------------------------------------------

## Theory

A View is essentially a virtual table based on the result-set of an SQL
statement. It does not contain data of its own but dynamically pulls
data from the underlying base tables.

-   **Simple Views:** Created from a single table without any aggregate
    functions or grouping. These are often updatable.\
-   **Complex Views:** Created from multiple tables using JOINs, or
    including GROUP BY and aggregate functions. These provide a
    consolidated summary of the database.\
-   **Security Layer:** In enterprise environments, views are used to
    grant permissions on specific subsets of data.

**Benefits:** They simplify the user experience, ensure data consistency
across reports, and reduce the risk of accidental data modification by
providing read-only abstractions.

------------------------------------------------------------------------

## Procedure / Algorithm / Code

``` sql
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary NUMERIC,
    status VARCHAR(10),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO department VALUES
(1, 'IT'),
(2, 'Sales'),
(3, 'HR');

INSERT INTO employee VALUES
(1, 'Sanchit', 30000, 'Active', 2),
(2, 'Swayam', 40000, 'Active', 2),
(3, 'Anindita', 25000, 'Inactive', 1),
(4, 'Ankush', 35000, 'Active', 3),
(5, 'Roshan', 28000, 'Active', 1);
```

------------------------------------------------------------------------

### Step 1: Creating a Simple View for Data Filtering

``` sql
CREATE VIEW active_employees AS
SELECT emp_id, emp_name, dept_id
FROM employee
WHERE status = 'Active';

SELECT * FROM active_employees;
```

------------------------------------------------------------------------

### Step 2: Creating a View for Joining Multiple Tables

``` sql
CREATE VIEW employee_department_view AS
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employee e
JOIN department d ON e.dept_id = d.dept_id;

SELECT * FROM employee_department_view;
```

------------------------------------------------------------------------

### Step 3: Advanced Summarization View

``` sql
CREATE VIEW department_summary AS
SELECT d.dept_name,
       COUNT(e.emp_id) AS total_employees,
       AVG(e.salary) AS average_salary
FROM department d
JOIN employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT * FROM department_summary;
```

------------------------------------------------------------------------

## Output

### Tables Data

![Tables
Output](./Screenshots/departments.png)

### Active Employees View

![Active Employees
View](./Screenshots/employees.png)

### Employee Department Join View

![Employee Department
View](./Screenshots/block2.png)

### Department Summary View

![Department
Summary](./Screenshots/block3.png)

------------------------------------------------------------------------

## Learning Outcomes (What I have learnt)

1.  I learned how to create and use views to simplify complex queries,
    making data retrieval easier and more structured for end-users.

2.  I understood how views provide data abstraction by hiding underlying
    table structures and joins behind a virtual table interface.

3.  I gained practical knowledge of implementing security through views,
    restricting access to sensitive columns and exposing only required
    data.

4.  I developed the ability to design both simple and complex views,
    including filtered views, joined views, and aggregate summary views
    for real-world business scenarios.
