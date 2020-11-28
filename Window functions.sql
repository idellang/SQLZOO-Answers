#1
SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC

#2
SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party

#3
SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party,yr

#4
SELECT constituency,party, votes,
 RANK() OVER (PARTITION BY constituency ORDER BY votes DESC)
  FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017
ORDER BY RANK() OVER (PARTITION BY constituency ORDER BY votes DESC), constituency ASC

#5
SELECT constituency, party FROM
(SELECT constituency,party, votes, 
RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS 'posn'
  FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017) AS t
WHERE posn = 1

#6
SELECT party, count(constituency)
FROM 
(SELECT constituency,party, votes, 
RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS 'posn'
  FROM ge
 WHERE yr  = 2017
ORDER BY constituency,votes DESC) AS b
WHERE constituency LIKE 'S%'
AND posn = 1
GROUP BY party