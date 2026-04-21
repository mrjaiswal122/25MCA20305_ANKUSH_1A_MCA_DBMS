# Worksheet No. - 9  

**Student Name:** Ankush kumar\
**UID:** 25MCA20305\
**Branch:** MCA\
**Section/Group:** 1A\
**Semester:** 2nd\
**Date of Performance:** 1th Apr, 2026\
**Subject Name:** TECHNICAL TRAINING\
**Subject Code:** 25CAP-652  

------------------------------------------------------------------------  

## Aim/Overview of the Practical  

Apply trigger concepts to enforce constraints and automate tasks  

------------------------------------------------------------------------  

## Objective  

To apply the concept of Triggers in database operations in order to perform tasks like:  

- Insertion  
- Updating  
- Deletion  
- Retrieval  

of data efficiently and securely within the database system.  

------------------------------------------------------------------------  

## Input/Apparatus Used  

- PostgreSQL  
- pgAdmin  

------------------------------------------------------------------------  


## Procedure / Algorithm / Code

### 1. Drop Existing Tables (Cleanup)

```sql
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS user_logs;
DROP TABLE IF EXISTS update_logs;
DROP TABLE IF EXISTS delete_logs;
```

------------------------------------------------------------------------

### 2. Create Main Table

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
```

------------------------------------------------------------------------

### 3. Create Log Tables

```sql
CREATE TABLE user_logs (
    log_id SERIAL PRIMARY KEY,
    user_id INT,
    action TEXT,
    log_time TIMESTAMP
);

CREATE TABLE update_logs (
    id SERIAL PRIMARY KEY,
    old_name TEXT,
    new_name TEXT,
    updated_at TIMESTAMP
);

CREATE TABLE delete_logs (
    id SERIAL PRIMARY KEY,
    deleted_user TEXT,
    deleted_at TIMESTAMP
);
```

------------------------------------------------------------------------

### 4. BEFORE INSERT Trigger

```sql
CREATE OR REPLACE FUNCTION before_insert_users()
RETURNS TRIGGER AS $$
BEGIN
    NEW.created_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION before_insert_users();
```

------------------------------------------------------------------------

### 5. AFTER INSERT Trigger

```sql
CREATE OR REPLACE FUNCTION after_insert_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO user_logs(user_id, action, log_time)
    VALUES (NEW.id, 'INSERT', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_insert_users
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION after_insert_users();
```

------------------------------------------------------------------------

### 6. BEFORE UPDATE Trigger

```sql
CREATE OR REPLACE FUNCTION before_update_users()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.name IS NULL THEN
        RAISE EXCEPTION 'Name cannot be NULL';
    END IF;

    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_update_users
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION before_update_users();
```

------------------------------------------------------------------------

### 7. AFTER UPDATE Trigger

```sql
CREATE OR REPLACE FUNCTION after_update_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO update_logs(old_name, new_name, updated_at)
    VALUES (OLD.name, NEW.name, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_update_users
AFTER UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION after_update_users();
```

------------------------------------------------------------------------

### 8. BEFORE DELETE Trigger

```sql
CREATE OR REPLACE FUNCTION before_delete_users()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.name = 'admin' THEN
        RAISE EXCEPTION 'Cannot delete admin user';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_before_delete_users
BEFORE DELETE ON users
FOR EACH ROW
EXECUTE FUNCTION before_delete_users();
```

------------------------------------------------------------------------

### 9. AFTER DELETE Trigger

```sql
CREATE OR REPLACE FUNCTION after_delete_users()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO delete_logs(deleted_user, deleted_at)
    VALUES (OLD.name, NOW());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_delete_users
AFTER DELETE ON users
FOR EACH ROW
EXECUTE FUNCTION after_delete_users();
```

------------------------------------------------------------------------

### 10. Statement Level Trigger

```sql
CREATE OR REPLACE FUNCTION statement_trigger_example()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'A statement executed on users table';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_statement_users
AFTER INSERT ON users
FOR EACH STATEMENT
EXECUTE FUNCTION statement_trigger_example();
```

------------------------------------------------------------------------

### 11. Insert Sample Data

```sql
INSERT INTO users(name) VALUES ('Ankush');
INSERT INTO users(name) VALUES ('Rahul');
INSERT INTO users(name) VALUES ('admin');
```

------------------------------------------------------------------------

### 12. Update Sample Data

```sql
UPDATE users SET name = 'Ankush Kumar' WHERE name = 'Ankush';
```

------------------------------------------------------------------------

### 13. Delete Sample Data

```sql
DELETE FROM users WHERE name = 'Rahul';

-- This will FAIL
-- DELETE FROM users WHERE name = 'admin';
```

------------------------------------------------------------------------

### 14. View Results

```sql
SELECT * FROM users;
SELECT * FROM user_logs;
SELECT * FROM update_logs;
SELECT * FROM delete_logs;
```
------------------------------------------------------------------------  

## Output  

### 1. Deleting Admin  

![Deleting Admin](./Screenshots/delete_admin_log.png)  

### 2. Users Table  

![Users](./Screenshots/select_users.png)  

### 3. User Logs  

![User Logs](./Screenshots/select_userlogs.png)  

### 4. Update Logs  

![Update Logs](./Screenshots/select_updatelogs.png)  

### 5. Delete Logs  

![Delete Logs](./Screenshots/select_deletelogs.png)  

------------------------------------------------------------------------  

## Learning Outcomes (What I have learnt)  

1. I learned how to enforce data integrity at the database level using triggers, such as preventing invalid updates (like NULL values) and restricting deletion of important records (e.g., admin users).  
2. I understood how to automate repetitive tasks like setting timestamps (`created_at`, `updated_at`) without relying on application code, making the system more reliable and consistent.  
3. I learned how to track all important database operations (INSERT, UPDATE, DELETE) using triggers and maintain logs, which is useful for debugging, monitoring, and real-world applications.  
4. I gained clarity on when to use BEFORE, AFTER, and STATEMENT-level triggers, and how each serves a different purpose in handling database events efficiently.  
