# COVID-19 Global Analytics Dashboard
### From 0 to 150M cases, how COVID-19 spread across continents from Jan 2020 to Apr 2021

<img width="1450" height="761" alt="image" src="https://github.com/user-attachments/assets/26802798-5dd5-4f08-bef7-17a0271341ba" />

## Project Overview
This is an end-to-end data analytics project that explores global COVID-19 trends across **219 countries** from **January 2020 to April 2021**. The project follows a complete data analytics workflow, from raw data exploration in SQL to an interactive dashboard in Power BI.

**Tools used:** SQL Server (SSMS) · Power BI · DAX

## Project Workflow
Raw Data → SQL Exploration → Exported Tables → Power BI Dashboard

1. Wrote SQL queries to explore and transform two raw datasets (CovidDeaths, CovidVaccinations)
2. Calculated key metrics including Case Fatality Rate, infection rate by population, and rolling vaccinations using CTEs and window functions
3. Exported query results into 4 structured tables
4. Built an interactive Power BI dashboard with KPI cards, time series, donut chart and country-level visuals


## Data Sources

| File | Description | Rows |
|---|---|---|
| `global_totals.xlsx` #Table 1 | Total cases, deaths, CFR and vaccinations globally | 1 |
| `deaths_by_continent.xlsx`  #Table 2| Total death count broken down by continent | 6 |
| `country_infection_rates.xlsx` #Table 3 | Infection rate snapshot for 219 countries | 219 |
| `infection_rate_over_time.xlsx` #Table 4 | Daily infection rates per country Jan 2020 – Apr 2021 | 85,171 |

## SQL Queries

The `Portfolio.sql` file contains the following explorations:

| Query | Description |
|---|---|
| Total cases vs total deaths | Calculates Case Fatality Rate (CFR) per country |
| Total cases vs population | Shows what % of each country's population got COVID |
| Highest infection rate by country | Ranks countries by cases as % of population |
| Highest death count by country | Top countries by confirmed death toll |
| Deaths by continent | Breaks down total deaths across 6 continents |
| Global totals | Worldwide aggregate cases, deaths and CFR |
| Population vs vaccinations (CTE) | Rolling vaccination count using window functions |


## Dashboard Visuals

| Visual | Data source | Insight |
|---|---|---|
| KPI cards | Table 1 | Global totals at a glance |
| Line chart | Table 4 | Infection rate rising every Quarter without exception |
| Donut chart | Table 2 | Europe and N. America account for 58% of all deaths |
| Bar chart | Table 3 | Small European nations hardest hit proportionally |
| Table | Table 3 | Top 15 countries by raw case count |

## Key Findings
1. **USA had the highest cases with 32.3m confirmed cases**, nearly double india despite having less than a quarter of the population
2.  **Small European nations were hardest hit proportionally**, with Andorra having the highest infection rate 17.13% of its population, followed by montenegro at 15.51% and czechia at 15.23%
3. **India's infection rate was only 1.39%** despite 19.2M cases , a direct result of its 1.38 billion population absorbing the impact
4. **Europe led continental deaths** at 1,016,750, accounting for 32% of all global deaths despite having a smaller population than Asia
5. **Case Fatality Rate of 2.11%**, meaning roughly 1 in 47 confirmed cases resulted in death globally
6. **Infection rates rose every single month** without exception, from near zero in early 2020 to 2.70% average by April 2021
7. **39.8 billion vaccine doses** were administered globally


## Key SQL Concepts Used

- `CAST` and `NULLIF` for safe division
- `GROUP BY` and aggregate functions (`MAX`, `SUM`)
- Window functions with `OVER` and `PARTITION BY`
- Common Table Expressions (CTEs)
- `JOIN` across two datasets
- Filtering with `WHERE continent IS NOT NULL`

## Key DAX Measures Used
```dax
-- Case Fatality Rate
Case Fatality Rate (CFR) = 
FORMAT(
    DIVIDE(SUM('Table1'[total_deaths]), SUM('Table1'[total_cases]), 0) * 100,
    "0.00"
) & "%"

-- Global Death Rate per 100K
Global Death Rate (per 100K) = 
DIVIDE(SUM('Table1'[total_deaths]), SUM('Table3'[Population]), 0) * 100000

-- Monthly Infection Rate Trend
CFR Trend = 
VAR latestMonth = MONTH(MAX('Table4'[date]))
VAR latestYear = YEAR(MAX('Table4'[date]))
VAR prevM = MONTH(EDATE(MAX('Table4'[date]),-1))
VAR prevY = YEAR(EDATE(MAX('Table4'[date]),-1))
VAR current = CALCULATE(
    AVERAGE('Table4'[PercentPopulationInfected]),
    MONTH('Table4'[date]) = latestMonth,
    YEAR('Table4'[date]) = latestYear
)
VAR previous = CALCULATE(
    AVERAGE('Table4'[PercentPopulationInfected]),
    MONTH('Table4'[date]) = prevM,
    YEAR('Table4'[date]) = prevY
)
VAR change = DIVIDE(current - previous, previous, 0) * 100
RETURN
IF(change > 0,
    "▲ " & FORMAT(change, "0.00") & "% vs prev month",
    "▼ " & FORMAT(ABS(change), "0.00") & "% vs prev month")
```

## Data Credit

Dataset obtained from [Alex The Analyst](https://github.com/AlexTheAnalyst/PortfolioProjects) — CovidDeaths.xlsx and CovidVaccinations.xlsx from the PortfolioProjects repository. Original data sourced from Our World in Data COVID-19 dataset.

All SQL queries, DAX measures, data transformations and dashboard design are my own work.



## Author

**Lilian Okeke**  
Data Analytics Portfolio Project  
[GitHub](https://github.com/OkekeLilian) · [LinkedIn](https://www.linkedin.com/in/okeke-lilian-ba5baa244/)



