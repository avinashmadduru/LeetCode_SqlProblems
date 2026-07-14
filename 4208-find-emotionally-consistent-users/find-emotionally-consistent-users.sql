WITH ct AS (
    SELECT user_id AS ct_userid, COUNT(reaction) AS count_reaction
    FROM reactions 
    GROUP BY user_id
), cte AS(
SELECT *,COUNT(*) AS reaction_count
FROM reactions r
JOIN ct c 
    ON c.ct_userid = r.user_id
WHERE count_reaction >= 5
GROUP BY r.user_id,reaction
), cte2 AS (
SELECT *,ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY reaction_count DESC) AS mode 
FROM cte
WHERE reaction_count/count_reaction >= 0.6
)SELECT user_id,reaction AS dominant_reaction, ROUND(reaction_count/count_reaction,2) AS reaction_ratio
FROM cte2 
WHERE mode = 1
ORDER BY reaction_ratio DESC,user_id