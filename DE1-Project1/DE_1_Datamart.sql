call Create__Football_Statistics();

select * from Overview_Football_Statistics;


DROP VIEW IF EXISTS league_Player_Outcome;

    
CREATE VIEW `league_Player_Outcome` AS
SELECT Player_Name,name,season, ((sum(goals))/2) as total_goals from Overview_Football_Statistics  
	group by season ,name,Player_Name
    order by total_goals desc;
   
    
    select * from league_Player_Outcome;

Drop procedure if exists topscorer;

delimiter ??

create procedure topscorer(
	in league varchar(50),
    in season_ int
)
begin

	select * from league_Player_Outcome where name = league and season = season_;

end ??
delimiter ;

call topscorer('La Liga',2014);





select
Team_name, season,
    count(case when Match_outcome = 'W' then 1 else null end) as wins,
    count(case when Match_outcome = 'L' then 1 else null end) as losses
    from Overview_Football_Statistics
	group by season, Team_name;

   


Select Team_name, season, ((select(count(Match_outcome)*3) FROM Overview_Football_Statistics where Match_outcome ='W') 
+ (select(count(Match_outcome)) FROM Overview_Football_Statistics where Match_outcome ='D'))
AS 'Points'
FROM Overview_Football_Statistics
GROUP BY Team_name, season;



DROP VIEW IF EXISTS league_Winners;


CREATE VIEW `league_Winners` AS
select season ,name, team_name ,Match_outcome, 
count(case when Match_outcome = 'W' then 3 
	when Match_outcome = 'D' then 1
    else 0
    end) as total_points
    from Overview_Football_Statistics
    group by name,season , team_name , Match_outcome
    order by total_points desc;
    
    
   Drop procedure if exists Specific_league_winner;

delimiter ??

create procedure Specific_league_winner(
	in league varchar(50),
    in season_ int
)
begin

	select  season ,name, team_name from league_Winners where name = league and season = season_ LIMIT 1;

end ??
delimiter ;

call Specific_league_winner('Ligue 1',2016); 
 call Specific_league_winner('Premier League',2016); 
