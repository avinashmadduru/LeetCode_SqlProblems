SELECT user_id AS buyer_id,join_date, SUM(CASE WHEN order_date LIKE '2019%' THEN 1 ELSE 0 END) AS orders_in_2019
FROM Users u 
LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
GROUP BY user_id
    ;