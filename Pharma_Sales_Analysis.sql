--Identify DATABASE
SELECT DB_NAME() AS CurrentDatabase;

--Identify Database's Tables 
SELECT name 
FROM sys.tables;

--Identify Database's Constraints of Tables.
SELECT 
    table_name,
    constraint_type,
    constraint_name
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    table_schema = 'dbo';



---------------------------------------------------------------------------------------------------
--DATA EXPLORATORY

--CHANNEL TABLE
SELECT * FROM Channel 

--CITY TABLE
SELECT * FROM City 

--COUNTRY TABLE
SELECT * FROM Country

--CUSTOMER TABLE
SELECT * FROM Customer

--DISTRIBUTOR TABLE
SELECT * FROM Distributor

--MANAGER TABLE
SELECT * FROM Manager

--PRODUCT TABLE
SELECT * FROM Product

--PRODUCT_CLASS TABLE
SELECT * FROM Product_Class

--SALSE TABLE
SELECT * FROM Sales

--SALES_REP TABLE
SELECT * FROM Sales_Rep

--SALES_TEAM TABLE
SELECT * FROM Sales_Team

--SUB_CHANNEL TABLE
SELECT * FROM Sub_Channel
-----------------------------------------------------------------
--DATA CLEANING. 

--SALES TABLE.
--Identify NULL values
DECLARE @sql NVARCHAR(MAX);
SET @sql = N'SELECT * FROM sales WHERE ' +
           (SELECT STRING_AGG(CAST(column_name AS NVARCHAR(MAX)) + ' IS NULL', ' OR ') 
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = 'sales');

EXEC sp_executesql @sql;


------------------------------------------------------------------------------------------
--TOTAL SALES
SELECT 
	SUM(Revenue) AS Total_Sales
FROM
	Sales

--AVERAGE SALES
SELECT 
	AVG(Revenue) AS Average_Sales
FROM
	Sales

--TOTAL QUANTITY
SELECT 
	SUM(Quantity) AS Total_Quantity
FROM
	Sales

--AVERAGE QUANTITY
SELECT
	AVG(Quantity) AS Average_Quantity
FROM
	Sales


--SALES FOR PRODUCTS.
SELECT  Product_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Product P
ON 
	S.Product_ID=P.Product_ID
GROUP BY Product_Name
ORDER BY Total_Sales DESC;


--SALES FOR PRODUCTS CLASSES
SELECT  Class_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Product_Class PC
ON 
	S.Class_ID=PC.Class_ID
GROUP BY Class_Name
ORDER BY Total_Sales DESC;


--SALES FOR CHANNEL
SELECT  Channel_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Channel C
ON 
	S.Channel_ID=C.Channel_ID
GROUP BY Channel_Name
ORDER BY Total_Sales DESC;


--SALES FOR SUB_CHANNEL
SELECT  Sub_Channel_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Sub_Channel SC
ON 
	S.Sub_Channel_ID=SC.Sub_Channel_ID
GROUP BY Sub_Channel_Name
ORDER BY Total_Sales DESC;


--SALES FOR COUNTRY
SELECT  Country,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Country C
ON 
	S.Country_ID=C.Country_ID
GROUP BY Country
ORDER BY Total_Sales DESC;


--SALES FOR CITY
SELECT  City,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN City C
ON 
	S.City_ID=C.City_ID
GROUP BY City
ORDER BY Total_Sales DESC;


--SALES FOR CUSTOMER 
SELECT  Customer_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Customer C
ON 
	S.Customer_ID=C.Customer_ID
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;


--SALES FOR DISTRIBUTOR 
SELECT  Distributor_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Distributor D
ON 
	S.Distributor_ID=D.Distributor_ID
GROUP BY Distributor_Name
ORDER BY Total_Sales DESC;


--SALES FOR TEAM
SELECT  Team_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Sales_Team ST
ON 
	S.Team_ID=ST.Team_ID
GROUP BY Team_Name
ORDER BY Total_Sales DESC;


--SALES FOR REP
SELECT  Rep_Name,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Sales_Rep SR
ON 
	S.Rep_ID=SR.Rep_ID
GROUP BY Rep_Name
ORDER BY Total_Sales DESC;


