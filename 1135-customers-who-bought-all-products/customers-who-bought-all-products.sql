WITH cte AS (
SELECT COUNT(DISTINCT product_key) AS product_count
FROM product
), cte2 AS (
SELECT customer_id,COUNT(DISTINCT product_key) AS buy_count
FROM customer
GROUP BY customer_id
)SELECT customer_id 
FROM cte2 c1
JOIN cte c2     
    ON c1.buy_count = c2.product_count
;