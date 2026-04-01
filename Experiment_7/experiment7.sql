-- Departments
CREATE TABLE departments (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Students
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
);

-- Courses
CREATE TABLE courses (
    id INT PRIMARY KEY,
    course_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
);

-- Enrollments
CREATE TABLE enrollments (
    id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);




INSERT INTO departments (id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mechanical'),
(3, 'Electrical');

INSERT INTO students (id, name, dept_id) VALUES
(1, 'Ankush', 1),
(2, 'Rahul', 2),
(3, 'Priya', 1),
(4, 'Sneha', 3),
(5, 'Amit', 2),
(6, 'Karan', 1);  -- Not enrolled (important for LEFT JOIN questions)

INSERT INTO courses (id, course_name, dept_id) VALUES
(1, 'Data Structures', 1),
(2, 'Operating Systems', 1),
(3, 'Thermodynamics', 2),
(4, 'Machine Design', 2),
(5, 'Circuits', 3);

INSERT INTO enrollments (id, student_id, course_id) VALUES
(1, 1, 1),  -- Ankush → DS
(2, 1, 2),  -- Ankush → OS
(3, 2, 3),  -- Rahul → Thermodynamics
(4, 3, 1),  -- Priya → DS
(5, 4, 5),  -- Sneha → Circuits
(6, 5, 3),  -- Amit → Thermodynamics
(7, 5, 4);  -- Amit → Machine Design


--Question 1. Students with their enrolled courses (INNER JOIN)
SELECT s.name, c.course_name
FROM students s
INNER JOIN enrollments e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id;

--Question 2. Students NOT enrolled in any course (LEFT JOIN)
SELECT s.id, s.name
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
WHERE e.student_id IS NULL;

--Question 3. All courses with or without students (RIGHT JOIN)
SELECT c.course_name, s.name
FROM students s
RIGHT JOIN enrollments e ON s.id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.id;

--Question 4. Students with department info (Multiple JOIN)
SELECT s.name, d.dept_name
FROM students s
JOIN departments d ON s.dept_id = d.id;

--Question 5. All possible student-course combinations (CROSS JOIN)
SELECT s.name, c.course_name
FROM students s
CROSS JOIN courses c;

