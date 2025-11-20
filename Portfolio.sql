-- Data Exploration on SQL
create database portfolio;
select *
from CovidDeaths
WHERE continent IS NOT NULL
order by 3,4;

select *
from CovidVaccinations
WHERE continent IS NOT NULL
order by 3,4;

select location,date,total_cases,new_cases,total_deaths,population
From CovidDeaths
WHERE continent IS NOT NULL
order by 1,2;

-- looking at TOTAL cases VS Total Death
SELECT location,
       date,
       total_cases,
       total_deaths,
       (CAST(total_deaths AS FLOAT) / NULLIF(total_cases, 0)) * 100 AS deathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

--Looking at Total Cases vs Population 
-- Shows what percentage of Population got Covid

SELECT location,
       date,
       total_cases,
       population,
       (CAST(total_cases AS FLOAT) / NULLIF(population, 0)) * 100 AS cases_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

--looking at countries with Higerst infection rate compared to population 
SELECT location,
       max(total_cases) as highestinfectioncount,
       population,
      max( (CAST(total_cases AS FLOAT) / NULLIF(population, 0))) * 100 AS cases_percentage
FROM CovidDeaths
group by location,population
ORDER BY 4 desc;

--showing countries with highest death
SELECT location,
       max(total_deaths) as highestdeathcount    
From CovidDeaths
WHERE continent IS NOT NULL
group by location,population
ORDER BY 2 DESC;

-- Let's Break Things down by Continent

-- Showing contintents with the highest death count per population
SELECT continent,
       max(total_deaths) as highestdeathcount    
From CovidDeaths
where continent is not null
group by continent
ORDER BY 2 DESC;

--Showing total cases and total death yearly for continent
SELECT continent, left(date,4) as year,
       sum(total_deaths) as sum_death,sum(cast(total_cases as FLOAT)) as total_cases 
From CovidDeaths
where continent is not null
group by continent,left(date,4)
ORDER BY 3,4 desC;

--new cases and new death per year
SELECT continent, left(date,4) as year,
       sum(new_cases) as sum_new_cases,sum(cast(new_deaths as FLOAT)) as sum_new_deaths,(sum(cast(new_deaths as FLOAT))/sum(new_cases))/100 as new_deathpercentage
From CovidDeaths
where continent is not null
group by continent,left(date,4)
ORDER BY 5 desC;

-- Across the world 
SELECT sum(total_deaths) as sum_death,
sum(cast(total_cases as FLOAT)) as total_cases,
sum(new_cases) as sum_new_cases,
sum(cast(new_deaths as FLOAT)) as sum_new_deaths,
(sum(cast(new_deaths as FLOAT))/sum(new_cases))/100 as new_deathpercentage
From CovidDeaths
where continent is not null
ORDER BY 1,2 desC;

--Looking at Total population vs vaccination 

--Use CTE 
WITH popvsvac (
    continent,
    location,
    date,
    population,
    new_vaccinations,
    rollingpeoplevaccination
) AS (
    SELECT 
        death.continent,
        death.location,
        death.date,
        death.population,
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS INT)) 
            OVER (PARTITION BY death.location ORDER BY death.date) AS rollingpeoplevaccination
    FROM CovidDeaths AS death
    JOIN CovidVaccinations AS vac 
        ON death.location = vac.location 
       AND death.date = vac.date
)
SELECT *,(rollingpeoplevaccination/population)*100
FROM popvsvac;
