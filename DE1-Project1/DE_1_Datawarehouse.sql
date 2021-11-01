DROP PROCEDURE IF EXISTS Create__Football_Statistics;

DELIMITER //

CREATE PROCEDURE Create__Football_Statistics()
BEGIN

drop table if exists Overview_Football_Statistics;

create table Overview_Football_Statistics as
select l.leagueID,
 l.name,
 a.playerID,
 games.gameid,
 p.name as Player_Name,
 a.goals,
 a.shots,
 a.assists,
 a.keyPasses,
 a.player_position,
 t.teamID,
 t.season,
 t.goals as Team_goals,
 t.shots as Team_shots,
 t.result as Match_outcome,
 te.name as Team_Name
from leagues l
right join appearances a
using (leagueID)
left join player p
using (playerID)
left join teamstats t
using (gameID)
inner join games
using (gameID)
left join teams te
using (teamID);

END //
DELIMITER ;

