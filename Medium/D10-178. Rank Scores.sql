-- 178. Rank Scores

-- Table: Scores

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | score       | decimal |
-- +-------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
 

-- Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:

-- The scores should be ranked from the highest to the lowest.
-- If there is a tie between two scores, both should have the same ranking.
-- After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
-- Return the result table ordered by score in descending order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Scores table:
-- +----+-------+
-- | id | score |
-- +----+-------+
-- | 1  | 3.50  |
-- | 2  | 3.65  |
-- | 3  | 4.00  |
-- | 4  | 3.85  |
-- | 5  | 4.00  |
-- | 6  | 3.65  |
-- +----+-------+
-- Output: 
-- +-------+------+
-- | score | rank |
-- +-------+------+
-- | 4.00  | 1    |
-- | 4.00  | 1    |
-- | 3.85  | 2    |
-- | 3.65  | 3    |
-- | 3.65  | 3    |
-- | 3.50  | 4    |
-- +-------+------+

 
 
-- =================================================================================
-- =================================================================================
 
 
-- My Solution
select 
  score, 
  dense_rank() over(
    order by 
      score desc
  ) as 'rank' 
from 
  scores;

 
-- =================================================================================
-- =================================================================================
 
 
-- Others Solution
SELECT s1.score AS score, 
(
    SELECT COUNT(DISTINCT s2.score) 
    FROM scores s2 
    WHERE s1.score < s2.score 
) + 1 AS rank
FROM Scores s1
ORDER BY score DESC;


SELECT Score, convert(Rank,SIGNED) AS Rank FROM
    (SELECT Score, @rank:=CASE WHEN Score=@previous THEN @rank ELSE @rank+1 END AS Rank, @previous:=Score FROM Scores,
        (SELECT @previous:=-1,@rank:=0) AS initial
    ORDER BY Score DESC) A;  


SELECT S.Score, COUNT(S2.Score) AS Rank FROM Scores S,
(SELECT DISTINCT Score FROM Scores) S2
WHERE S.Score<=S2.Score
GROUP BY S.Id 
ORDER BY S.Score DESC;


