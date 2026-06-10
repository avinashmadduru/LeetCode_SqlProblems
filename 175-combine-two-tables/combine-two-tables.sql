# Write your MySQL query statement below
SELECT firstName,lastName,city,state
FROM Person person_table
LEFT JOIN Address address_table
    ON person_table.personId=address_table.personId;