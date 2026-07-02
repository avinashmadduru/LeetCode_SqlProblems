WITH cte AS (
SELECT *, DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
FROM Employee
ORDER BY salary DESC
)SELECT MAX(salary) AS SecondHighestSalary
FROM cte 
WHERE rnk = 2;
