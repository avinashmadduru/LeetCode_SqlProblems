WITH cte AS (
    SELECT *, 
           ROW_NUMBER() OVER(PARTITION BY patient_id, result ORDER BY test_date) AS rnk 
    FROM covid_tests 
), 
cte2 AS (
    SELECT c1.patient_id, 
           ROW_NUMBER() OVER(PARTITION BY patient_id ORDER BY c2.test_date) AS rnk2, 
           DATEDIFF(c2.test_date, c1.test_date) AS recovery_time 
    FROM cte c1 
    LEFT JOIN cte c2 ON c1.patient_id = c2.patient_id AND c1.test_date < c2.test_date 
    WHERE c1.result = 'Positive' 
      AND c1.rnk = 1 
      AND c2.result = 'Negative' 
)
SELECT c.patient_id, p.patient_name, p.age, c.recovery_time 
FROM cte2 c 
LEFT JOIN patients p ON c.patient_id = p.patient_id 
WHERE rnk2 = 1 
ORDER BY recovery_time, p.patient_name;
