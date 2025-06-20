-- Data Exploration in SQL
-----------------------------------------------------------------------
-- A First look at the data:

-- Top 10 Best Selling Games
SELECT TOP 10 
    Name, Platform, Global_Sales
FROM 
    dbo.vgsales
ORDER BY 
    Global_Sales DESC;

-----------------------------------------------------------------------

-- Total Sales by Platform
SELECT 
    Platform, sum(Global_Sales) AS Total_Global_Sales
FROM 
    dbo.vgsales
GROUP BY 
    Platform
ORDER BY 
    Total_Global_Sales DESC;

-----------------------------------------------------------------------

-- Total Sales by Genre
SELECT 
    Genre, sum(Global_Sales) AS Total_Global_Sales
FROM 
    dbo.vgsales
GROUP BY 
    Genre
ORDER BY 
    Total_Global_Sales DESC;

-----------------------------------------------------------------------

-- Games per Year
SELECT 
    Year, COUNT(Name) AS Number_of_Games_Released
FROM 
    dbo.vgsales
GROUP BY 
    Year
ORDER BY 
    Year;

-----------------------------------------------------------------------

-- Average Sales per Game by Genre
SELECT 
    Genre, AVG(Global_Sales) as Average_Global_Sales
FROM 
    dbo.vgsales
GROUP BY 
    Genre
ORDER BY 
    Average_Global_Sales DESC;

-----------------------------------------------------------------------

-- A deeper look in-depth look:

-----------------------------------------------------------------------

-- Nintendo's Top 5 Bestselling Games
SELECT 
    TOP 5 Name, Platform, Year, Global_Sales
FROM 
    dbo.vgsales
WHERE 
    Publisher = 'Nintendo'
ORDER BY 
    Global_Sales DESC;

-----------------------------------------------------------------------

-- Games Released after 2000 with over 10 million Sales in North America
SELECT 
    Name, Platform, Year, NA_Sales
FROM 
    dbo.vgsales
WHERE 
    Year >= 2000 AND NA_Sales >= 10
ORDER BY 
    NA_Sales DESC;

-----------------------------------------------------------------------

--Publishers with more than 100 Games Released and Total Sales
SELECT 
    Publisher, 
    COUNT(Name) AS Number_of_Games, 
    SUM(Global_Sales) as Total_Global_Sales
FROM 
    dbo.vgsales
GROUP BY 
    Publisher
HAVING 
    COUNT(Name) >= 100
ORDER BY 
    Total_Global_Sales DESC;

-----------------------------------------------------------------------

--Advanced Queries

-----------------------------------------------------------------------

--Rank Games by Sales within each Genre
SELECT
    Name,
    Platform,
    Genre,
    Global_Sales,
    ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY Global_Sales DESC) AS Rank_Within_Genre
FROM
    dbo.vgsales
ORDER BY
    Genre, Rank_Within_Genre;

-----------------------------------------------------------------------

--Yearly Sales Trends for Top 3 Genres
WITH TopGenres AS (
    SELECT TOP 3 Genre
    FROM dbo.vgsales
    GROUP BY Genre
    ORDER BY SUM(Global_Sales) DESC
)
SELECT
    vg.Year,
    vg.Genre,
    SUM(vg.Global_Sales) AS Yearly_Genre_Sales
FROM
    dbo.vgsales AS vg
JOIN
    TopGenres AS tg ON vg.Genre = tg.Genre
GROUP BY
    vg.Year, vg.Genre
ORDER BY
    vg.Year, Yearly_Genre_Sales DESC;

-----------------------------------------------------------------------

-- Games that sold better in JP than NA
SELECT
    Name,
    Platform,
    Year,
    JP_Sales,
    NA_Sales
FROM
    dbo.vgsales
WHERE
    JP_Sales > NA_Sales AND JP_Sales > 1
ORDER BY
    JP_Sales DESC;

-----------------------------------------------------------------------

-- Best selling game in each Genre

SELECT Name, Platform, Genre, Global_Sales
FROM (
    SELECT
        Name,
        Platform,
        Genre,
        Global_Sales,
        ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY Global_Sales DESC) AS rank
    FROM
        dbo.vgsales
) AS RankedSales
WHERE rank = 1;
