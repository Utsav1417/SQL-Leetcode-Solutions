-- 180. Consecutive Numbers

-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- id is the primary key for this table.
-- id is an autoincrement column.
 

-- Write an SQL query to find all numbers that appear at least three times consecutively.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Logs table:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.

 
 
-- =================================================================================
-- =================================================================================
 
 
-- My Solution
SELECT distinct Num as ConsecutiveNums
FROM Logs
WHERE (Id + 1, Num) in (select * from Logs) and (Id + 2, Num) in (select * from Logs)
 
-- =================================================================================
-- =================================================================================
 
 
-- Others Solution
SELECT distinct(t1.num) as ConsecutiveNums 
FROM logs t1, logs t2 , logs t3
WHERE t1.id=t2.id+1 AND t2.id=t3.id+1 AND t1.num=t2.num AND t2.num=t3.num


SELECT DISTINCT
    l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;


select distinct t.num as ConsecutiveNums
from (
    select
        lag(num) over (order by id) as prev_num,
        num,
        lead(num) over (order by id) as next_num
    from Logs
) t
where t.num = t.prev_num and t.num = t.next_num;


select distinct a.num as ConsecutiveNums from 
(select id , num, lead(num,1) over() as n1, lead(num, 2) over() as n2
from logs) a
where a.num = a.n1 and a.n1 = a.n2


SELECT DISTINCT a.num AS ConsecutiveNums 
FROM Logs a 
JOIN Logs b ON a.id=b.id+1 AND a.num=b.num
JOIN Logs c ON a.id=c.id+2 AND a.num=c.num


select distinct num as 'ConsecutiveNums' from logs m
where num = (select num from logs x where x.id=m.id+1)
and num = (select num from logs x where x.id=m.id+2);
