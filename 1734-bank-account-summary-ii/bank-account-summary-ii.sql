SELECT name, SUM(amount) AS balance
FROM Transactions t
JOIN Users u
    ON t.account = u.account
GROUP BY t.account
HAVING balance > 10000;