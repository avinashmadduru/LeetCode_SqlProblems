CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    WITH cte AS (
        SELECT *
        ,DENSE_RANK() OVER(ORDER BY salary DESC) AS row_num
        FROM employee 
    )SELECT DISTINCT salary
    FROM cte
    WHERE row_num = N
  );
END