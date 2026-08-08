create database zomato;
use zomato;

-- Q.2 Build a Calendar Table using the Column Datekey
CREATE TABLE calendar AS
SELECT DISTINCT
    STR_TO_DATE(DateKey_Opening, '%d-%m-%Y') AS FullDate,
    
    YEAR(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS Year,
    
    MONTH(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS MonthNo,
    
    MONTHNAME(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS MonthFullName,
    
    CONCAT(
        YEAR(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')),
        '-',
        LEFT(MONTHNAME(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')),3)
    ) AS YearMonth,
    
    QUARTER(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS Quarter,
    
    DAYOFWEEK(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS WeekdayNo,
    
    DAYNAME(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS WeekdayName

FROM main1;

select* from calendar;

-- Q.3.Find the Numbers of Resturants based on City and Country.
SELECT c.Country, m.City, COUNT(*) AS Total
FROM main1 m
JOIN country_table c
ON m.CountryCode = c.`Country Code`
GROUP BY c.Country, m.City;

-- Q.4 Numbers of Resturants opening based on Year , Quarter , Month
SELECT
    YEAR(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS Year,
    QUARTER(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS Quarter,
    MONTH(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')) AS Month,
    COUNT(*) AS Number_of_Restaurants
FROM main1
GROUP BY 
    YEAR(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')),
    QUARTER(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(DateKey_Opening, '%d-%m-%Y'))
ORDER BY Year, Quarter, Month;

-- Q.5. Count of Resturants based on Average Ratings
select
Rating as IndividualRating,
count(*) as RestaurantCount
from main1
where
rating is not null
group by
Rating
order by
Rating asc;

 -- Q.6. Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
select
PriceBucket,
count(*) as Total_Restaurants
from (
select
case
when Average_Cost_for_two between 0 and 300 then '0-300'
when Average_Cost_for_two between 301 and 600 then '301-600'
when Average_Cost_for_two between 601 and 1000 then '601-1000'
when Average_Cost_for_two between 1001 and 430000 then '1001-430000'
else 'Other'
end as PriceBucket
from
main1
) as subquery
group by
PriceBucket;

-- Q.7.Percentage of Resturants based on Has_Table_booking
SELECT 
    Has_Table_Booking, 
    COUNT(*) AS TotalRestaurants,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main1)), 2) AS Percentage
FROM main1
GROUP BY Has_Table_Booking;

-- Q.8.Percentage of Resturants based on Has_Online_delivery
SELECT 
    Has_Online_Delivery, 
    COUNT(*) AS TotalRestaurants,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main1)), 2) AS Percentage
FROM main1
GROUP BY Has_Online_Delivery;

-- Q.9. Develop Charts based on Cusines, City, Ratings
select
cuisines,
count(*) as Total
from main1
group by cuisines
order by Total desc;

-- Cities
select
city,
count(*) as Total
from main1
group by city
order by Total desc;

-- Ratings Distribution
select
Rating,
count(*) as Total
from main1
group by Rating
order by Rating;







