/* =========================================================
Step 1: Classifying Data Using CASE Expression
========================================================= */

CREATE TABLE schema_audit (
    schema_name VARCHAR(50),
    violation_count INT
);

INSERT INTO schema_audit VALUES
('auth_schema', 0),
('user_schema', 2),
('payment_schema', 5),
('admin_schema', 9),
('log_schema', 14);

SELECT
    schema_name,
    violation_count,
    CASE
        WHEN violation_count = 0 THEN 'No Violation'
        WHEN violation_count BETWEEN 1 AND 3 THEN 'Minor Violation'
        WHEN violation_count BETWEEN 4 AND 7 THEN 'Moderate Violation'
        ELSE 'Critical Violation'
    END AS violation_level
FROM schema_audit;


/* =========================================================
Step 2: Applying CASE Logic in Data Updates
========================================================= */

ALTER TABLE schema_audit
ADD COLUMN approval_status VARCHAR(30);

UPDATE schema_audit
SET approval_status =
    CASE
        WHEN violation_count = 0 THEN 'Approved'
        WHEN violation_count BETWEEN 1 AND 5 THEN 'Needs Review'
        ELSE 'Rejected'
    END;

SELECT * FROM schema_audit;


/* =========================================================
Step 3: Implementing IF–ELSE Logic Using PL/pgSQL
========================================================= */

DO $$
DECLARE
    v_count INT := 6;
BEGIN
    IF v_count = 0 THEN
        RAISE NOTICE 'Schema Status: Approved';
    ELSIF v_count <= 5 THEN
        RAISE NOTICE 'Schema Status: Needs Review';
    ELSE
        RAISE NOTICE 'Schema Status: Rejected';
    END IF;
END $$;


/* =========================================================
Step 4: Real-World Classification Scenario (Grading System)
========================================================= */

CREATE TABLE student_results (
    student_id INT,
    student_name VARCHAR(50),
    marks INT
);

INSERT INTO student_results VALUES
(1, 'Amit', 92),
(2, 'Riya', 78),
(3, 'Rahul', 64),
(4, 'Sneha', 48),
(5, 'Karan', 85);

SELECT
    student_name,
    marks,
    CASE
        WHEN marks >= 90 THEN 'A'
        WHEN marks >= 75 THEN 'B'
        WHEN marks >= 50 THEN 'C'
        ELSE 'D'
    END AS grade
FROM student_results;


/* =========================================================
Step 5: Using CASE for Custom Sorting
========================================================= */

SELECT
    schema_name,
    violation_count,
    approval_status
FROM schema_audit
ORDER BY
    CASE
        WHEN violation_count = 0 THEN 1
        WHEN violation_count BETWEEN 1 AND 3 THEN 2
        WHEN violation_count BETWEEN 4 AND 7 THEN 3
        ELSE 4
    END,
    violation_count DESC;