--SALES FOR MANAGER 
SELECT  Manager,
		SUM(Revenue) AS Total_Sales,
		AVG(Revenue) AS Average_Sales,
		SUM(Quantity) AS Total_Quantity,
		AVG(Quantity) AS Average_Quantty
FROM 
	Sales S INNER JOIN Manager M
ON 
	S.Manager_ID=M.Manager_ID
GROUP BY Manager
ORDER BY Total_Sales DESC;


--Query to Calculate Total Revenue for Each Team and Rank Them within Thier Sales.
SELECT 
    Team_Name, 
    sum(Revenue) as Total_Sales,
    RANK() OVER (ORDER BY Team_Name DESC) AS RN
FROM 
	Sales S inner join Sales_Team ST
on 
	S.Team_ID=ST.Team_ID
group by Team_Name


-- Query to Calculate Total Revenue for Each Sales Representative 
-- and Rank Them Within Each Sales Team Based on Revenue.
SELECT Team_Name,
		Rep_Name,
		SUM(Revenue) AS Total_Sales,
		row_number() over (PARTITION BY Team_Name order by sum(revenue) desc) AS Rep_Rank 
FROM 
	Sales S INNER JOIN Sales_Team ST
ON 
	S.Team_ID=ST.Team_ID 
	INNER JOIN Sales_Rep SR
ON 
	S.Rep_ID=SR.Rep_ID
GROUP BY Team_Name,Rep_Name


--Query to Calculate Total Sales for Each Class Partitioned by Team Name. 
SELECT Team_Name,
		Class_Name,
		SUM(Revenue) AS Total_Sales,
		ROW_NUMBER() over (PARTITION BY Team_Name order by SUM(Revenue) DESC) AS Tile
FROM
	Product_Class  PC INNER JOIN Sales S
ON 
	PC.Class_ID=S.Class_ID
	INNER JOIN Sales_Team ST
ON 
	S.Team_ID=ST.Team_ID
GROUP BY Class_Name,Team_Name


--Query to Calculate Sales for Each Product.
SELECT Product_Name,
		SUM(Revenue) AS Total_Sales,
		ROW_NUMBER() OVER (ORDER BY SUM(Revenue) DESC) AS RN
FROM 
	Sales S INNER JOIN Product P
ON 
	S.Product_ID=P.Product_ID
GROUP BY Product_Name


--Query to Calculate Sales for Each Product Partitioned by Class.
SELECT Product_Name,
		Class_Name,
		SUM(Revenue) AS TotaL_Sales,
		ROW_NUMBER() OVER (PARTITION BY Class_Name ORDER BY SUM(Revenue) DESC) AS RN
FROM 
	Sales S INNER JOIN Product_Class PC
ON 
	S.Class_ID=pc.Class_ID
	INNER JOIN Product P
ON 
	S.Product_ID=P.Product_ID
GROUP BY Product_Name, Class_Name


--Query to Calculate Sales for Each Repsentative Partitioned by Channel
SELECT Rep_Name,
		Channel_Name,
		SUM(Revenue) AS Total_Sales,
		ROW_NUMBER() OVER (PARTITION BY Channel_Name ORDER BY SUM(Revenue) DESC) AS RN
FROM 
	Sales S INNER JOIN Sales_Rep SR
ON 
	S.Rep_ID=SR.Rep_ID
	INNER JOIN Channel C
ON 
	S.Channel_ID=C.Channel_ID
GROUP BY Rep_Name, Channel_Name


--Query to Calcualte Sales for Each Represenatative Partitioned by Sub Channel.
SELECT Rep_Name,
		Sub_Channel_Name,
		SUM(Revenue) AS Total_Sales,
		ROW_NUMBER() OVER (PARTITION BY Sub_Channel_Name ORDER BY SUM(Revenue) DESC) AS RN
FROM 
	Sales S INNER JOIN Sales_Rep SR
ON 
	S.Rep_ID=SR.Rep_ID
	INNER JOIN Sub_Channel SC
ON 
	S.Sub_Channel_ID=SC.Sub_Channel_ID
GROUP BY Rep_Name, Sub_Channel_Name


--Top 10 Products in Sales.
SELECT TOP (10)
		P.Product_Name,
		SUM(S.Revenue) AS Total_Sales
FROM
	Sales S INNER JOIN Product P
ON 
	S.Product_ID=P.Product_ID
GROUP BY P.Product_Name
ORDER BY Total_Sales


