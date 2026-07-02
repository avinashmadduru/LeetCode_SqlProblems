WITH cte AS (
SELECT *, DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS rnk
FROM Employee
)SELECT d.name AS Department, e.name AS Employee, salary 
FROM cte e
JOIN Department d 
    ON e.departmentId = d.id
WHERE rnk = 1
ORDER BY e.id;
