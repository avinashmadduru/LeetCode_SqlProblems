WITH cte2 AS (
SELECT *, SUM(weight) OVER(ORDER BY turn) AS run_tot
FROM queue
)SELECT person_name
FROM cte2
WHERE run_tot <= 1000
ORDER BY run_tot DESC
LIMIT 1
