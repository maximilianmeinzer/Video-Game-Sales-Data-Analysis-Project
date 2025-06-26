-- SQL Data Exploration
-- Defining a cleaned dataset for every analysis below

WITH CleanedVGSales AS (
    SELECT
        Name,
        Platform,
        CAST(Year AS INT) AS ReleaseYear,
        Genre,
        Publisher,
        NA_Sales,
        EU_Sales,
        JP_Sales,
        Other_Sales,
        Global_Sales
    FROM
        dbo.vgsales
    WHERE
        Year IS NOT NULL
        AND Year <> 'N/A'
        AND CAST(Year AS INT) <> 2020
        AND Publisher IS NOT NULL
        AND Publisher <> 'N/A'
        )



-- 1) Top 10 Best Selling Games
SELECT TOP 10 
    Name, Platform, Global_Sales
FROM 
    CleanedVGSales
ORDER BY 
    Global_Sales DESC;

-- 2) Total Sales by Platform
SELECT 
    Platform, SUM(Global_Sales) AS TotalGlobalSales
FROM 
    CleanedVGSales
GROUP BY 
    Platform
ORDER BY 
    TotalGlobalSales DESC;

-- 3) Total Sales by Genre
SELECT 
    Genre, SUM(Global_Sales) AS TotalGlobalSales
FROM 
    CleanedVGSales
GROUP BY 
    Genre
ORDER BY 
    TotalGlobalSales DESC;

-- 4) Average Sales per Game by Genre
SELECT 
    Genre, AVG(Global_Sales) as AverageGlobalSales
FROM 
    CleanedVGSales
GROUP BY 
    Genre
ORDER BY 
    AverageGlobalSales DESC;

-- 5) Games per Year
SELECT 
    ReleaseYear, 
    COUNT(Name) AS NumberofGamesReleased
FROM 
    CleanedVGSales
GROUP BY 
    ReleaseYear
ORDER BY 
    ReleaseYear;

-- 6) Yearly Sales Trends for Top 3 Genres
--(WITH)
, TopGenres AS (
    SELECT TOP 3 Genre
    FROM CleanedVGSales
    GROUP BY Genre
    ORDER BY SUM(Global_Sales) DESC

-- 7) Nintendo's Top 5 Bestselling Games
SELECT 
    TOP 5 Name, Platform, ReleaseYear, Global_Sales
FROM 
    CleanedVGSales
WHERE 
    Publisher = 'Nintendo'
ORDER BY 
    Global_Sales DESC;

-- 8) Games Released after 2000 with over 10 million Sales in North America
SELECT 
    Name, Platform, ReleaseYear, NA_Sales
FROM 
    CleanedVGSales
WHERE 
    ReleaseYear >= 2000 
    AND NA_Sales >= 10
ORDER BY 
    NA_Sales DESC;

-- 9) Publishers with more than 100 Games Released and Total Sales
SELECT 
    Publisher, 
    COUNT(Name) AS NumberofGames, 
    SUM(Global_Sales) as TotalGlobalSales
FROM 
    CleanedVGSales
GROUP BY 
    Publisher
HAVING 
    COUNT(Name) >= 100
ORDER BY 
    TotalGlobalSales DESC;

-- 10) Games that sold better in JP than NA
SELECT
    Name,
    Platform,
    ReleaseYear,
    JP_Sales,
    NA_Sales
FROM
    CleanedVGSales
WHERE
    JP_Sales > NA_Sales AND JP_Sales > 1
ORDER BY
    JP_Sales DESC;

-- 11) Top 3 Most Sold Genres in Japan

SELECT TOP 3 
    Genre, SUM(JP_Sales) AS TotalJPSales
FROM 
    CleanedVGSales
GROUP by 
    Genre
ORDER BY 
    TotalJpSales DESC

-- 12) Rank Games by Sales within each Genre
SELECT
    Name,
    Platform,
    Genre,
    Global_Sales,
    ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY Global_Sales DESC) AS Rank_Within_Genre
FROM
    CleanedVGSales
ORDER BY
    Genre, Rank_Within_Genre;
)
SELECT
    vg.ReleaseYear,
    vg.Genre,
    SUM(vg.Global_Sales) AS Yearly_Genre_Sales
FROM
    CleanedVGSales AS vg
JOIN
    TopGenres AS tg ON vg.Genre = tg.Genre
GROUP BY
    vg.ReleaseYear, vg.Genre
ORDER BY
    vg.ReleaseYear, Yearly_Genre_Sales DESC;

-- 13) Best selling Game for each Genre
SELECT Name, Platform, Genre, Global_Sales
FROM (
    SELECT
        Name,
        Platform,
        Genre,
        Global_Sales,
        ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY Global_Sales DESC) AS rank
    FROM
        CleanedVGSales
) AS RankedSales
WHERE rank = 1;


