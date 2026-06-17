# Write your MySQL query statement below
SELECT name AS customers
FROM  Customers AS ct 
LEFT JOIN Orders AS ot
    ON ct.id = ot.customerId
    WHERE ot.id IS NULL;