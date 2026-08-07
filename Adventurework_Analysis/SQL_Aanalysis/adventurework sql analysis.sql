use adventureworks;

-- SALES PERFORMANCE ANALYSIS----

#1.KPI: Total Sales Revenue

SELECT CONCAT(ROUND(SUM(SalesAmount) / 1000000, 2),' M') AS TotalSales
FROM Sales;

#1a KPI: Total Sales revenue by Filters
DELIMITER //

CREATE PROCEDURE Total_Revenue(
    IN input_year INT,
    IN input_country VARCHAR(50),
    IN input_product_cat VARCHAR(50)
)
BEGIN

    SELECT 
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalRevenue
    FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat);
    

END //

DELIMITER ;


CALL Total_Revenue(2013,'United States','bikes');


#2.KPI:  Total Profit Revenue

SELECT CONCAT(ROUND(SUM(Profit) / 1000000, 2),' M') AS TotalProfit
FROM Sales;

#2a KPI: Total Profit revenue by Filters
DELIMITER //

CREATE PROCEDURE Total_Profit(
    IN input_year INT,
    IN input_country VARCHAR(50),
    IN input_product_cat VARCHAR(50)
)
BEGIN

    SELECT 
        CONCAT(ROUND(SUM(s.Profit) / 1000000, 2),' M') AS TotalProfit
    FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat);

END //

DELIMITER ;


CALL Total_Profit(2012, 'United States','bikes');


#3. KPI: Profit Margin%
SELECT 
CONCAT(
    ROUND((SUM(Profit) / SUM(SalesAmount)) * 100, 2),
    '%'
) AS ProfitMargin
FROM Sales;

#3a KPI: Total Profit revenue by Filters
DELIMITER //

CREATE PROCEDURE Profit_Margin(
    IN input_year INT,
    IN input_country VARCHAR(50),
    IN input_product_cat VARCHAR(50)
)

BEGIN

    SELECT 
     CONCAT(ROUND((SUM(s.Profit) / SUM(s.SalesAmount)) * 100, 2),'%') AS ProfitMargin
FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat);
        
END //

DELIMITER ;

CALL Profit_Margin(2013, 'Australia','bikes');


#4. KPI: Total Orders
SELECT count(distinct salesordernumber) AS TotalOrders
FROM Sales;

#4a KPI: Total Orders  by Filters
DELIMITER //

CREATE PROCEDURE Total_Orders(
    IN input_year INT,
    IN input_country VARCHAR(50),
    IN input_product_cat VARCHAR(50)
)

BEGIN

    SELECT 
     count(distinct salesordernumber) AS TotalOrders
FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat);
        
END //

DELIMITER ;

CALL total_orders(2013, 'Australia','bikes');


#5. Revenue Trend (Monthly)

SELECT 
        d.EnglishMonthName,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS MonthlyRevenue
    FROM Sales s
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
        GROUP BY d.Englishmonthname;
        
#5a. Revenue Trend (Monthly) With filters
DELIMITER //

CREATE PROCEDURE Monthly_Revenue(
    IN input_year INT,
    IN input_country VARCHAR(50),
     IN input_product_cat VARCHAR(50)
)
BEGIN

SELECT 
        d.EnglishMonthName,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS MonthlyRevenue
    FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey       
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat)
 GROUP BY d.Englishmonthname;
   
END //

DELIMITER ;

CALL Monthly_Revenue(2013, 'United States','Bikes');

#6. Quarterly Revenue

SELECT 
        d.CalendarQuarter,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS QuarterlyRevenue,
        CONCAT(ROUND(SUM(s.Profit) / 1000000, 2),' M') AS QuarterlyProfit
		FROM Sales s
		JOIN Date d 
        ON s.OrderDateKey = d.DateKey
        group by d.calendarquarter
        order by d.calendarquarter;

#6a. Quarterly Revenue with Filters

DELIMITER //

CREATE PROCEDURE Quaterly_revenue(
    IN input_year INT,
    IN input_country VARCHAR(50),
    IN input_product_cat VARCHAR(50)
)

BEGIN

SELECT 
        d.CalendarQuarter,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS QuarterlyRevenue,
        CONCAT(ROUND(SUM(s.Profit) / 1000000, 2),' M') AS QuarterlyProfit
		FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
         WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat)
 
        group by d.calendarquarter
        order by d.calendarquarter;
        
END //

DELIMITER ;


CALL Quaterly_revenue(2013, 'Australia','bikes');


#7. Sales Vs PRoductionCost (Monthly)

SELECT 
        d.EnglishMonthName,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalSales,
        CONCAT(ROUND(SUM(s.productionCost) / 1000000, 2),' M') AS ProductionCost
    FROM Sales s
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
	GROUP BY d.Englishmonthname;

#7a. Sales Vs PRoductionCost (Monthly) with filter
DELIMITER //

CREATE PROCEDURE Sales_productioncost(
    IN input_year INT,
    IN input_country VARCHAR(50),
     IN input_product_cat VARCHAR(50)
)
BEGIN

