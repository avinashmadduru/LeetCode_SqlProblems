WITH cte AS (
SELECT *,YEAR(meeting_date) AS year_mon,
WEEK(meeting_date,1) AS week_mon
FROM meetings 
), cte2 AS (
SELECT employee_id,SUM(duration_hours) AS meeting_hours,week_mon
FROM cte 
GROUP BY employee_id, week_mon,year_mon 
HAVING meeting_hours > 20
)SELECT e.employee_id,employee_name,department,COUNT(week_mon) AS meeting_heavy_weeks
FROM cte2 c
JOIN employees e
    ON c.employee_id = e.employee_id
GROUP BY employee_id
HAVING meeting_heavy_weeks >= 2
ORDER BY meeting_heavy_weeks DESC,employee_name