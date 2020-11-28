#1
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
  
#2
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012

#3
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER'

#4
SELECT team1, team2, player
FROM goal JOIN game
ON id = matchid
WHERE player LIKE 'Mario%'

#5
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam
ON teamid = id
 WHERE gtime<=10

#6
SELECT mdate, teamname
FROM game g
JOIN eteam e
ON g.team1 = e.id
WHERE coach = 'Fernando Santos'

#7
SELECT player
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw'

#8
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2='GER') AND
teamid <> 'GER'

#9
SELECT teamname, COUNT(matchid)
FROM eteam
JOIN goal
ON eteam.id = goal.teamid
GROUP BY teamname

#10
SELECT stadium, COUNT(matchid)
FROM game
JOIN goal
ON game.id = goal.matchid
GROUP BY stadium

#11
SELECT matchid,mdate, COUNT(player)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate

#12
SELECT matchid, mdate, COUNT(teamid)
FROM game JOIN goal
ON game.id = goal.matchid
WHERE(team1 = 'GER' OR team2 = 'GER')
AND teamid = 'GER'
GROUP BY matchid, mdate

#13
SELECT mdate, team1, sum(score1), team2, sum(score2)
FROM
(SELECT mdate,
  team1,
  CASE 
  WHEN teamid=team1 THEN 1 ELSE 0 END score1,
  team2,
  CASE 
  WHEN teamid = team2 THEN 1 ELSE 0 END score2
  FROM game JOIN goal ON matchid = id) AS b
GROUP BY mdate, team1, team2 