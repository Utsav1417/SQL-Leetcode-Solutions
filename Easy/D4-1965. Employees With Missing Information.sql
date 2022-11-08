-- 1965. Employees With Missing Information

-- Table: Employees

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | name        | varchar |
-- +-------------+---------+
-- employee_id is the primary key for this table.
-- Each row of this table indicates the name of the employee whose ID is employee_id.
 

-- Table: Salaries

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | employee_id | int     |
-- | salary      | int     |
-- +-------------+---------+
-- employee_id is the primary key for this table.
-- Each row of this table indicates the salary of the employee whose ID is employee_id.
 

-- Write an SQL query to report the IDs of all the employees with missing information. The information of an employee is missing if:

-- The employee's name is missing, or
-- The employee's salary is missing.
-- Return the result table ordered by employee_id in ascending order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Employees table:
-- +-------------+----------+
-- | employee_id | name     |
-- +-------------+----------+
-- | 2           | Crew     |
-- | 4           | Haven    |
-- | 5           | Kristian |
-- +-------------+----------+
-- Salaries table:
-- +-------------+--------+
-- | employee_id | salary |
-- +-------------+--------+
-- | 5           | 76071  |
-- | 1           | 22517  |
-- | 4           | 63539  |
-- +-------------+--------+
-- Output: 
-- +-------------+
-- | employee_id |
-- +-------------+
-- | 1           |
-- | 2           |
-- +-------------+
-- Explanation: 
-- Employees 1, 2, 4, and 5 are working at this company.
-- The name of employee 1 is missing.
-- The salary of employee 2 is missing.


-- ===============================================================================
-- ===============================================================================


-- My Solution
Select employee_id 
from Employees 
where employee_id not in (Select employee_id from Salaries)
Union
Select employee_id 
from Salaries 
where employee_id not in (Select employee_id from Employees)
order by employee_id;


-- ===============================================================================
-- ===============================================================================


-- Others Solutions
select e.employee_id from Employees e  
left join Salaries s on e.employee_id=s.employee_id
where salary is null 
union 
select s.employee_id from Salaries s
left join Employees e  on e.employee_id=s.employee_id
where name is null 
order by employee_id;


SELECT T.employee_id
FROM  
  (SELECT * FROM Employees LEFT JOIN Salaries USING(employee_id)
   UNION 
   SELECT * FROM Employees RIGHT JOIN Salaries USING(employee_id))
AS T
WHERE T.salary IS NULL OR T.name IS NULL
ORDER BY employee_id;


-- ORACLE
SELECT NVL(E.EMPLOYEE_ID, S.EMPLOYEE_ID) AS EMPLOYEE_ID 
FROM EMPLOYEES E
FULL JOIN SALARIES S ON E.EMPLOYEE_ID = S.EMPLOYEE_ID
WHERE E.NAME IS NULL
OR S.SALARY IS NULL 
ORDER BY EMPLOYEE_ID;