--Top 10 Cities in Sales.
SELECT TOP (10)
		C.City,
		SUM(S.Revenue) AS Total_Sales
FROM
	Sales S INNER JOIN City C
ON 
	C.City_ID=S.City_ID
GROUP BY City
ORDER BY Total_Sales


--Top 10 Customers in Sales.
SELECT TOP(10)
	Customer_Name ,
	Channel_Name,
	SUM(Revenue)AS Customer_Sales
from
	Sales S INNER JOIN Customer C
ON C.Customer_ID=s.Customer_ID
	INNER JOIN Channel Ch
ON S.Channel_ID=Ch.Channel_ID
GROUP BY 
	Customer_Name,
	Channel_Name
ORDER BY Customer_Sales DESC

--Aggregation by Time Period.
--Total Sales by month
SELECT 
    YEAR(sales_date) AS Sales_Year,
    MONTH(sales_date) AS Sales_Month,
    SUM(revenue) AS Total_Sales
FROM Sales
GROUP BY 
    YEAR(sales_date),
    MONTH(sales_date)
ORDER BY 
    Sales_Year, 
    Sales_Month;


--Calculating Growth Rates.
--Month-Over-Month Growth
WITH MonthlySales AS (
    SELECT 
        YEAR(sales_date) AS Sales_Year,
        MONTH(sales_date) AS Sales_Month,
        SUM(revenue) AS Total_Sales
    FROM Sales
    GROUP BY 
        YEAR(sales_date),
        MONTH(sales_date)
)
SELECT 
    Sales_Year,
    Sales_Month,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Sales_Year, Sales_Month) AS Previous_Month_Sales,
    (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Sales_Year, Sales_Month)) / 
        LAG(Total_Sales) OVER (ORDER BY Sales_Year, Sales_Month) * 100 AS Month_Over_Month_Growth
FROM 
	MonthlySales
ORDER BY 
	Sales_Year, 
	Sales_Month;


--Identifying Seasonal Trends
--Sales Seasonality by Month
SELECT 
    MONTH(sales_date) AS Sales_Month,
    AVG(revenue) AS Average_Monthly_Sales
FROM Sales
GROUP BY 
    MONTH(sales_date)
ORDER BY 
    Sales_Month;


-- Analyzing Sales Distribution
--Sales by Day of the Week
SELECT 
    DATENAME(WEEKDAY, sales_date) AS Day_of_Week,
    SUM(revenue) AS Total_Sales
FROM Sales
GROUP BY 
    DATENAME(WEEKDAY, sales_date)
ORDER BY 
    CASE 
        WHEN DATENAME(WEEKDAY, sales_date) = 'Sunday' THEN 1
        WHEN DATENAME(WEEKDAY, sales_date) = 'Monday' THEN 2
        WHEN DATENAME(WEEKDAY, sales_date) = 'Tuesday' THEN 3
        WHEN DATENAME(WEEKDAY, sales_date) = 'Wednesday' THEN 4
        WHEN DATENAME(WEEKDAY, sales_date) = 'Thursday' THEN 5
        WHEN DATENAME(WEEKDAY, sales_date) = 'Friday' THEN 6
        WHEN DATENAME(WEEKDAY, sales_date) = 'Saturday' THEN 7
    END;


--Sales by Day of Week Ordered by Total Sales.
SELECT 
    DATENAME(WEEKDAY, sales_date) AS Day_of_Week,
    SUM(revenue) AS Total_Sales
FROM Sales
GROUP BY 
    DATENAME(WEEKDAY, sales_date)
ORDER BY Total_Sales desc


--Detecting Anomalies
-- Sales Outliers Detection
WITH SalesStats AS (
    SELECT 
        AVG(revenue) AS Avg_Sales,
        STDEV(revenue) AS Sales_StdDev
    FROM Sales
)
SELECT 
    sales_date,
    revenue,
    (revenue - SalesStats.Avg_Sales) / SalesStats.Sales_StdDev AS Z_Score
FROM Sales, SalesStats
WHERE ABS((revenue - SalesStats.Avg_Sales) / SalesStats.Sales_StdDev) > 2
ORDER BY 
    Z_Score DESC;


--Time Series Analysis
--Preparing Data for Time Series Analysis
SELECT 
    sales_date,
    SUM(revenue) AS Daily_Sales
