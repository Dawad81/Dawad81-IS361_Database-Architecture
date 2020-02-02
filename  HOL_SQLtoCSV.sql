/*
  HOL_SQLtoCSV.sql
  
  Task:  export a .CSV file that contains total tuberculosis cases by country by year
  
*/


DROP TABLE IF EXISTS tb_cases;

CREATE TABLE tb_cases AS
 SELECT country, year, sex, child+adult+elderly AS cases
FROM tb;

SELECT country, year, SUM(cases) AS cases 
FROM tb_cases
GROUP BY country, year
HAVING cases IS NOT NULL
ORDER BY country, year;