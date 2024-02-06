drop schema capstone;

Create schema capstone;

USE capstone;

CREATE TABLE users(
id varchar(50) PRIMARY KEY,
age TINYINT NOT NULL,
gender VARCHAR(1) NOT NULL,
internet_usage VARCHAR(50),
income_bucket  VARCHAR(3),
user_agent_string VARCHAR(300),
device_type VARCHAR(50),
websites VARCHAR(300),
movies VARCHAR(300),
music VARCHAR(300),
programs VARCHAR(300),
books VARCHAR(300),
negatives VARCHAR(300),
positives VARCHAR(300)
);


CREATE TABLE ads(
text	           VARCHAR(255) NOT NULL,
category	       VARCHAR(255) NOT NULL,
keywords	       VARCHAR(255) NOT NULL,
campaign_id	     VARCHAR(50) PRIMARY KEY,
status	         VARCHAR(10) NOT NULL,
target_gender	   VARCHAR(3) NOT NULL,
target_age_start  TINYINT NOT NULL,
target_age_end    TINYINT NOT NULL,
target_city	      VARCHAR(20) NOT NULL,
target_state	     VARCHAR(20) NOT NULL,
target_country	     VARCHAR(20) NOT NULL,
target_income_bucket    	VARCHAR(5) NOT NULL,
target_device	        VARCHAR(20) NOT NULL,
cpc	                  DOUBLE NOT NULL,
cpa	                  DOUBLE NOT NULL,
cpm	                  DOUBLE NOT NULL,
budget	               DOUBLE NOT NULL,
current_slot_budget	    DOUBLE NOT NULL,
date_range_start	     date NOT NULL,
date_range_end	       date NOT NULL,
time_range_start	     time NOT NULL,
time_range_end	       time NOT NULL
);



CREATE TABLE served_ads(

request_id	     VARCHAR(50) PRIMARY KEY,
campaign_id	      VARCHAR(50) NOT NULL,
user_id	            VARCHAR(50) NOT NULL,
auction_cpm	    DOUBLE NOT NULL,
auction_cpc	    DOUBLE NOT NULL,
auction_cpa	    DOUBLE NOT NULL,
target_age_range	   VARCHAR(5) NOT NULL,
target_location	      VARCHAR(50) NOT NULL,
target_gender	        VARCHAR(3) NOT NULL	,
target_income_bucket	   VARCHAR(5) NOT NULL,
target_device_type	     VARCHAR(20) NOT NULL,
campaign_start_ime	     DATETIME NOT NULL,
campaign_end_time	      DATETIME NOT NULL	,
userFeedbacktimestamp	      TIMESTAMP NOT NULL
);


LOAD data local infile '/Users/himanshu/Desktop/CAPSTONE Upgrad DE/Advertisement/venv/Data/users_500k.csv' 
INTO TABLE users fields terminated by '|' ignore 1 rows;



