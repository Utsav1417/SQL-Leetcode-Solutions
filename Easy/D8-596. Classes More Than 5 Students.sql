-- 596. Classes More Than 5 Students

-- Table: Courses

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | student     | varchar |
-- | class       | varchar |
-- +-------------+---------+
-- (student, class) is the primary key column for this table.
-- Each row of this table indicates the name of a student and the class in which they are enrolled.
 

-- Write an SQL query to report all the classes that have at least five students.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Courses table:
-- +---------+----------+
-- | student | class    |
-- +---------+----------+
-- | A       | Math     |
-- | B       | English  |
-- | C       | Math     |
-- | D       | Biology  |
-- | E       | Math     |
-- | F       | Computer |
-- | G       | Math     |
-- | H       | Math     |
-- | I       | Math     |
-- +---------+----------+
-- Output: 
-- +---------+
-- | class   |
-- +---------+
-- | Math    |
-- +---------+
-- Explanation: 
-- - Math has 6 students, so we include it.
-- - English has 1 student, so we do not include it.
-- - Biology has 1 student, so we do not include it.
-- - Computer has 1 student, so we do not include it.

 
 
-- =================================================================================
-- =================================================================================
 
 
-- My Solution
Select class 
from 
(Select class, count(student) as ccount
from Courses 
group by class) as dcourses
where ccount >= 5;

 
-- =================================================================================
-- =================================================================================
 
 
-- Others Solution
select class from courses group by class having count(class)>=5;

select distinct class from Courses
group by class
having count(class) > 4;
# where count(class) > 4;


SELECT
    class, COUNT(DISTINCT student)
FROM
    courses
GROUP BY class
;