# tasks 7-20

# task 7
SELECT e.first_name, e.last_name, e.employee_id, e.job_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Toronto';

# task 8
SELECT e.employee_id, e.first_name, e.last_name, e.job_id
FROM employees e
WHERE e.salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE job_id = 'MK_MAN'
)
AND e.job_id <> 'MK_MAN';

# task 9
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN (40, 80);

# task 10
SELECT d.department_name,
       AVG(e.salary) AS average_salary,
       COUNT(e.commission_pct) AS num_employees_with_commission
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

# task 11
SELECT e.first_name, e.last_name, e.department_id, e.job_id
FROM employees e
WHERE e.job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id = 169
);

# task 12
SELECT employee_id, first_name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

# task 13
SELECT e.employee_id, e.first_name, e.last_name, e.job_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

# task 14
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT salary FROM employees WHERE employee_id = 182);

# task 15
DELIMITER //
CREATE PROCEDURE CountEmployeesByDept()
BEGIN
    SELECT d.department_name, COUNT(e.employee_id) AS num_employees
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    GROUP BY d.department_name;
END //
DELIMITER ;

-- Call the procedure to get employee count per department
CALL CountEmployeesByDept();

# task 16
DELIMITER //
CREATE PROCEDURE AddNewEmployee(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_job_id VARCHAR(10),
    IN p_salary DECIMAL(10,2),
    IN p_department_id INT
)
BEGIN
    INSERT INTO employees (first_name, last_name, email, job_id, salary, department_id)
    VALUES (p_first_name, p_last_name, p_email, p_job_id, p_salary, p_department_id);
END //
DELIMITER ;

-- Add a new employee
CALL AddNewEmployee(
    'John',          -- first_name
    'Doe',           -- last_name
    'john.doe@example.com', -- email
    'IT_PROG',       -- job_id
    6000.00,         -- salary
    60               -- department_id
);

# task 17
DELIMITER //
CREATE PROCEDURE DeleteEmployeesByDept(IN p_department_id INT)
BEGIN
    DELETE FROM employees
    WHERE department_id = p_department_id;
END //
DELIMITER ;

-- Delete all employees in department 50
CALL DeleteEmployeesByDept(50);


# task 18
DELIMITER //
CREATE PROCEDURE GetTopPaidEmployees()
BEGIN
    SELECT e.department_id, e.employee_id, e.first_name, e.last_name, e.salary
    FROM employees e
    JOIN (
        SELECT department_id, MAX(salary) AS max_salary
        FROM employees
        GROUP BY department_id
    ) t ON e.department_id = t.department_id AND e.salary = t.max_salary;
END //
DELIMITER ;

-- Get the highest-paid employee in each department
CALL GetTopPaidEmployees();

# task 19
DELIMITER //
CREATE PROCEDURE PromoteEmployee(
    IN p_employee_id INT,
    IN p_new_salary DECIMAL(10,2),
    IN p_new_job_id VARCHAR(10)
)
BEGIN
    UPDATE employees
    SET salary = p_new_salary, job_id = p_new_job_id
    WHERE employee_id = p_employee_id;
END //
DELIMITER ;

-- Promote employee with ID 101: new salary 8000 and new job IT_MANAGER
CALL PromoteEmployee(101, 8000.00, 'IT_MANAGER');

# task 20
DELIMITER //
CREATE PROCEDURE AssignManagerToDepartment(
    IN p_department_id INT,
    IN p_manager_id INT
)
BEGIN
    UPDATE employees
    SET manager_id = p_manager_id
    WHERE department_id = p_department_id;
END //
DELIMITER ;

-- Assign manager with ID 200 to all employees in department 40
CALL AssignManagerToDepartment(40, 200);



