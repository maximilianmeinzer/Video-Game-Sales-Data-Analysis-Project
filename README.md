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

When working with a dataset, the data in it can be very messy due to missing values or inconsistencies, therefore data cleaning is an essential step when analyzing and working with data. In SQL, there are many ways to identify and correct these inconsistencies, as shown in the provided SQL file. The first query provides a quick glance at the entire dataset, helping to form a general idea and identify potential areas for incosistency checks.

### 1. Identifying Missing Values

Missing values are one of the most common problems encountered in raw datasets. We inspected **DISTINCT** values in key columns like *Year* and *Publisher, to reveal if missing values exist. Instead of **NULLs** the missing values were saved as **N/A** Strings. The next query counted the exact number of missing entries across all relevant columns, where we found out that there were **271** missing entries in the *Year* column and **58** in the *Publisher* column. We achieved this by using the **SUM** Aggregate function with a **CASE** Statement, which identified records that were **NULL** or containted the **'N/A'**. This led to the decision to exclude these incomplete entries from the analysis for data integrity.

### 2. Identifying Inconsistent and Unclear Naming Schemes

Consistent naming within categorical columns is crucial for aggregations and analysis. Our focus here was on standardizing entries in both the Platform and Genre columns. We began by examining the Platform column. A SELECT DISTINCT Platform query was executed to list all unique entries, which revealed several abbreviated or shorthand names (e.g., 'DC', 'PSV', 'XB') that lacked clarity and consistency, therefore values like 'DC' and 'PSV' needed to be changed to 'Dreamcast' and 'PS Vita' respectively. To address this, an UPDATE Statement was applied to the vgsales table, where the CASE Statement allows us to update multiple values in a single query. This process successfully transformed every ambiguous abbreviation into its correct, standardized, and fully spelled-out name.

Following the platform standardization, a similar SELECT DISTINCT check was performed on the Genre column. Here, no inconsistencies were found (meaning each genre was already consistently named), confirming its data was ready for analysis without further modification.

## Data Exploration in SQL

[Video Game Sales Data Exploration](sql_codes/data_exploration.sql)


## Tools Used

Database: SQL Server
IDE: SQL Server Management Studio
Visualization: Tableau, Excel
