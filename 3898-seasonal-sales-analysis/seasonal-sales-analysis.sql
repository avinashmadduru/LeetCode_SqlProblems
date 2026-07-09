WITH cte AS (
SELECT *,
CASE 
    WHEN MONTH(sale_date) IN (12,1,2) THEN 'Winter' 
    WHEN MONTH(sale_date) IN (3,4,5) THEN 'Spring' 
    WHEN MONTH(sale_date) IN (6,7,8) THEN 'Summer' 
    WHEN MONTH(sale_date) IN (9,10,11) THEN 'Fall' 
END AS season
FROM sales 
), cte2 AS (
SELECT season,category,SUM(quantity) AS total_quantity,SUM(price*quantity) AS total_revenue,RANK() OVER(PARTITION BY season ORDER BY SUM(quantity) DESC, SUM(price*quantity) DESC) AS rnk
FROM cte c 
JOIN products p
    on c.product_id = p.product_id
GROUP BY season,category
)SELECT season,category,total_quantity,total_revenue
FROM cte2 
WHERE rnk = 1

