/* Project 3 Dennis Awad*/


-- This pulls the data from the tb.csv file
DROP TABLE IF EXISTS tb;

CREATE TABLE tb 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  sex varchar(6) NOT NULL,
  child int NULL,
  adult int NULL,
  elderly int NULL
);

LOAD DATA LOCAL INFILE '/home/da12263683/tb.csv' 
INTO TABLE tb
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(country, year, sex, @child, @adult, @elderly)
SET
child = nullif(@child,-1),
adult = nullif(@adult,-1),
elderly = nullif(@elderly,-1)
;
-- this displays the TB table pulled from the TB.csv file.
SELECT * FROM tb;



-- This creates the tb_cases table.
DROP TABLE IF EXISTS tb_cases;

CREATE TABLE tb_cases AS
 SELECT country, year, sex, child+adult+elderly AS cases
FROM tb;

-- this creates the sum_tb_cases table that sum the cases across gender and age groups per country per year.
DROP TABLE IF EXISTS sum_tb_cases;
CREATE TABLE sum_tb_cases AS
SELECT country, year, SUM(cases) AS cases
FROM tb_cases
GROUP BY country, year
ORDER BY country, year;


-- this replces nulls in the sum_tb_cases table with 0 so they can be used aritmaticly.
UPDATE sum_tb_cases
SET sum_tb_cases.cases = 0
WHERE sum_tb_cases.cases IS NULL;

-- this displays my sum_tb_cases table
SELECT * FROM sum_tb_cases;


-- this counts to see how many total rows I have in sum_tb_cases table which is 1900.
SELECT COUNT(*) FROM sum_tb_cases;



-- This creates the population table 
DROP TABLE IF EXISTS population;

CREATE TABLE population 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  population int not NULL
);

LOAD DATA LOCAL INFILE '/home/da12263683/population.csv' 
INTO TABLE population
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(country, year, population)
;
-- this deletes the first row from the populations.csv that are the colum headers.
DELETE FROM population WHERE population = 0 AND population.year = 0;

-- this displases the population table
SELECT * FROM population;

-- This counts the rows after the header removal giving me 1900 rows to match the sum_tb_cases table 1900
SELECT COUNT(*) FROM population;



-- this combines the sum_tb_case table with the population from the population table.
SELECT stc.country, stc.year, stc.cases, p.population
FROM sum_tb_cases stc
LEFT JOIN population p
ON stc.country = p.country
WHERE stc.country = p.country AND stc.year = p.year
ORDER BY stc.country, stc.year;



-- this select combines the sum_tb_cases table and population table, to arithmaticly find the TB rate per year, per contry.
SELECT stc.country, stc.year, (stc.cases/ p.population) AS rate
FROM sum_tb_cases stc
LEFT JOIN population p
ON stc.country = p.country
WHERE stc.country = p.country AND stc.year = p.year
ORDER BY stc.year, stc.country;