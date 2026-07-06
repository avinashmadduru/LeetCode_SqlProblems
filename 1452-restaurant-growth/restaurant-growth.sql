WITH cte AS (
SELECT visited_on, SUM(amount) AS amount
FROM customer 
GROUP BY visited_on
), cte2 AS (
SELECT visited_on,SUM(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount, ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS average_amount
FROM cte 
ORDER BY visited_on
)SELECT *
FROM cte2 
WHERE visited_on >= (SELECT visited_on FROM customer ORDER BY visited_on LIMIT 1) + 6
