-- Data Cleaning in SQL
-----------------------------------------------------------------------
SELECT 
    *
FROM
    vgsales;

-----------------------------------------------------------------------

-- 1) Check for Missing Values (NULLS)

SELECT 
    DISTINCT Year
FROM 
    vgsales
ORDER BY
    Year DESC;

SELECT 
   DISTINCT Publisher
FROM 
   vgsales
ORDER BY
    Publisher;
-- Identified that NULLs listed as 'N/A'

-- 2) Identify how many Missing Values

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS missing_names,
    SUM(CASE WHEN Platform IS NULL THEN 1 ELSE 0 END) AS missing_platform,
    SUM(CASE WHEN Year IS NULL OR YEAR = 'N/A' THEN 1 ELSE 0 END) AS missing_year,
    SUM(CASE WHEN Genre IS NULL THEN 1 ELSE 0 END) AS missing_genre,
    SUM(CASE WHEN Publisher IS NULL OR Publisher = 'N/A' THEN 1 ELSE 0 END) AS missing_publisher,
    SUM(CASE WHEN NA_Sales IS NULL THEN 1 ELSE 0 END) AS missing_na_sales,
    SUM(CASE WHEN EU_Sales IS NULL THEN 1 ELSE 0 END) AS missing_eu_sales,
    SUM(CASE WHEN JP_Sales IS NULL THEN 1 ELSE 0 END) AS missing_jp_sales,
    SUM(CASE WHEN Other_Sales IS NULL THEN 1 ELSE 0 END) AS missing_other_sales,
    SUM(CASE WHEN Global_Sales IS NULL THEN 1 ELSE 0 END) AS missing_global_sales
FROM
    vgsales;

--Result: 271 missing year and 58 missing publisher entries, should exclude in future analysis
--WHERE
--  Publisher <> 'N/A'
--  AND Year <> 'N/A'
    


-----------------------------------------------------------------------

-- 3) Checking Platform Column for Inconsistent Naming Schemes

SELECT
    DISTINCT Platform
FROM 
    vgsales
ORDER BY
    Platform;

-- 4) Correct Unclear Names

UPDATE vgsales
SET Platform = 
    CASE
      WHEN Platform = 'DC' THEN 'Dreamcast'
      WHEN Platform = 'GEN' THEN 'Genesis'
      WHEN Platform = 'GG' THEN 'Gamegear'
      WHEN Platform = 'NG' THEN 'Neo Geo'
      WHEN Platform = 'PSV' THEN 'PS Vita'
      WHEN Platform = 'SAT' THEN 'Saturn'
      WHEN Platform = 'SCD' THEN 'Sega CD'
      WHEN Platform = 'TG16' THEN 'TurboGrafx16'
      WHEN Platform = 'WS' THEN 'WonderSwan'
      WHEN Platform = 'XB' THEN 'XBox'
      ELSE Platform
    END
WHERE Platform IN ('DC', 'GEN', 'GG', 'NG', 'PSV', 'SAT', 'SCD', 'TG16', 'WS', 'XB')
                  
-- 5) Checking Genre Column for Inconsistent Naming Schemes


SELECT
    DISTINCT Genre
FROM
    vgsales
ORDER BY
    Genre;

--No Inconsistencies found

-----------------------------------------------------------------------

-- 6) Checking Year Column for Outliers
SELECT
    MIN(Year) AS EarliestYear,
    MAX(Year) AS LatestYear
FROM
    vgsales

-- 2020 outlier, should exclude in future analysis: WHERE Year <> '2020'

-- 6) Checking Bestselling Games for Outliers
SELECT TOP 5
    Name,
    Platform,
    Year,
    Global_Sales
FROM
    vgsales
ORDER BY
    Global_Sales DESC;
-- No outliers

-----------------------------------------------------------------------

-- 7) Transforming Year Column into Integer Data Type for Future Analysis

SELECT
    Name,
    Platform,
    CAST(Year AS INT) AS Release_Year,
    Genre,
    Publisher,
    NA_Sales,
    EU_Sales,
    JP_Sales,
    Other_Sales,
    Global_Sales
FROM
    vgsales
WHERE
    Year IS NOT NULL 
    AND Year <> 'N/A'
    AND CAST(Year AS INT) <> 2020
ORDER BY
    Release_Year DESC;

    -----------------------------------------------------------------------

-- 8) Compare Global Sales with Sum of Regional Sales for Validation

SELECT
    Name,
    NA_Sales,
    EU_Sales,
    JP_Sales,
    Other_Sales,
    Global_Sales,
    (NA_Sales + EU_Sales + JP_Sales + Other_Sales) AS Calculated_Global_Sales,
    CASE
        WHEN ABS((NA_Sales + EU_Sales + JP_Sales + Other_Sales) - Global_Sales) < 0.01 THEN 'Match'
        ELSE 'Mismatch'
    END AS Global_Sales_Comparison
FROM
    vgsales
ORDER BY
    Global_Sales_Comparison DESC, Name;


