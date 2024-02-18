
--Copying data from S3 to dim_location Table in Redshift
COPY public.dim_location 
FROM 's3://hdfs-file-himanshu/trans/dim_location.csv' 
IAM_ROLE 'arn:aws:iam::416244001836:role/etl-project-redshift-role'
DELIMITER ',' IGNOREHEADER 1 REGION 'us-east-1';

--Copying data from S3 to dim_atm Table in Redshift
COPY public.dim_atm
FROM 's3://hdfs-file-himanshu/trans/dim_atm.csv' 
IAM_ROLE 'arn:aws:iam::416244001836:role/etl-project-redshift-role'
DELIMITER ',' IGNOREHEADER 1 REGION 'us-east-1';

--Copying data from S3 to dim_card_type Table in Redshift
COPY public.dim_card_type
FROM 's3://hdfs-file-himanshu/trans/dim_card_type.csv' 
IAM_ROLE 'arn:aws:iam::416244001836:role/etl-project-redshift-role'
DELIMITER ',' IGNOREHEADER 1 REGION 'us-east-1';

--Copying data from S3 to dim_date Table in Redshift
COPY public.dim_date
FROM 's3://hdfs-file-himanshu/trans/dim_date.csv' 
IAM_ROLE 'arn:aws:iam::416244001836:role/etl-project-redshift-role'
DELIMITER ',' IGNOREHEADER 1 REGION 'us-east-1';

--Copying data from S3 to fact_atm_trans Table in Redshift
COPY public.fact_atm_trans
FROM 's3://hdfs-file-himanshu/trans/transaction_fact_table.csv' 
IAM_ROLE 'arn:aws:iam::416244001836:role/etl-project-redshift-role'
DELIMITER ',' IGNOREHEADER 1 REGION 'us-east-1';