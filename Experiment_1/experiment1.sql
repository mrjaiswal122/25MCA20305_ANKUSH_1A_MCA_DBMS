CREATE TABLE department (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    available_copies INT CHECK (available_copies >= 0)
);

CREATE TABLE employee (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE project (
    project_id INT PRIMARY KEY,
    book_id INT REFERENCES department(book_id),
    employee_id INT REFERENCES employee(member_id),
    issue_date DATE,
    return_date DATE
);

INSERT INTO department VALUES
(1, 'DBMS Concepts', 'Silberschatz', 5),
(2, 'Operating System', 'Galvin', 3);

INSERT INTO employee VALUES
(101, 'Amit Kumar', 'amit@gmail.com'),
(102, 'Neha Sharma', 'neha@gmail.com');

-- PROJECT ASSIGNMENT
INSERT INTO project(project_id,book_id,employee_id,issue_date,
return_date)
VALUES
(1001, 1, 101, '2025-01-10', NULL);


SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM project;

--UPDATE AVAILABLE BOOKS
UPDATE department
SET available_copies = available_copies - 1
WHERE book_id = 1;

--Delete book 
DELETE FROM department WHERE book_id = 2

CREATE ROLE app_user
WITH LOGIN PASSWORD 'ankudata';

GRANT SELECT TO app_user;
