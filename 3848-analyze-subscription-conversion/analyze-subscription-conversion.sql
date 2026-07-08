WITH cte AS (
SELECT DISTINCT user_id
FROM UserActivity
WHERE activity_type = 'paid'
) SELECT c.user_id,
ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration END),2) AS trial_avg_duration,
ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration END),2) AS paid_avg_duration
FROM cte c
RIGHT JOIN UserActivity ua
    ON c.user_id = ua.user_id 
WHERE c.user_id IS NOT NULL AND activity_type != 'cancelled'
GROUP BY c.user_id
