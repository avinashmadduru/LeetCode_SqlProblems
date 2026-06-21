SELECT name
FROM (SELECT sales_id
FROM Orders 
JOIN Company 
    ON Orders.com_id = Company.com_id
    WHERE Company.name LIKE 'RED') AS cmp
RIGHT JOIN SalesPerson
    ON cmp.sales_id = SalesPerson.sales_id
    WHERE cmp.sales_id IS NULL;