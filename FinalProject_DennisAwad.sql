/* Final Project IS361 Dennis Awad
Below is the SQL Querry that will be run to Load the flights and planes Data into tables */
DROP TABLE IF EXISTS airlines;
DROP TABLE IF EXISTS airports;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS planes;
DROP TABLE IF EXISTS weather;

CREATE TABLE airlines (
  carrier varchar(2) PRIMARY KEY,
  name varchar(30) NOT NULL
  );
  
LOAD DATA LOCAL INFILE '/home/da12263683/flights/airlines.csv' 
INTO TABLE airlines 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE airports (
  faa char(3),
  name varchar(100),
  lat double precision,
  lon double precision,
  alt integer,
  tz integer,
  dst char(1)
  );
  
LOAD DATA LOCAL INFILE '/home/da12263683/flights/airports.csv' 
INTO TABLE airports
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE flights (
year integer,
month integer,
day integer,
dep_time integer,
dep_delay integer,
arr_time integer,
arr_delay integer,
carrier char(2),
tailnum char(6),
flight integer,
origin char(3),
dest char(3),
air_time integer,
distance integer,
hour integer,
minute integer
);

LOAD DATA LOCAL INFILE '/home/da12263683/flights/flights.csv' 
INTO TABLE flights
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year, month, day, @dep_time, @dep_delay, @arr_time, @arr_delay,
 @carrier, @tailnum, @flight, origin, dest, @air_time, @distance, @hour, @minute)
SET
dep_time = nullif(@dep_time,''),
dep_delay = nullif(@dep_delay,''),
arr_time = nullif(@arr_time,''),
arr_delay = nullif(@arr_delay,''),
carrier = nullif(@carrier,''),
tailnum = nullif(@tailnum,''),
flight = nullif(@flight,''),
air_time = nullif(@air_time,''),
distance = nullif(@distance,''),
hour = dep_time / 100,
minute = dep_time % 100
;

CREATE TABLE planes (
tailnum char(6),
year integer,
type varchar(50),
manufacturer varchar(50),
model varchar(50),
engines integer,
seats integer,
speed integer,
engine varchar(50)
);

LOAD DATA LOCAL INFILE '/home/da12263683/flights/planes.csv' 
INTO TABLE planes
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tailnum, @year, type, manufacturer, model, engines, seats, @speed, engine)
SET
year = nullif(@year,''),
speed = nullif(@speed,'')
;

CREATE TABLE weather (
origin char(3),
year integer,
month integer,
day integer,
hour integer,
temp double precision,
dewp double precision,
humid double precision,
wind_dir integer,
wind_speed double precision,
wind_gust double precision,
precip double precision,
pressure double precision,
visib double precision
);

LOAD DATA LOCAL INFILE '/home/da12263683/flights/weather.csv' 
INTO TABLE weather
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(origin, @year, @month, @day, @hour, @temp, @dewp, @humid, @wind_dir,
@wind_speed, @wind_gust, @precip, @pressure, @visib)
SET
year = nullif(@year,''),
month = nullif(@month,''),
day = nullif(@day,''),
hour = nullif(@hour,''),
temp = nullif(@temp,''),
dewp = nullif(@dewp,''),
humid = nullif(@humid,''),
wind_dir = FORMAT(@wind_dir, 0),
wind_speed = nullif(@wind_speed,''),
wind_gust = nullif(@wind_gust,''),
precip = nullif(@precip,''),
pressure = nullif(@pressure,''),
visib = FORMAT(@visib,0)
;

SET SQL_SAFE_UPDATES = 0;
UPDATE planes SET engine = SUBSTRING(engine, 1, CHAR_LENGTH(engine)-1);

/* 
Final project SQL Objectives
1. Create a query against the flights database (in MySQL) in which you will query the flights table and join it with the planes table. 

Ensure you have first summarized the flights data by origin, date (year/month/day), tailnum and manufacturer. 


In other words, for each of those fields the query will show the average delay (arr_delay) and count of flights.

Ensure your query retrieves the following fields:  origin, aircraft (tailnum), manufacturer, year/month/day, average delay and flight count.   

2. Export the query results into CSV

 */
 
/*Below is the querry that will join the flights and plane tables and return their 
origin, dates(concatinating the month, day, and year in to a single colume),
tailnum (in the colum labled Aircraft), manufacturer, 
and for each row that will add two additional colums for each row.
These two cloms will consisting of the average of arr_delay, in the Average delay colum. 
And, Count of those flights, in the Number of flights colum.
This will be exsported into a .CSV file named FinalProject_DennisAwad.csv
WARNING: the query will took a long time on the CUNY VM 
so i had to change the settings in MY SQL Workbench to alow for longer query proccessing times, you may have to do the same just FYI.*/

SELECT f.origin, CONCAT(f.year,'/', f.month, '/', f.day) AS 'Date',
IF(f.tailnum = '', 'Unkown Aircraft', f.tailnum) as 'Aircraft' ,
IF(p.manufacturer = '', 'Unknown Manufacturer', p.manufacturer) as 'Manufacturer',
AVG(IFNULL(arr_delay, 0)) AS 'Average Delay', COUNT(*) AS 'Number of Flights'
FROM flights f
INNER JOIN planes p 
ON f.tailnum = p.tailnum
GROUP BY f.origin, f.tailnum , p.manufacturer, f.year, f.month, f.day
ORDER BY f.origin, f.year, f.month, f.day;
