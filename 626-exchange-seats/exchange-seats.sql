WITH cte AS (
SELECT *, LEAD(id) OVER() AS next, LAG(id) OVER() AS prev
FROM Seat 
)
SELECT  
CASE 
    WHEN (id % 2 != 0) AND next IS NOT NULL THEN next 
    WHEN (id % 2 = 0) THEN prev
    ELSE id 
END AS id , student
FROM cte
ORDER BY id


