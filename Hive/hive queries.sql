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
    ratings int
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


from user_info 
insert into table male_users select id, age, gender,profession, reviews where gender ='M' 
insert into table female_users select id, age, gender, profession, reviews where gender='F';


_____________________________ ADVANCED HIVE QUERY ________________________________


ssh -i AWS_Project_RHEL.pem hadoop@ec2-52-91-0-107.compute-1.amazonaws.com



sudo -i 
 to download the datasets for practice:

wget ml-cloud-dataset.s3.amazonaws.com/employee
wget ml-cloud-dataset.s3.amazonaws.com/dept

New S3 buckets:
employee-bucket-practice
department-bucket-practice


to transfer data from local file in emr cluster to s3 bucket

aws s3 cp /root/employee/employee s3://employee-bucket-practice/tables/
aws s3 cp /root/department/department s3://department-bucket-practice/tables/


Creating tables in hive 

create table if not exists employee(
       emp_id int,
       emp_name string,
       designation string,
       salary int,
       mgr_id int,
       dept_id int,
       code string
 )
row format delimited fields terminated by ','
lines terminated by '\n' 
stored as textfile;


load data local inpath '/root/employee/employee' into table employee;
load data local inpath '/root/department/dept' into table department;


select 
     employee.emp_id, 
     employee.emp_name, 
     employee.designation,
     department.dep_id, 
     department.dep_city
from employee 
left join department on (employee.dept_id = department.dep_id);


/*To perform map join, you need to specify the hint to the query above, the syntax of which is as follows: */

select /* + MAPJOIN (employee) */
     employee.emp_id, 
     employee.emp_name, 
     employee.designation,
     department.dep_id, 
     department.dep_city
from employee 
left join department on (employee.dept_id = department.dep_id);


CREATING Static PArtitioned tables

Create table if not exists part_user_info(
    id int,
    age int,
    gender string,
    ratings int
)
partitioned by (profession string)
row format delimited fields terminated by '|'
lines terminated by '\n'
stored as textfile;


load data local inpath '/u.user' into table user_info;


CREATING Dynamic PArtitioned tables

Create table if not exists dyn_part_user_info(
    id int,
    age int,
    gender string,
    ratings int
)
partitioned by (profession string)
row format delimited fields terminated by '|'
lines terminated by '\n'
stored as textfile;


insert into table dyn_part_user_info partition (profession)
select id, age, gender, ratings, profession from user_info;


Bucketing


set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.dynamic.partition=true;
set hive.enforce.bucketing=true;


create table if not exists buck_user_info (
  id int,
  age int,
  profession string,
  ratings int )
partitioned by (gender string)
clustered by (age)
into 7 buckets 
row format delimited fields terminated by '|' 
lines terminated by "\n"
stored as textfile;

insert  into table buck_user_info partition(gender);
select id,age, profession, ratings, gender from user_info;



COMAPRISON:

select gender, sum(ratings) as total_ratings from user_info where profession= 'artist' and age < 35 group by gender ;


select gender, sum(ratings) as total_ratings from buck_user_info where profession= 'artist' and age < 35 group by gender ;