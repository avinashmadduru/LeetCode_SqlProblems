SELECT contest_id, 
ROUND((COUNT(u.user_id)/(SELECT COUNT(user_id)
FROM Users)* 100),2) AS percentage
FROM Users u 
JOIN Register r
    ON u.user_id = r.user_id
GROUP BY contest_id
ORDER BY percentage DESC,r.contest_id ASC;


