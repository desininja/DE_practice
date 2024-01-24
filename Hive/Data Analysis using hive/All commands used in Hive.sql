/* This page contains all the commands used in this project*/
in hive


Add jar /usr/lib/hive-hcatalog/share/hcatalog/hive-hcatalog-core-2.3.6-amzn-2.jar;
 

For further analysis, you have to create a separate database:
create database amz_review;


Show databases;


use amz_review
-- CREATE EXTERNAL TABLE


create EXTERNAL table amz_review_dump(json_dump string) 
location 's3://hive-data-analysis-amz-review/'

select * from amz_review_dump limit 5;


--to add the data into different columns, run:

create EXTERNAL table amz_review_dump_col (
    reviewerid string,
    asin string,
    reviewername string,
    helpful array<int>,
    reviewtext string,
    overall double,
    summary string,
    unixreviewtime bigint
) row format serde 'org.apache.hive.hcatalog.data.JsonSerDe'
with serdeproperties ('paths'='')
location 's3://hive-data-analysis-amz-review/';

-- Verify data on the table.
Select * from amz_review_dump_col limit 5;


Select count(*) from amz_review_dump_col;  -- this  command took 55 seconds 

Select count(1) from amz_review_dump_col; -- this command took 40 seconds
-- here we have 16,89,188 records

Select count (distinct asin) am_products from amz_review_dump_col;
-- 63001 unique products


--How many reviews are posted on yearly basis?

Select rate_year , count(1) cnt from (
Select year(from_unixtime(unixreviewtime)) rate_year from amz_review_dump_col )T group by rate_year order by rate_year desc;


--Product with Maximum Review?
select amz_product, max(review_count) max_review_count from (
select asin amz_product, count(1) as review_count from amz_review_dump_col group by asin) T group by amz_product order by max_review_count DESC limit 1;

--Product with minimum review 
select amz_product, min(review_count) min_review_count from (
select asin amz_product, count(1) as review_count from amz_review_dump_col group by asin) T group by amz_product order by min_review_count  limit 1;


-- MAximum Help full review?


select product, sum(help_rate) as help_rt from(
select asin as product, case when helpful[0]=0 then 0.00 else round(helpful[0]/helpful[1],2) end as help_rate from amz_review_dump_col) temp
group by product order by help_rt desc limit 10;


-- minimum Help full review?


select product, sum(help_rate) as help_rt from(
select asin as product, case when helpful[0]=0 then 0.00 else round(helpful[0]/helpful[1],2) end as help_rate from amz_review_dump_col) temp
group by product order by help_rt asc limit 10;




 




create external table if not exists amz_review_yr_mnth_part (
    reviewerid string, 
    asin string, 
    reviewername string, 
    helpful array<int>, 
    reviewtext string,
    overall double, 
    summary string, 
    unixreviewtime bigint) partitioned by
(yr int, mnth int)
location 's3a://hive-data-analysis-amz-review/'


--inserting data into the table with partition:



insert overwrite table amz_review_yr_mnth_part partition(yr,mnth)

select reviewerid,
asin,
reviewername,
helpful,
reviewtext,
overall,
summary,
unixreviewtime,
year(from_unixtime(unixreviewtime)) as yr,
month(from_unixtime(unixreviewtime)) as mnth

from amz_review_dump_col




select  overall, count(*) as review_count from amz_review_yr_mnth_part
where  yr = 2004 and mnth = 1  group by overall   order by review_count desc;

--This query took around Time taken: 9.268 seconds



select  overall,  count(*) as review_count from amz_review_dump_col
where year(from_unixtime(unixreviewtime)) = 2004 and month(from_unixtime(unixreviewtime)) = 1
 group by overall order by review_count desc;
 
--This query took around Time taken: failed


Select asin as Product , RANK() OVER(order by overall)  from amz_review_yr_mnth_part 
Select asin as Product , DENSE_RANK() OVER(order by overall)  from amz_review_yr_mnth_part 