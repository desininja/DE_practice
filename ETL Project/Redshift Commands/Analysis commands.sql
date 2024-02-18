--Top 10 ATMs where most transactions are in the ’inactive’ state

with cte as (
    select atm_id, atm_status, count(atm_status) from fact_atm_trans where atm_status ='Inactive'
    group by 1,  2 order by 3 DESC limit 10
)

Select dim_atm.atm_number,
        dim_atm.manufacturer,
        dim_location.location,
        cte.count from cte
inner join dim_atm on cte.atm_id=dim_atm.atm_id
inner join dim_location on dim_atm.atm_location_id = dim_location.location_id
order by cte.count DESC ;

/*
Number of ATM failures corresponding to the different weather conditions recorded at the time of
the transactions
*/

with cte_total as (select weather_main, count(1) as total_transactions from fact_atm_trans group by weather_main),

cte_inactive as (select weather_main, count(1) as inactive_transaction_counts from fact_atm_trans where atm_status='Inactive' group by weather_main),
cte_join as (select t.weather_main, t.total_transactions,i.inactive_transaction_counts from cte_total t 
inner join cte_inactive i on t.weather_main = i.weather_main)

select *, (inactive_transaction_counts::decimal/total_transactions)*100 as inactive_transaction_percentage from cte_join;

-- Top 10 ATMs with the most number of transactions throughout the year

with cte as (
    select atm_id, atm_status, count(atm_status) from fact_atm_trans group by 1,2 order by 3 DESC limit 10
)

select dim_atm.atm_number,
        dim_atm.manufacturer,
        dim_location.location,
        cte.count from cte

inner join dim_atm on cte.atm_id = dim_atm.atm_id
inner join dim_location on dim_atm.atm_location_id = dim_location.location_id
order by cte.count DESC;


--Number of overall ATM transactions going inactive per month for each month


with cte as (
select date_id, count(atm_status) inactive_transaction_counts from fact_atm_trans where atm_status = 'Inactive' group by 1 order by 2 DESC
)

select d.month, 
        sum(cte.inactive_transaction_counts) as inactive_transaction_counts from cte 

inner join dim_date as d on cte.date_id = d.date_id
group by 1
order by 2 DESC;

-- Top 10 ATMs with the highest total amount withdrawn throughout the year

with cte as(
    select atm_id,
    sum(transaction_amount) as total_withdrawn_amount
    from fact_atm_trans where service ='Withdrawal' group by 1 order by 2 DESC limit 10
 )

select dim_atm.atm_number,
        dim_atm.manufacturer,
        dim_location.location,
        cte.total_withdrawn_amount from cte 
inner join dim_atm on cte.atm_id = dim_atm.atm_id 
inner join dim_location on dim_atm.atm_location_id = dim_location.location_id
order by cte.total_withdrawn_amount DESC ;


-- Number of failed ATM transactions across various card types
with cte as (
    select card_type_id, count(atm_status) as failed_atm_trans from fact_atm_trans where atm_status ='Inactive' group by 1 order by 2 DESC
)

select cd.card_type,
cte.failed_atm_trans from cte 
inner join dim_card_type as cd on cte.card_type_id = cd.card_type_id

order by 2 DESC;


/*
Top 10 records with the number of transactions ordered by the ATM_number, ATM_manufacturer, 
location, weekend_flag and then total_transaction_count, on weekdays and on weekends throughout 
the year
*/

with cte as (
    select date_id, atm_id, count(trans_id) as tt from fact_atm_trans group by 1,2 
)
select dim_atm.atm_number,
        dim_atm.manufacturer,
        dim_location.location,
        case when d.weekday IN ('Sunday','Saturday') then 1 else 0 end as weekend_flag,
        sum(cte.tt) as total_transaction_count from cte 
inner join dim_atm on cte.atm_id = dim_atm.atm_id
inner join dim_location on dim_atm.atm_location_id=dim_location.location_id
inner join dim_date as d on cte.date_id = d.date_id
group by 1,2,3,4
order by 1,2,3,4,5 DESC limit 10;


-- Most active day in each ATMs from location "Vejgaard"

with cte as (
    select date_id, atm_id, count(trans_id) as tt from fact_atm_trans group by 1,2
),
final as (
    select 
    dim_atm.atm_number, dim_atm.manufacturer, dim_location.location, dim_date.weekday,
    sum(cte.tt) as total_transaction_count,
    RANK() OVER (PARTITION BY atm_number, manufacturer ORDER BY sum(cte.tt) DESC) AS rnk
from 
    cte 
JOIN dim_atm on cte.atm_id = dim_atm.atm_id
JOIN dim_location on dim_atm.atm_location_id = dim_location.location_id 
JOIN dim_date on cte.date_id = dim_date.date_id
WHERE dim_location.location ='Vejgaard' GROUP BY 1,2,3,4
ORDER By rnk asc
)
select atm_number, manufacturer, location, weekday,total_transaction_count from final where rnk=1;






























































































