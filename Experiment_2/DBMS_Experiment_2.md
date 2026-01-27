# Worksheet No. 2

**Student Name:** Ankush Kumar  
**UID:** 25MCA20305  
**Branch:** MCA  
**Section/Group:** 1A  
**Semester:** 2nd  
**Date of Performance:** 20th Jan, 2026  

**Subject Name:** Technical Training  
**Subject Code:** 25CAP-652  

---

## Aim / Overview of the Practical

To implement and analyse SQL **SELECT queries** using filtering, sorting, grouping, and aggregation concepts in **PostgreSQL** for efficient data retrieval and analytical reporting.

## Objective

- To retrieve specific data using filtering conditions  
- To sort query results using single and multiple attributes  
- To perform aggregation using grouping techniques  
- To apply conditions on aggregated data  
- To understand real-world analytical queries commonly asked in placement interviews  

## Input / Apparatus Used

- PostgreSQL  
- pgAdmin  

---

## Procedure / Algorithm / Code

### Create Table

```sql
CREATE TABLE Students (
    student_id INT,
    name VARCHAR(50),
    city VARCHAR(50),
    percentage DECIMAL(5,2)
);
```

### Insert Data

```sql
INSERT INTO Students VALUES
(1, 'Amit', 'Delhi', 96.5),
(2, 'Riya', 'Mumbai', 94.2),
(3, 'Rahul', 'Delhi', 97.8),
(4, 'Sneha', 'Mumbai', 98.1),
(5, 'Ankit', 'Chandigarh', 95.6),
(6, 'Pooja', 'Delhi', 93.4),
(7, 'Karan', 'Chandigarh', 96.2);
```

---

## Queries

### Without CASE Statement

```sql
SELECT city, COUNT(*) AS student_count
FROM Students
WHERE percentage > 95
GROUP BY city;
```

### With CASE Statement – I

```sql
SELECT city,
SUM(CASE WHEN percentage > 95 THEN 1 ELSE 0 END) AS student_counts
FROM Students
GROUP BY city;
```

### With CASE Statement – II

```sql
SELECT city,
AVG(CASE WHEN percentage > 95 THEN percentage ELSE NULL END) AS student_avg
FROM Students
GROUP BY city
ORDER BY student_avg DESC;
```

---

## Output

- City-wise count of students scoring above 95%  
- Comparison of results using CASE and non-CASE approaches  
- Average percentage of high-performing students city-wise  

---

## Learning Outcomes

1. Understood how data can be filtered to retrieve only relevant records.
2. Learned how sorting improves the readability and usefulness of query results.
3. Gained the ability to group data effectively for analytical purposes.
4. Clearly differentiated between row-level and group-level conditions.
5. Developed confidence in writing analytical SQL queries for real-world scenarios.
6. Became better prepared for SQL-based placement and interview questions.

---

## Result Variants

- Without CASE Statement  
- With CASE Statement – I  
- With CASE Statement – II  
