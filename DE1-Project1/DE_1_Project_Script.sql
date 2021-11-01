create schema eurodata ;
use eurodata;

drop table if exists player;
CREATE TABLE player
(playerID INTEGER NOT NULL,
name char (200),
PRIMARY KEY(playerID));

SHOW VARIABLES LIKE "secure_file_priv";
Set global local_infile ='on';
show variables like "local_infile";



LOAD DATA INFILE '/Users/khawajahassan/players.csv' 
INTO TABLE player  CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(playerID, name);


drop table if exists games;
create table games
(gameID integer not null ,
leagueID integer ,
season year, 
home_teamID integer,
away_teamId integer, 
home_goals integer,
away_goals integer,
h_probability double,
d_probability  double,
a_probability  double,
primary key (gameID));



LOAD DATA INFILE '/Users/khawajahassan/games.csv' 
INTO TABLE games CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(gameID, leagueId,season,home_teamID,away_teamId,home_goals,away_goals,h_probability,d_probability,a_probability);


drop table if exists shots;
create table shots
(gameID integer not null,
playerID integer ,
situation varchar(300),
shottype varchar (300),
shotresult varchar(300),
foreign key (gameID) references games(gameId),
foreign key (playerID) references player(playerID));




LOAD DATA INFILE '/Users/khawajahassan/shots.csv' 
INTO TABLE shots  CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(gameID, playerID,situation,shottype,shotresult);


drop table if exists leagues;
create table leagues
(leagueID integer not null ,
name varchar (300), 
notation varchar (300),
primary key (leagueID));

LOAD DATA INFILE '/Users/khawajahassan/leagues.csv' 
INTO TABLE  leagues CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(leagueID , name ,notation );


drop table if exists teams;
create table teams
(teamID integer not null ,
name varchar (300),
primary key (teamID));

LOAD DATA INFILE '/Users/khawajahassan/teams.csv' 
INTO TABLE  teams CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(teamID, name);


Drop table if exists appearances;
create table appearances
(gameID integer,
playerID integer,
goals integer,
ownGoals integer,
shots integer,
assists integer,
keyPasses integer,
player_position varchar(30),
yellowCard integer,
redCard integer,
leagueID integer,
foreign key (gameID) references games(gameId),
foreign key (playerID) references player(playerID),
foreign key (leagueID) references leagues(leagueID));

LOAD DATA INFILE '/Users/khawajahassan/appearances.csv' 
INTO TABLE appearances CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(gameID, playerId, goals, owngoals, shots, assists, keyPasses, player_position, yellowCard, redCard,leagueID);



drop table if exists teamstats;
create table teamstats
(gameID integer	not null,
teamID  integer not null,
season integer,
goals integer,
shots integer,
shotsontarget integer, 
fouls integer,
corners integer, 
yellowCards integer, 
redCards integer,
result varchar (150),
foreign key (gameID) references games(gameId),
foreign key (teamID) references teams(teamID));

LOAD DATA INFILE '/Users/khawajahassan/teamstats.csv' 
INTO TABLE teamstats CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
optionally enclosed by '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(gameID,teamID,	season,	goals,shots,shotsOnTarget,fouls,corners,@v_yellowCards,redCards,result)
set
yellowCards = nullif(@v_yellowCards,'');



