SELECT name AS Customers
FROM customers c
LEFT JOIN orders o 
    ON c.id = o.customerId
WHERE o.id IS NULL;