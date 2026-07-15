WITH cte AS (
    SELECT *,ROW_NUMBER() OVER() AS rnk
    FROM stadium 
), cte2 AS (
    SELECT *,LEAD(rnk) OVER() AS next,LEAD(rnk,2) OVER() AS next_next
    FROM cte 
    WHERE people >= 100
), cte3 AS (
    SELECT *,CASE WHEN rnk + 1 = next AND rnk + 2 = next_next THEN 1 ELSE 0 END AS flag
    FROM cte2 
)SELECT c2.id,c2.visit_date,c2.people
FROM cte3 c1
JOIN cte c2
    ON c1.rnk = c2.rnk OR c1.next = c2.rnk OR c1.next_next = c2.rnk
WHERE flag = 1
GROUP BY c2.rnk 