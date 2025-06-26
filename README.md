# Video Game Analysis Project

## Introduction

Hi! I'm Max, an aspiring data analyst currently building my skills in SQL and data visualization.
This repository showcases my SQL skills through an analysis of a video game sales dataset. 
The project covers essential data exploration and data cleaning techniques.

## Table of Contents

* [Introduction](#Introduction)  

* [Goal of the Project](#Goal-of-the-Project)  

* [Dataset](#Dataset)  

* SQL
	* [Data Cleaning in SQL](#Data-Cleaning-in-SQL)  
	* [Data Exploration in SQL](#Data-Exploration-in-SQL)  

## Goal of the Project:
To extract meaningful insights and identify key trends from historical video game sales

## Dataset

This project uses the **Video Game Sales** dataset from [Kaggle](https://www.kaggle.com/datasets/gregorut/videogamesales).
Originally uploaded by **Gregory Smith**.  
Key columns include:

  **Rank:** Global sales rank of the game  
  **Name:** Name of the video game  
  **Platform:** Gaming console platform (e.g., PS4, Xbox 360, PC)  
  **Year:** Release year of the game  
  **Genre:** Game genre (e.g., Action, Sports, RPG)  
  **Publisher:** Company that published the game  
  **NA_Sales:** Sales in North America (in millions USD)  
  **EU_Sales:** Sales in Europe (in millions USD)  
  **JP_Sales:** Sales in Japan (in millions USD)  
  **Other_Sales:** Sales in other regions (in millions USD)  
  **Global_Sales:** Total worldwide sales (in millions USD)  

## Data Cleaning in SQL

[Video Game Sales Data Cleaning](sql_codes/data_cleaning.sql)

When working with a dataset, the data in it can be very messy due to missing values or inconsistencies. Therefore data cleaning is an essential step when analyzing and working with data. In SQL, there are many ways to identify and correct these inconsistencies, as shown in the provided SQL file. The first query provides a quick glance at the entire dataset, helping to form a general idea and identify potential areas for inconsistency checks.

### 1. Identifying Missing Values

Missing values are one of the most common problems encountered in raw datasets. I inspected **DISTINCT** values in key columns like *Year* and *Publisher*, to reveal if missing values exist. Instead of **NULLs** the missing values were saved as **N/A** Strings. The next query counted the exact number of missing entries across all relevant columns, where we found out that there were **271** missing entries in the *Year* column and **58** in the *Publisher* column. We achieved this by using the **SUM** Aggregate function with a **CASE** Statement, which identified records that were **NULL** or contained the **'N/A'**. This led to the decision to exclude these incomplete entries from the analysis for data integrity.

### 2. Identifying Inconsistent and Unclear Naming Schemes

Consistent naming within categorical columns is crucial for aggregations and analysis. My focus here was on standardizing entries in both the Platform and Genre columns.  

I began by examining the Platform column. A **SELECT DISTINCT** Platform query was executed to list all unique entries, which revealed several abbreviated or shorthand names (e.g., 'DC', 'PSV', 'XB') that lacked clarity and consistency, therefore values like 'DC' and 'PSV' needed to be changed to 'Dreamcast' and 'PS Vita' respectively. To address this, an **UPDATE** Statement was applied to the vgsales table, where the **CASE** Statement allows us to update multiple values in a single query. This process successfully transformed every ambiguous abbreviation into its correct, standardized, and fully spelled-out name.

Following the platform standardization, a similar **SELECT DISTINCT** check was performed on the Genre column. Here, no inconsistencies were found (meaning each genre was already consistently named), confirming its data was ready for analysis without further modification.

### 3. Identifying Outliers

Sometimes data is entered incorrectly, which is why we have to identify these outliers to avoid skewed analytical results. I focused on the **Year** and **Global_Sales** columns, as these are common areas for outliers in data.  

First, to inspect the range of the **Year** column, I queried its minimum and maximum values. This revealed a *2020* entry, which stood out as an outlier beyond the expected timeframe of the dataset. To ensure accurate trend analysis, I decided to exclude this *2020* entry from all future queries.  

Next, I examined the top-selling games to check for any extreme outliers in **Global_Sales** that might influence sales metrics. After reviewing, no significant outliers were found in the Global_Sales figures among the bestselling games.

### 4. Data Type Transformation: Preparing the **Year** Column

The next crucial step was to ensure all data was in the correct data format for analysis. The Year column, initially stored as a string or text data type, needed to be converted into an integer. This transformation is essential for accurate numerical operations and chronological sorting.  

I converted the column from its original text data type to an integer by using **CAST**, creating the **ReleaseYear** column. This transformation simultaneously applied all of the previously identified cleaning steps in the **WHERE** statement: records with NULL or 'N/A' years, as well as the 2020 outlier, were excluded. The result was a cleaned and numerically consistent year column, ready for future analysis throughout the project.

### 5. Sales Data Validation

A final critical step in data cleaning was validating the sales figures. I ensured that the reported **Global_Sales** for each game accurately matched the sum of its regional sales (NA_Sales, EU_Sales, JP_Sales, and Other_Sales).

To perform this check, I calculated the sum of regional sales for each game and compared it against the existing **Global_Sales** figure. A **CASE** statement was used to compare **Global_Sales** with the newly aggregated **Calculated_Global_Sales**, by checking whether or not the absolute value of the difference between them exceeds 100,000 sales. Upon review, the vast majority showed consistency between global and summed regional sales. While a minimal number of minor discrepancies were observed, these were negligible and did not need to be excluded. This validation confirmed the overall reliability of the sales data for subsequent analysis.

With all these cleaning steps done, I now have a clean and reliable dataset, ready to use for accurate analysis and to find valuable insights.

## Data Exploration in SQL

[Video Game Sales Data Exploration](sql_codes/data_exploration.sql)

Now that I have the data cleaned and prepared, I can finally dive into the exciting phase of data exploration. This section focuses on using the cleaned dataset to uncover key trends, identify top-performing games and publishers, and understand the various dynamics within the video game market. Through a series of SQL queries, I'll extract valuable insights, revealing patterns in sales, popularity by genre and platform, and how the industry has evolved over time.

### 1. Preparing Our Data for Exploration: The **CleanedVGSales** CTE

To ensure consistency and efficiency throughout my exploration, I first defined a Common Table Expression (CTE) named CleanedVGSales. This CTE acts as a temporary data table, which filters and Formats the dataset for all subsequent queries. It incorporates several of the crucial cleaning steps from the previous phase directly, such as:

* Converting the Year column to an integer (named ReleaseYear).
* Excluding records with missing Year (NULL or 'N/A' entries).
* Removing the 2020 outlier from the Year column.
* Excluding records with missing Publisher (NULL or 'N/A' entries).

By doing this, I avoided repeating these filtering and transformation steps in every single exploration query, making my code cleaner, faster, and less prone to errors. All the following analyses will query directly from this CleanedVGSales CTE.





## Tools Used

Database: SQL Server
IDE: SQL Server Management Studio
Visualization: Tableau, Excel
