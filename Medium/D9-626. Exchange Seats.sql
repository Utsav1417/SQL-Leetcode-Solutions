-- 626. Exchange Seats

-- Table: Seat

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- id is a continuous increment.
 

-- Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

-- Return the result table ordered by id in ascending order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Seat table:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Abbot   |
-- | 2  | Doris   |
-- | 3  | Emerson |
-- | 4  | Green   |
-- | 5  | Jeames  |
-- +----+---------+
-- Output: 
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Doris   |
-- | 2  | Abbot   |
-- | 3  | Green   |
-- | 4  | Emerson |
-- | 5  | Jeames  |
-- +----+---------+
-- Explanation: 
-- Note that if the number of students is odd, there is no need to change the last one's seat.

 
 
-- =================================================================================
-- =================================================================================
 
 
-- My Solution
SELECT ROW_NUMBER() OVER() id, student
FROM seat
ORDER BY IF(MOD(id, 2) = 0, id-1, id+1) 
 
-- =================================================================================
-- =================================================================================
 
 
-- Others Solution
select 
Case
    When id%2 = 1 and id != (select count(id) from seat) then id+1
    When id%2 = 0 then id-1
    ELSE id
END as id, student
from seat 
order by id



SELECT  IF(id % 2 = 0 , #condition checks when id is even 
           id-1 ,       # when true then directly do - 1
           IF(id != ( SELECT MAX(id) FROM SEAT ),id+1,id)) AS id #when false then check that if id is not last id (in case of odd numbered data set) then do id+1 else dont change id. 
        ,student
    FROM SEAT
    ORDER BY id;
                 

SELECT 
  id, 
  CASE WHEN id % 2 = 1 
  AND id NOT IN (
    SELECT 
      MAX(id) 
    FROM 
      Seat
  ) THEN LEAD(student, 1) OVER (
    ORDER BY 
      id ASC
  ) WHEN id % 2 = 1 
  AND id IN (
    SELECT 
      MAX(id) 
    FROM 
      Seat
  ) THEN student ELSE LAG(student, 1) OVER (
    ORDER BY 
      id ASC
  ) END AS student 
FROM 
  Seat
