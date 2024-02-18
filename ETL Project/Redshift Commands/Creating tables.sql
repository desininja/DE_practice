CREATE TABLE IF NOT EXISTS dim_location (
    location VARCHAR(50),
    street_name VARCHAR(255),
    street_number INT,
    zipcode INT,
    lat DECIMAL(10,3),
    lon DECIMAL(10,3),
    location_id INT,
    PRIMARY KEY (location_id)
);

Create table if not exists dim_atm (
	atm_id int,
    atm_number varchar(20),
    manufacturer varchar(50),
    atm_location_id INT,
    
    primary key (atm_id),
    Foreign KEY (atm_location_id) REFERENCES dim_location(location_id));


CREATE TABLE IF NOT EXISTS dim_date(
	date_id INT,
    full_date_time timestamp,
    year int,
    month varchar(20),
    day int,
    hour int,
    weekday varchar(20),
    Primary key (date_id)
);


Create table if not exists dim_card_type(
	card_type_id int,
    card_type varchar(30),
    primary key (card_type_id)
);


create table if not exists fact_atm_trans(
	trans_id BIGINT,
    atm_id INT,
    date_id int,
    location_id int,
    card_type_id int,
    atm_status varchar(20),
    currency varchar(10),
    service varchar(20),
    transaction_amount int,
    message_code varchar(255),
    message_text varchar(255),
    rain_3h decimal(10,3),
    clouds_all INT,
    weather_id INT,
    weather_city_id varchar(20),
    weather_city_name varchar(255),
    temp decimal(10,3),
    pressure int,
    humidity int,
    wind_speed int,
    wind_deg varchar(20),
    weather_lat decimal(10,3),
    weather_lon decimal(10,3),
    weather_main varchar(50),
    weather_description varchar(50),
    
    primary key (trans_id),
    foreign key (atm_id) references dim_atm(atm_id),
    foreign key (location_id) references dim_location(location_id),
    foreign key (date_id) references dim_date(date_id),
    foreign key (card_type_id) references dim_card_type(card_type_id)
    
    
    )
