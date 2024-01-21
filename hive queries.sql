create database if not exists demo ;


--Adding a comment in database
create database if not exists demo2 comment "This is a demo database";

describe database extended demo2 ;

--To get header in output.

set hive.cli.print.header=true ;

show databases;

use demo;


Create table if not exists user_info(
    id int,
    age int,
    gender string,
    profession string,
    reviews int
)
row format delimited fields terminated by '|'
lines terminated by '\n'
stored as textfile;

describe user_info;
//// output
col_name        data_type        comment
id                int
age               int
gender            string
profession        string
reviews           int
Time taken: 1.020 seconds, Fetched: 5 row(s)  /////

--Loading data from local path into the table
load data local inpath '/root/movie_ratings/u.user' into table user_info;

select * from user_info limit 5;

--- OUTPUT ---
user_info.id	user_info.tage	user_info.gender	user_info.profession	user_info.reviews
1	                  24	        M	            technician	                85711
2	                  53	        F	            other	                    94043
3	                  23	        M	            writer	                    32067
4	                  24	        M	            technician	                43537
5	                  33	        F	            other	                    15213





create external table if not exists user_info_external ( 
id int,
age int, 
gender string,
profession string,
reviews int ) 
row format delimited fields terminated by  "|" 
lines terminated by "\n" stored as textfile;



load data local inpath '/root/movie_ratings/u.user' into table user_info_external;




--create two tables for male and female users and insert the data from users table in Hive.

create table if not exists male_users(
    id int,
    age int,
    gender string,
    profession string,
    reviews int
) row format delimited fields terminated by "|" 
lines terminated by "\n" stored as textfile;

create table if not exists female_users(
    id int,
    age int,
    gender string,
    profession string,
    reviews int
) row format delimited fields terminated by "|" 
lines terminated by "\n" stored as textfile;


insert into table male_users select id, age, gender,profession, reviews from user_info where gender ='M' ;

insert into table female_users select id, age, gender,profession, reviews from user_info where gender ='F' ;


from user_info insert into table male_users select id, age, gender,profession, reviews where gender ='M' insert into table female_users select id, age, gender, profession, reviews where gender='F';