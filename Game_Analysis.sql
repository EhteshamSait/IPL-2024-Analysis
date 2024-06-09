-- Create a new database with a new table to hold information about each game

create database cricket_info;

use cricket_info;

create table game_info(
	game_id int primary key auto_increment,
	team1 varchar(4),
	team2 varchar(4),
	venue varchar(20),
	toss varchar(4),
	decision varchar(4),
	winner varchar(4),
	result varchar(15)
);

-- Insert values into the table with each game result [just a few as an example]

insert into game_info(team1, team2, venue, toss, decision, winner, result) values
	('KKR', 'SRH', 'Ahmedabad', 'SRH', 'Bat', 'KKR', 'by 8 wickets'),
	('RR', 'RCB', 'Ahmedabad', 'RR', 'Bowl', 'RR', 'by 4 wickets'),
	('SRH', 'RR', 'Chennai', 'RR', 'Bowl', 'SRH', 'by 36 runs'),
	('KKR', 'SRH', 'Chennai', 'SRH', 'Bat', 'KKR', 'by 8 wickets');


-- Question 1: How many teams were in the tournament? Which ones were they?

select count(distinct team1) from game_info;
select distinct team1 from game_info;

-- Question 2: How many games did each team win?

select winner, count(*) as wins from game_info group by winner order by wins desc;

-- Question 3: Was there a bias in the toss decision? Print it as a ratio.

select decision, count(*) as toss_count from game_info group by decision;

select (count(case when decision = 'bowl' then 1 end) / count(case when decision = 'bat' then 1 end)) as ratio_bowl_to_bat from game_info;

-- Question 4: What impact did the toss have on the result?

select count(*) from game_info where toss = winner;
select count(*) from game_info where decision = 'bat' and margin like '%run%';
select count(*) from game_info where decision = 'bowl' and margin like '%wicket%';

-- Question 5: How many games were won by the chasing team? How many were won by the defending team? What is the ratio of successful chases to defences?

select count(*) from game_info where margin like '%wicket%';
select count(*) from game_info where margin like '%run%';

select (count(case when margin like '%wicket%' then 1 end) / count(case when margin like '%run%' then 1 end)) as ratio_chase_to_defend from game_info;

-- Question 6: Did the venue play a role in the result?

select distinct venue from game_info;

select venue, count(*) as successful_chases from game_info where margin like '%wicket%' group by venue order by successful_chases desc;

select count(*) from game_info where venue = 'Ahmedabad' and margin like '%run%';

select venue, count(*) as successful_defences from game_info where margin like '%run%' group by venue order by successful_defences desc;

select count(*) from game_info where venue = 'Delhi' and margin like '%wicket%';
