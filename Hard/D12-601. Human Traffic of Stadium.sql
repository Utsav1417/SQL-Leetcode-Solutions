-- 601. Human Traffic of Stadium

-- Table: Stadium

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | visit_date    | date    |
-- | people        | int     |
-- +---------------+---------+
-- visit_date is the primary key for this table.
-- Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
-- No two rows will have the same visit_date, and as the id increases, the dates increase as well.
 

-- Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

-- Return the result table ordered by visit_date in ascending order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Stadium table:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Output: 
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Explanation: 
-- The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
-- The rows with ids 2 and 3 are not included because we need at least three consecutive ids.


 
 
-- =================================================================================
-- =================================================================================
 
 
-- My Solution

 
-- =================================================================================
-- =================================================================================
 
 
-- Others Solution
with q1 as (
select *, 
     count(*) over( order by id range between current row and 2 following ) following_cnt,
     count(*) over( order by id range between 2 preceding and current row ) preceding_cnt,
     count(*) over( order by id range between 1 preceding and 1 following ) current_cnt
from stadium
where people > 99
)
select id, visit_date, people
from q1
where following_cnt = 3 or preceding_cnt = 3 or current_cnt = 3
order by visit_date


with q1 as (
select id, id - row_number() over() as id_diff
from stadium
where people > 99
),
q2 as (
select *, row_number() over(partition by id_diff) as id_diff_order
from q1
),
q3 as (
select id
from q2
where id_diff in (select id_diff from q2 where id_diff_order > 2 group by id_diff)
)
select *
from stadium
where id in (select id from q3)
order by visit_date


with q1 as (
select *, id - row_number() over() as id_diff
from stadium
where people > 99
)
select id, visit_date, people
from q1
where id_diff in (select id_diff from q1 group by id_diff having count(*) > 2)
order by visit_date


SELECT ID
    , visit_date
    , people
FROM (
    SELECT ID
        , visit_date
        , people
        , LEAD(people, 1) OVER (ORDER BY id) nxt
        , LEAD(people, 2) OVER (ORDER BY id) nxt2
        , LAG(people, 1) OVER (ORDER BY id) pre
        , LAG(people, 2) OVER (ORDER BY id) pre2
    FROM Stadium
) cte 
WHERE (cte.people >= 100 AND cte.nxt >= 100 AND cte.nxt2 >= 100) 
    OR (cte.people >= 100 AND cte.nxt >= 100 AND cte.pre >= 100)  
    OR (cte.people >= 100 AND cte.pre >= 100 AND cte.pre2 >= 100) 