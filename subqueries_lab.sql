-- Guided Lab - 304.7.1: Subqueries

-- 1. Find all employees who are located at the location with the ID 1700
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location_id = 1700
)
ORDER BY first_name, last_name;

-- 2. Find all employees who do not locate at location 1700
SELECT employee_id, first_name, last_name
FROM employees
WHERE department_id NOT IN (
    SELECT department_id
    FROM departments
    WHERE location_id = 1700
)
ORDER BY first_name, last_name;

-- 3. Find the employees who have the highest salary
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
)
ORDER BY first_name, last_name;

-- 4. Find employees whose salary is higher than the average salary throughout the company
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 5. Find all departments that have at least one employee with a salary greater than 10,000
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE salary > 10000 AND e.department_id = d.department_id
)
ORDER BY department_name;

-- 6. Find all departments that do not have an employee with a salary greater than 10,000
SELECT department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE salary > 10000 AND e.department_id = d.department_id
)
ORDER BY department_name;

-- 7. Calculate the average of the average salaries of departments
SELECT ROUND(AVG(average_salary), 0) AS overall_avg_salary
FROM (
    SELECT AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
) department_salary;

-- Note: The following query requires the 'classicmodels' database, which is not provided in the given schema.
-- If you have access to the 'classicmodels' database, you can uncomment and run this query.

/*
-- 8. Get the top five products by sales revenue in 2003 with their product names
SELECT productName, sales
FROM (
    SELECT productCode, ROUND(SUM(quantityOrdered * priceEach)) AS sales
    FROM orderdetails
    INNER JOIN orders USING (orderNumber)
    WHERE YEAR(shippedDate) = 2003
    GROUP BY productCode
    ORDER BY sales DESC
    LIMIT 5
) AS top5products2003
INNER JOIN products USING (productCode);
*/