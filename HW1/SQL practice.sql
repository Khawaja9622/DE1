create schema practicedb;
use practicedb;

create table practice_birdstrike
(id integer not null , aircraft varchar(40) , flight_date date not null , damage varchar(30) ,airline varchar(45) not null , state varchar(30) , phase_of_flight varchar (40) , reported_date date , bird_size varchar(30), cost integer not null , feet_above_ground integer,speed INTEGER, primary key (id));

set global local_infile = 'on';
SHOW VARIABLES LIKE "local_infile";
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE '/tmp/birdstrikes_small.csv' 
INTO TABLE practice_birdstrike 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, aircraft, flight_date, damage, airline, state, phase_of_flight, @v_reported_date, bird_size, cost, @v_speed)
SET
reported_date = nullif(@v_reported_date, ''),
speed = nullif(@v_speed, '');

SHOW TABLES;
describe practice_birdstrike;

select * from practice_birdstrike;
-------- session 2
create table employee
(id integer not null , employee_name varchar(50) not null, primary key (id));

Insert into employee (id,employee_name) VALUES (1,'student1');
Insert into employee (id,employee_name) VALUES (2,'student2');
Insert into employee (id,employee_name) VALUES (3,'student3');

insert into employee (id,employee_name) values (4,'Gandu');

-- update
update employee set employee_name='aftab Abbu' where id = '2';
--
select * from employee;
--- new column 
select *, speed/2 from practice_birdstrike;
select *, speed/2 as halfspeed from practice_birdstrike;
-- alter 
alter table practice_birdstrike add halfspeed integer; 
alter table practice_birdstrike drop column halfspeed;

select * from practice_birdstrike;

-- using limit 
select * from practice_birdstrike limit 10;

select * from practice_birdstrike limit 10,1;

select * from practice_birdstrike limit 143,1;

-- order data 

select state , cost from practice_birdstrike;
select state , cost from practice_birdstrike order by cost ;
select state , cost from practice_birdstrike order by state;
select state , cost from practice_birdstrike order by state, cost desc;

select airline , reported_date from practice_birdstrike order by reported_date desc;

-- distant value 
select distinct damage from practice_birdstrike;

select distinct airline from practice_birdstrike;
select distinct airline, damage from practice_birdstrike;

select distinct cost from practice_birdstrike limit 49,1;

-- limiting 
select * from practice_birdstrike where state='New York';

select * from practice_birdstrike where state !='New York';

Select distinct state from practice_birdstrike where state like 'A%';

Select distinct state from practice_birdstrike where state like '%A%';

Select * from practice_birdstrike where state like '%A';

select distinct state from practice_birdstrike where state like 'Ala%';

select distinct state from practice_birdstrike where state like 'north_a%';

select distinct airline from practice_birdstrike where airline like 'Ca%';

select distinct airline from practice_birdstrike where airline not like 'a%';

-- logical AND OR 
select * from practice_birdstrike where state='New York' and bird_size= 'small';

select * from practice_birdstrike where state= 'New York' or bird_size= 'Medium';

-- also give result of the feilds which are empty
select distinct state from practice_birdstrike where state is not null;

select id, state from practice_birdstrike where state is not null and state!='';

-- null bhi remove karega and empty feilds bhi 
select distinct state from practice_birdstrike where state is not null and state!='';
-- IN
select state from practice_birdstrike where state in ('New York', 'Ohio', 'Florida');

select distinct state from practice_birdstrike where state in ('New York', 'Ohio', 'Florida');

-- length 

select state from practice_birdstrike where length(state)=5 ;

select distinct state from practice_birdstrike where length(state)=5 ;

--
select * from practice_birdstrike where airline= 'Military';

select * from practice_birdstrike where cost >= 15000;

-- 
SELECT ROUND(SQRT(speed/2) * 10) AS synthetic_speed FROM practice_birdstrike;

select * from practice_birdstrike where cost between 20 and 40;

-- exercise 
select* from practice_birdstrike where state='' and bird_size=''limit 1,1;
select* from practice_birdstrike where state='' and bird_size='';
select* from practice_birdstrike where state!='' and bird_size!='';

select* from practice_birdstrike where state is not null and state!='';
select * from practice_birdstrike where bird_size is not null and bird_size!='';

select* from practice_birdstrike where (state is not null and state!='') AND (bird_size is not null and bird_size!='') limit 1,1;



-- date 
select * from practice_birdstrike where flight_date='2000-01-01';

select * from practice_birdstrike where flight_date >='2000-01-01' and flight_date 	<='2002-01-01'; 
-- other way for above statement 
select * from practice_birdstrike where flight_date between '2000-01-01' and flight_date <='2002-01-01';

select feet_above_ground from practice_birdstrike;

SELECT WEEKOFYEAR(CURDATE());

alter table practice_birdstrike add weeknumber integer ;

-- ex 6 
select state, flight_date from practice_birdstrike where (state='colorado') and (weekofyear(flight_date)=52);
select current_date();
select datediff(current_date(),(select flight_date from practice_birdstrike where state='colorado' and weekofyear(flight_date)=52));
-- sir way of ex 6 
select datediff (flight_date,now()) from practice_birdstrike where weekofyear(flight_date)=52 and state='Colorado';


alter table practice_birdstrike add weeknumber integer;
alter table practice_birdstrike drop column weeknumber;

select *, weekofyear(flight_date) from practice_birdstrike;
select *, weekofyear(flight_date) as flight_week from practice_birdstrike;


select  aircraft, airline ,speed,
    if (speed is null or speed<100,'LOW SPEED','HIGH SPEED') as speed_category
    from practice_birdstrike
    order by speed_category;
    
    SELECT COUNT(*) FROM practice_birdstrike;
    -- does not count the null values 
    sELECT COUNT(reported_date) FROM practice_birdstrike;
    -- gives number of states
    select count( distinct state) from practice_birdstrike;
    -- provides the names
    select distinct state from practice_birdstrike;
    
    select count(distinct aircraft) from practice_birdstrike;

select sum(cost) from practice_birdstrike;

select (avg(speed)*1.852) as avg_kmh from practice_birdstrike;
-- latest reported date 
select max(reported_date) from practice_birdstrike;
-- earliest 
select min(reported_date) from practice_birdstrike;

select datediff(max(reported_date),min(reported_date)) from practice_birdstrike;

select min(speed) from practice_birdstrike where aircraft like 'H%';

select min(speed), aircraft from practice_birdstrike group by aircraft ;
select min(speed), aircraft from practice_birdstrike where aircraft like 'H%'group by aircraft ;

select state ,aircraft, sum(cost) as sum from practice_birdstrike where state !='' group by aircraft, state order by  sum desc;

select phase_of_flight, count(*) as count from practice_birdstrike group by phase_of_flight order by count asc;
select phase_of_flight, count(*) as count from practice_birdstrike group by phase_of_flight order by count asc limit 1;
-- same 
select phase_of_flight, count(phase_of_flight) as count from practice_birdstrike group by phase_of_flight order by count asc limit 1;

select phase_of_flight, round(avg(cost)) as sum from practice_birdstrike group by phase_of_flight order by sum desc limit 1;

SELECT state,AVG(speed) AS avg_speed  from practice_birdstrike  GROUP BY state HAVING ROUND(avg_speed) = 50;

select state,avg(speed) as avg_speed from practice_birdstrike group by state having length(state)<5 and state !='' order by avg_speed desc limit 1;