SELECT 
        d.EnglishMonthName,
        round(sum(s.SalesAmount),2) AS TotalSales,
       round(sum(s.productionCost),2) AS ProductionCost
    FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
	WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat)
 GROUP BY d.Englishmonthname;
   
END //

DELIMITER ;


CALL sales_productioncost(2013, 'Canada','Bikes');

#8. Country wise sales
SELECT 
        t.salesterritoryCountry as Country,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS Sales,
        CONCAT(ROUND(SUM(s.Profit) / 1000000, 2),' M') AS Profit
       FROM Sales s
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
	group by t.salesterritorycountry;

#8a. Country wise sales with filters

DELIMITER //

CREATE PROCEDURE Sales_country(
    IN input_year INT,
    IN input_country VARCHAR(50),
     IN input_product_cat VARCHAR(50)
)
BEGIN
SELECT 
        t.salesterritoryCountry as Country,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS Sales,
        CONCAT(ROUND(SUM(s.Profit) / 1000000, 2),' M') AS Profit
       FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
        	WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat)
	group by t.salesterritorycountry;
END //

DELIMITER ;

CALL sales_country(2013, 'Canada','Bikes');


#9. Year wise sales
SELECT 
        d.CalendarYear as Year,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS Sales,
        CONCAT(ROUND(SUM(s.Profit) / 1000000, 2),' M') AS Profit
       FROM Sales s
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
	group by d.Calendaryear
    order by d.calendaryear;

#9a. Country wise sales with filters

DELIMITER //

CREATE PROCEDURE Sales_year(
    IN input_year INT,
    IN input_country VARCHAR(50),
     IN input_product_cat VARCHAR(50)
)
BEGIN
SELECT 
        d.CalendarYear as Year,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS Sales,
        CONCAT(ROUND(SUM(s.Profit) / 1000000, 2),' M') AS Profit
       FROM Sales s
    JOIN Product P
		ON s.ProductKey=P.ProductKey
	JOIN prodsubcategory PSC
		ON P.ProductSubCategoryKey=PSC.ProductSubCategoryKey
    JOIN prodcategory PG
		ON PSC.ProductCategoryKey=PG.ProductCategoryKey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    JOIN SalesTerritory t
        ON s.SalesTerritoryKey = t.SalesTerritoryKey
        	WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_country IS NULL 
           OR t.SalesTerritoryCountry = input_country)
	  AND (input_product_cat IS NULL 
           OR pg.EnglishProductCategoryName = input_product_cat)
	group by d.calendarYear;
END //

DELIMITER ;

CALL Sales_year(2013, 'Canada','Bikes');

-- CUSTOMER BEHAVIOUR ANALYSIS--

-- KPI-1: Total customer
SELECT COUNT(DISTINCT CustomerKey) AS TotalCustomers FROM Sales;

-- KPI-1a: Total customer filter
DELIMITER //

CREATE PROCEDURE Total_Customers(
    IN input_year INT,
    IN input_gender VARCHAR(50),
    IN input_agegroup VARCHAR(50),
    IN input_incomelevel VARCHAR(50)
)
BEGIN

    SELECT 
        COUNT(DISTINCT c.CustomerKey) AS TotalCustomers
    FROM Sales s
    JOIN customer c
		ON s.customerkey=c.customerkey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_gender IS NULL 
           OR c.gender = input_gender)
	  AND (input_agegroup IS NULL 
           OR c.agegroup = input_agegroup)
      AND (input_incomelevel IS NULL 
           OR c.incomelevel = input_incomelevel);
    

END //

DELIMITER ;

CALL Total_Customers(2013,'male','adult','low');


#2 sales by gender

SELECT 
		c.gender,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalSales
    FROM Sales s
    JOIN customer c
		ON s.customerkey=c.customerkey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
        group by c.gender;
    
#2a sales by gender filter

DELIMITER //

CREATE PROCEDURE gender_sales(
    IN input_year INT,
    IN input_gender VARCHAR(50),
    IN input_agegroup VARCHAR(50),
    IN input_incomelevel VARCHAR(50)
)
BEGIN

    SELECT 
    c.gender,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalSales
    FROM Sales s
    JOIN customer c
		ON s.customerkey=c.customerkey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_gender IS NULL 
           OR c.gender = input_gender)
	  AND (input_agegroup IS NULL 
           OR c.agegroup = input_agegroup)
      AND (input_incomelevel IS NULL 
           OR c.incomelevel = input_incomelevel)
		group by c.gender;

END //

DELIMITER ;

CALL gender_sales(2013,'male','adult','low');

#3 sales by agegroup

SELECT 
		c.agegroup,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalSales
    FROM Sales s
    JOIN customer c
		ON s.customerkey=c.customerkey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
        group by c.agegroup;
    
#3a sales by gender filter

DELIMITER //

