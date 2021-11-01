# Project - European Soccer League dataset

It contains all my workfiles used for the Data Engineering 1 Project. The relational dataset which was used to create this schema was Top 5 European League Dataset, which is available on Kaggle. The following are the csv & script files which were used in the creation of operational, analytical & data marts 
- DE_1_Datamart.sql
- DE_1_Datawarehouse.sql
- DE_1_Project_Script.sql


## Task interpretation :
As a member of sports magazine’s editing team, I am supposed to perform data analysis and share insights about the European football league for the upcoming blog post. The topics I will be covering will include the following:

-	Emergence of new talent among the lead goal scorers (over the last 7-year period)
-	Top teams in each league during the 7-year period. 

## Operational layer
My operational layer consists of 7 tables stored in csv -  ranging from team statistics , to game appearance, that happened in years: 2014-2020 The below EER diagrams represent this schema.


![EER_diagram.png](https://github.com/Khawaja9622/DE1/blob/main/DE1-Project1/EER_diagram.png)


In the schema above main analysis are done based on the team statistics, Player appearances & Individual games played by each team.
1-	Team Stats: The overall team performance based on qualitative and quantitative variables 
2-	Players: Contains the list of all players with playing in European Leagues
3-	Shots: Qualitative results of type of shots committed and the conversion of these shots 
4-	Appearance: This table reflects performance of each player in their respective games
5-	Leagues: List all the names of European leagues 
6-	Team: List of all the teams in playing in European leagues 
7-	Games: Contains variables’ that review the statistics of each individual game 


## Analytics plan

My analytics plan is the following:
1.	Loading up the acquired data
2.	Create ETL pipeline to create a denormalised data warehouse
3.	Create ETL pipeline to create data marts for the three analytical teams
This is illustrated in the below figure:

![ETL .png](https://github.com/Khawaja9622/DE1/blob/main/DE1-Project1/ETL%20.png)


## Analytical layer

In the analytical layer one data warehouse is created with relevant columns that are required to create the views in the data mart. While creating the layering multiple joins (inner joins, right join & left joins) were used. The purpose of this data warehouse was to display both quantitative and qualitative data with respect to players individual performance and overall, the team performance in that given game. Lastly, the table of shots was dropped to avoid unnecessary data complexity.

![Table.png](https://github.com/Khawaja9622/DE1/blob/main/DE1-Project1/Table.png)

## Data Mart

The following are the two data marts which were created:

## 1-	The League-Player Outcome:
In this view the user can extract the lead goal scoring player based on their respective league and the season year. To filter out the result a procedure was applied so that the user can get the outcome based on each league and the year. Moreover, we used aggregation of total goals by player and divided by two since the observation was from both home and away perspective.

## 2-	League Winner View:
In this data mart the observation is being filtered to help user to find the league winner in each respective year. Moreover, we later created a procedure for the user where once they enter the season and league, they will be able to extract the league winner. Moreover, while creating the view we assigned label win with 3 points, draws as 1 point & losses as 0 to calculate the aggregated total of each team.



