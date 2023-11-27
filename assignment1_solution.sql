-- Select dates and commodities for cities Quetta, Karachi, and Peshawar where price was less than or equal 50 PKR
select date, cmname, mktname, price
from wfp_food_prices_pakistan 
where mktname In ("Quetta", "Karachi", "Peshawar") AND price>=50; 

-- Query to check number of observations against each market/city in PK 
select mktname, count(*) as number_of_observations
from wfp_food_prices_pakistan
group by mktname; 

-- Show number of distinct cities 

select count(distinct mktname) as distinct_cities_count 
from wfp_food_prices_pakistan; 

-- List down/show the names of cities in the table

select distinct(mktname) as distinct_cities
from wfp_food_prices_pakistan; 


-- List down/show the names of commodities in the table
select distinct cmname  as distinct_commodoties_name 
from wfp_food_prices_pakistan;


-- List Average Prices for Wheat flour - Retail in EACH city separately over the entire period.

select cmname ,avg(price) as average_price
from wfp_food_prices_pakistan
where cmname="Wheat flour - Retail" 
group by cmname; 


-- Calculate summary stats (avg price, max price) for each city separately for all cities except Karachi and sort alphabetically the
-- city names, commodity names where commodity is Wheat (does not matter which one) with separate rows for each commodity

select cmname ,mktname, avg(price) as average_price, max(price) as maximum_price
from wfp_food_prices_pakistan
group by mktname, cmname 
HAVING mktname != 'Karachi'
order by mktname, cmname ; 


-- Calculate Avg_prices for each city for Wheat Retail and show only those avg_prices which are less than 30

select mktname ,avg(price) as average_price 
from wfp_food_prices_pakistan
 where cmname="Wheat flour - Retail" 
group by mktname
Having average_price<30;


-- Prepare a table where you categorize prices based on a logic (price < 30 is LOW, price > 250 is HIGH, in between are FAIR)

CREATE TABLE categorized_prices AS
SELECT price,
  CASE 
    WHEN price < 30 THEN 'Low' 
    WHEN price > 250 THEN 'High' 
    ELSE 'Fair' 
  END AS status_of_prices
FROM wfp_food_prices_pakistan;


-- Create a query showing date, cmname, category, city, price, city_category where Logic for city category is: Karachi and Lahore 
-- are Big City;, Multan and Peshawar are Medium-sized city;, Quetta is Small City;

select date,cmname,category,mktname, price, 
case 
	when mktname IN ("Karachi","Lahore") then "Big City" 
    when mktname IN ("Multan","Peshawar") then "Medium-sized City"
    when mktname = "Quetta" then "Small City" 
END AS categorized_city 
from wfp_food_prices_pakistan; 

-- Create a query to show date, cmname, city, price. Create new column
-- price_fairness through CASE showing price is fair if less than 100,
-- unfair if more than or equal to 100, if > 300 then Speculative;


select date,cmname,mktname,price,
case
	when price<100 then "fair"
    when price>=100 then "unfair"
    when price>300 then "Speculative"
end as price_fairness
from wfp_food_prices_pakistan;


-- Join the food prices and commodities table with a left join.
SELECT *
FROM wfp_food_prices_pakistan
LEFT JOIN commodity ON wfp_food_prices_pakistan.cmname = commodity.cmname;


-- Join the food prices and commodities table with an inner join

SELECT *
FROM wfp_food_prices_pakistan
INNER JOIN commodity ON wfp_food_prices_pakistan.cmname = commodity.cmname;













