use birdstrikes;
-- show the table present 
show tables;
-- shows the column in the database
describe birdstrikes;
-- shows all the data in the table 
select * from birdstrikes;
-- to show certain specfic items from the table 
select cost from birdstrikes;
select airline,cost from birdstrikes;

-- copy table
create table birdstrikes2 like birdstrikes;
show tables;
drop table if exists birdstrikes2;

create table employee
(id integer not null, employee_name varchar(255) not null, primary key (id));
describe employee;
select * from employee;
INSERT INTO employee (id,employee_name) VALUES(1,'Student1');
INSERT INTO employee (id,employee_name) VALUES(2,'Student2');
INSERT INTO employee (id,employee_name) VALUES(3,'Student3');
-- following commad gave error becux 3 already existed
INSERT INTO employee (id,employee_name) VALUES(3,'Student4');

UPDATE employee SET employee_name='Arnold Schwarzenegger' WHERE id = '1';
UPDATE employee SET employee_name='The Other Arnold' WHERE id = '2';
select * from employee;

-- empty table 
truncate employee;
select *from employee;

 -- user & privileges
 
 -- create user
 create user 'hassanabbas'@'%' identified by 'hassanabbas';

GRANT ALL ON birdstrikes.employee TO 'hassanabbas'@'%';
GRANT SELECT (state) ON birdstrikes.birdstrikes TO 'hassanabbas'@'%';

-- select 
-- create new columns 
SELECT *, speed/2 FROM birdstrikes;
select *,speed/2 as halfspeed from birdstrikes;
-- top ten rows
SELECT * FROM birdstrikes LIMIT 10;

SELECT * FROM birdstrikes LIMIT 10,1;
SELECT state FROM birdstrikes LIMIT 144,1;

-- Order by a field
SELECT state, cost FROM birdstrikes ORDER BY cost;
SELECT state, cost FROM birdstrikes ORDER BY state, cost ASC;
SELECT state, cost FROM birdstrikes ORDER BY cost DESC;
-- What is flight_date of the latest birstrike in this database?
select flight_date from birdstrikes order by flight_date DESC;

 -- Unique values
SELECT DISTINCT damage FROM birdstrikes;
select distinct airline,damage from birdstrikes;

select distinct cost from birdstrikes order by cost desc limit 49,1;

-- Filtering

select * from birdstrikes where state = 'Alabama';

-- like 
SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'A%';





