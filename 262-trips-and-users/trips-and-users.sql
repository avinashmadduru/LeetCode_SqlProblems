WITH cte AS (
SELECT request_at AS `Day`,COUNT(status) AS total_status, SUM(CASE WHEN status != 'completed' THEN 1 ELSE 0 END) AS cancelled_count
FROM Trips 
WHERE client_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes') AND driver_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes')
GROUP BY request_at
)SELECT `Day`, ROUND(COALESCE(cancelled_count/total_status,0),2) AS 'Cancellation Rate'
FROM cte 
WHERE `Day` BETWEEN '2013-10-01' AND '2013-10-03'
