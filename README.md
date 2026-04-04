# COVID-19 Global Analytics Dashboard
### From 0 to 150M cases, how COVID-19 spread across continents from Jan 2020 to Apr 2021

<img width="1450" height="761" alt="image" src="https://github.com/user-attachments/assets/26802798-5dd5-4f08-bef7-17a0271341ba" />

## Project Overview
This is an end-to-end data analytics project that explores global COVID-19 trends across **219 countries** from **January 2020 to April 2021**. The project follows a complete data analytics workflow, from raw data exploration in SQL to an interactive dashboard in Power BI.

**Tools used:** SQL Server (SSMS) · Power BI · DAX

## Project Workflow
...
Raw Data → SQL Exploration → Exported Tables → Power BI Dashboard
...

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
| Line chart | Table 4 | Infection rate rising every month without exception |
| Donut chart | Table 2 | Europe and N. America account for 58% of all deaths |
| Bar chart | Table 3 | Small European nations hardest hit proportionally |
| Table | Table 3 | Top 15 countries by raw case count |

## Key Findings




