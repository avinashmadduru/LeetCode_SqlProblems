SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN 
(
    SELECT tiv_2015 FROM Insurance 
    GROUP BY tiv_2015
    HAVING COUNT(tiv_2015) >1
)
AND pid NOT IN(
    SELECT i1.pid 
    FROM Insurance i1
    CROSS JOIN Insurance i2
    WHERE i1.lat = i2.lat AND i1.lon = i2.lon AND i1.pid != i2.pid
)
;