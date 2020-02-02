-- Hands on Lab Week 2 (handsOnLabWK2.sql)

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

-- Hands on lab Question 1 -Write a SELECT statement that returns all of the rows and columns in the planes table.
SELECT * FROM planes;

-- Hands on lab Question 2- Using the weather table, concatenate the year, month, and day columns to display a date in the form "3/17/2013".
SELECT CONCAT(month,'/',day,'/',year) AS 'Date' FROM weather;

-- Hands on lab Question 3-  Order by planes table by number of seats, in descending order.
SELECT * FROM planes ORDER BY seats DESC;

-- Hands on lab Question 4- List only those planes that have an engine that is 'Reciprocating'
SELECT * FROM planes WHERE engine = 'Reciprocating';

-- Hands on lab Question 5- List only the first 5 rows in the flights table
SELECT * FROM flights LIMIT 5;

-- Hands on lab Question 6-  What was the longest (non-blank) air time?
SELECT air_time FROM flights WHERE air_time IS NOT NULL ORDER BY air_time DESC LIMIT 1;

-- Hands on lab Question 7- What was the shortest (non-blank) air time for Delta?
SELECT air_time FROM flights WHERE carrier = 'DL' AND air_time IS NOT NULL ORDER BY air_time ASC LIMIT 1;

-- Hands on lab Question 8- Show all of the Alaska Airlines flights between June 1st, 2013 and June 3rd, 2013. Is the way the data is stored in the database helpful to you in making your query?
SELECT * FROM flights WHERE carrier = 'AS' AND month = 6 AND year = 2013 AND day between 1 AND 3;

-- Hands on lab Question 9- Show all of the airlines whose names contain 'America'
SELECT * FROM airlines WHERE name LIKE '%America%';

-- Hands on lab Question 10- How many flights went to Miami?
SELECT COUNT(*) AS 'Number of Flights From Miami' FROM flights WHERE dest = 'MIA';

-- Hands on lab Question 11- Were there more flights to Miami in January 2013 or July 2013? (Multiple queries are OK)
SELECT COUNT(*) AS 'January' FROM flights  WHERE dest = 'MIA' AND month = 1 And year = 2013;
SELECT COUNT(*) AS 'July' FROM flights WHERE dest = 'MIA' AND month = 7 And year = 2013;
-- Answere: There were 3 more flights in the month of January, than July, in the year 2013.

-- Hands on lab Question 12- What is the average altitude of airports?
SELECT AVG(alt) AS 'Average Altitude of Airports' FROM airports ;


