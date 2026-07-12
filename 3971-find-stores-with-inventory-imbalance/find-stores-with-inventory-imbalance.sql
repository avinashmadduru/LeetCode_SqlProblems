WITH cte AS (
SELECT *,ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY price DESC) AS high_rnk,ROW_NUMBER() OVER(PARTITION BY store_id ORDER BY price) AS low_rnk
FROM inventory
WHERE store_id IN (
    SELECT store_id
    FROM inventory 
    GROUP BY store_id
    HAVING COUNT(product_name) >=3
    )
), high_price AS (
SELECT * 
FROM cte 
WHERE high_rnk = 1
), low_price AS (
SELECT *
FROM cte
WHERE low_rnk = 1
)
SELECT h.store_id,store_name,location,h.product_name AS most_exp_product, l.product_name AS cheapest_product,ROUND(l.quantity/h.quantity,2) AS imbalance_ratio
FROM high_price h
JOIN low_price l 
    ON h.store_id = l.store_id
JOIN stores s
    ON h.store_id = s.store_id
WHERE h.quantity < l.quantity
ORDER BY imbalance_ratio DESC,store_name
