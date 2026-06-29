SELECT e.employee_id
FROM employees e
LEFT JOIN salaries s
    ON e.employee_id = s.employee_id
WHERE salary IS NULL
UNION
SELECT s.employee_id
FROM employees e
RIGHT JOIN salaries s
    ON e.employee_id = s.employee_id
WHERE name IS NULL
ORDER BY employee_id;