CREATE PROCEDURE agegroup_sales(
    IN input_year INT,
    IN input_gender VARCHAR(50),
    IN input_agegroup VARCHAR(50),
    IN input_incomelevel VARCHAR(50)
)
BEGIN

    SELECT 
    c.agegroup,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalSales
    FROM Sales s
    JOIN customer c
		ON s.customerkey=c.customerkey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_gender IS NULL 
           OR c.gender = input_gender)
	  AND (input_agegroup IS NULL 
           OR c.agegroup = input_agegroup)
      AND (input_incomelevel IS NULL 
           OR c.incomelevel = input_incomelevel)
		group by c.agegroup;

END //

DELIMITER ;

CALL agegroup_sales(2013,'male','adult','low');



#4 sales by incomelevel

SELECT 
		c.incomelevel,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalSales
    FROM Sales s
    JOIN customer c
		ON s.customerkey=c.customerkey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
        group by c.incomelevel;
    
#4a sales by gender filter

DELIMITER //

CREATE PROCEDURE incomelevel_sales(
    IN input_year INT,
    IN input_gender VARCHAR(50),
    IN input_agegroup VARCHAR(50),
    IN input_incomelevel VARCHAR(50)
)
BEGIN

    SELECT 
    c.incomelevel,
        CONCAT(ROUND(SUM(s.SalesAmount) / 1000000, 2),' M') AS TotalSales
    FROM Sales s
    JOIN customer c
		ON s.customerkey=c.customerkey
    JOIN Date d 
        ON s.OrderDateKey = d.DateKey
    WHERE (input_year IS NULL OR d.CalendarYear = input_year)
      AND (input_gender IS NULL 
           OR c.gender = input_gender)
	  AND (input_agegroup IS NULL 
           OR c.agegroup = input_agegroup)
      AND (input_incomelevel IS NULL 
           OR c.incomelevel = input_incomelevel)
		group by c.incomelevel;

END //

DELIMITER ;

CALL incomelevel_sales(2013,'male','adult','low');

#5 KPI-: Repeat Customers
SELECT 
    COUNT(*) AS RepeatCustomers
FROM (
    SELECT CustomerKey
    FROM Sales
    GROUP BY CustomerKey
    HAVING COUNT(*) > 1
) t;

-- 6 KPI-4 OneTimeCustomers
SELECT 
    COUNT(*) AS OneTimeCustomers FROM (
    SELECT CustomerKey
    FROM Sales
    GROUP BY CustomerKey
    HAVING COUNT(*) = 1) t;


-- PRODUCT PERFORMANCE ANALYSIS--


#1. Products In Stock
SELECT COUNT(*) AS products_in_stock
FROM product
WHERE status="current";


#2. Distinct Products Sold
SELECT COUNT(DISTINCT Productkey) AS distinct_products
FROM sales;


#3. Average Unit Price
SELECT ROUND(AVG(UnitPrice),2) AS avg_unit_price
FROM sales;


#4. Total Orders
SELECT COUNT(DISTINCT SalesOrdernumber) AS total_orders
FROM sales;


#5.TOP 10 PRODUCTS BY SALES(BAR CHART)
SELECT 
    p.EnglishProductName AS product_name,
    round(sum(s.SalesAmount),2) AS total_sales
FROM sales s
JOIN product p ON s.Productkey = p.Productkey
group by p.EnglishProductName
ORDER BY total_sales DESC
LIMIT 10;


#6.PRODUCT CATEGORY WISE SALES (Pie Chart)
SELECT 
    pc.EnglishproductcategoryName AS Product_Category,
    round(SUM(s.salesamount),2) AS total_sales
FROM sales s
JOIN product p ON s.Productkey = p.Productkey
JOIN prodsubcategory psc ON p.ProductSubcategorykey = psc.ProductSubcategorykey
JOIN prodcategory pc ON psc.ProductCategorykey = pc.ProductCategorykey
GROUP BY pc.Englishproductcategoryname;


#7.CATEGORY VS QUANTITY (Column Chart)
SELECT 
    pc.EnglishproductcategoryName AS Product_Category,
    round(SUM(s.orderquantity),2) AS order_quantity
FROM sales s
JOIN product p ON s.Productkey = p.Productkey
JOIN prodsubcategory psc ON p.ProductSubcategorykey = psc.ProductSubcategorykey
JOIN prodcategory pc ON psc.ProductCategorykey = pc.ProductCategorykey
GROUP BY pc.Englishproductcategoryname;


#8.PRODUCT LINE WISE SALES (Mountain / Road / Touring)
SELECT 
	p.ProductLine as ProductLine,
    round(SUM(s.salesamount),2) AS total_sales
FROM sales s
JOIN product p ON s.ProductKey = p.Productkey
GROUP BY productline;

#9.Profit by Product(ADDITIONAL KPI)
SELECT 
    pc.EnglishproductcategoryName AS Product_Category,
    round(SUM(s.Profit),2) AS total_Profit
FROM sales s
JOIN product p ON s.Productkey = p.Productkey
JOIN prodsubcategory psc ON p.ProductSubcategorykey = psc.ProductSubcategorykey
JOIN prodcategory pc ON psc.ProductCategorykey = pc.ProductCategorykey
GROUP BY pc.Englishproductcategoryname;



