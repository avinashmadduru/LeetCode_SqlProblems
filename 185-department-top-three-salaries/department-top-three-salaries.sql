WITH cte AS (
SELECT *,DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS rnk
FROM employee
)SELECT d.name AS Department,c.name AS Employee,salary 
FROM cte c
JOIN department d
    ON c.departmentId = d.id
WHERE rnk = 1 OR rnk = 2 OR rnk = 3