FROM Sales
GROUP BY 
    sales_date
ORDER BY 
    sales_date;


--Top 10 Products over each year
WITH ranked_sales AS(
	SELECT
		YEAR(sales_date) AS sales_year,
		Product_Name,
		SUM(revenue) AS total_sales,
		ROW_NUMBER() OVER (PARTITION BY YEAR(sales_date) ORDER BY SUM(revenue) DESC) AS rank
	FROM 
		Sales s INNER JOIN Product p
	ON 
		S.Product_ID=p.Product_ID
	GROUP BY 
			YEAR(Sales_Date),
			Product_Name
)
SELECT Sales_Year,
	Product_Name,
	Total_Sales
FROM
	ranked_sales
WHERE rank<=10;


--Top 1 Sales Team  over each Year
WITH ranked_team AS(
	SELECT
		YEAR(sales_date) AS sales_year,
		team_Name,
		SUM(revenue) AS total_sales,
		ROW_NUMBER() OVER (PARTITION BY YEAR(sales_date) ORDER BY SUM(revenue) DESC) AS rank
	FROM 
		Sales s INNER JOIN Sales_Team st
	ON 
		S.Team_ID=st.Team_ID
	GROUP BY 
			YEAR(Sales_Date),
			Team_Name
)
SELECT Sales_Year,
	Team_Name,
	Total_Sales
FROM
	ranked_team
WHERE rank<=1;


--Ranking the sales_Team over each Year with each other.
WITH ranked_team AS(
	SELECT
		YEAR(sales_date) AS sales_year,
		team_Name,
		SUM(revenue) AS total_sales,
		ROW_NUMBER() OVER (PARTITION BY YEAR(sales_date) ORDER BY SUM(revenue) DESC) AS rank
	FROM 
		Sales s INNER JOIN Sales_Team st
	ON
		s.Team_ID=st.Team_ID
	GROUP BY
			YEAR(Sales_Date),
			Team_Name
)
SELECT Sales_Year,
	Team_Name,
	Total_Sales
FROM
	ranked_team
WHERE rank<=4;


--Ranking the sales Rep over each year 
WITH ranked_rep AS(
	SELECT
		YEAR(sales_date) AS sales_year,
		Rep_Name,
		sr.Rep_ID,
		SUM(Revenue) AS total_sales,
		ROW_NUMBER() OVER (PARTITION BY YEAR(sales_date) ORDER BY SUM(Revenue) DESC) AS rank
	FROM 
		Sales s INNER JOIN Sales_Rep sr
	ON
		s.Rep_ID=sr.Rep_ID
	GROUP BY 
			YEAR(Sales_date),
			sr.Rep_ID,
			Rep_Name
)
SELECT 
	Sales_Year,
	Rep_Name,
	Total_Sales
FROM
	ranked_rep
WHERE rank<=13;


--List the months with the lowest sales for each year
WITH ranked_months AS (
	SELECT
		YEAR(sales_date) AS sales_year,
		FORMAT(sales_date,'MMM') AS sales_month,
		MIN(Revenue) AS lowest_sales,
		ROW_NUMBER() OVER (PARTITION BY YEAR(sales_date) ORDER BY MIN(revenue)) AS month_rank
	FROM
		Sales
	GROUP BY 
		YEAR(sales_date),
		MONTH(sales_date),
		FORMAT(Sales_date,'MMM')
)
SELECT 
	sales_year,
	sales_month,
	lowest_sales
FROM
	ranked_months
WHERE 
	month_rank=1


--Top 1 City with the highest Total Sales for each Sub-Channel.
WITH ranked_countris AS (
	SELECT 
		Sub_Channel_Name,
		City,
		SUM(Revenue) AS total_sales,
		ROW_NUMBER() OVER 
		(PARTITION BY sub_channel_Name ORDER BY SUM(Revenue) DESC)AS City_rank
	FROM 
		Sales s INNER JOIN Sub_Channel sch
	ON
		s.Sub_Channel_ID=sch.Sub_Channel_ID
		INNER JOIN City C
	ON 
		s.City_ID=C.City_ID
	GROUP BY 
		Sub_Channel_Name,
		City
)
SELECT 
	Sub_Channel_Name,
	City,
	total_sales
FROM
	ranked_countris
WHERE City_rank=1
