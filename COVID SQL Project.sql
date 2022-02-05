-- Tables:  Covid Deaths & Covid Vaccinations 
SELECT * FROM PortfolioProject.dbo.coviddeaths$ ORDER BY 3,4;
SELECT * FROM PortfolioProject.dbo.covidvaccinations$ ORDER BY 3,4;

-- COVID Cases and Deaths Overall
SELECT location, date, new_cases, total_cases, total_deaths, population 
FROM PortfolioProject.dbo.coviddeaths$
ORDER BY 1, 2;

-- Total Cases vs. Total Deaths in U.S.
-- Shows Death Rates of COVID Cases
SELECT location, date, total_deaths, total_cases,  ((total_deaths/total_cases)*100) AS "% Deaths"
FROM PortfolioProject.dbo.coviddeaths$
WHERE Location LIKE '%states%'
ORDER BY 1,2;
-- % Deaths in 2020: Was up to 6.0% at one point.
-- % Deaths in 2021: Was up to 1.8% at most.

-- Total Cases vs. Population in U.S.
-- Shows % of Population Has COVID
SELECT location, date, total_cases, population,  ((total_cases/population)*100) AS "% Cases in Population"
FROM PortfolioProject.dbo.coviddeaths$
WHERE Location LIKE '%states%'
GROUP BY location, population
ORDER BY 1,2;
-- % of Cases in Population for 2022:  17.8%

-- Looking at Countries with Highest Infection Rates 
SELECT location, MAX(total_cases) AS "Highest Infection Count", population,  MAX((total_cases/population)*100) AS "% Population Infected"
FROM PortfolioProject.dbo.coviddeaths$
GROUP BY location, population
ORDER BY "% Population Infected" DESC;

-- Looking at Countries with Highest Death Count
SELECT location, MAX(cast(total_deaths AS INT)) AS "Highest Death Count"
FROM PortfolioProject.dbo.coviddeaths$
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY "Highest Death Count" DESC;
-- U.S. has the highest death count of 836,603
-- total_deaths has a variable type of nvarchar(255)
-- nvarchar(255) data type is used to store string data
-- Hence the reason why total_deaths had to be cast as an integer before the maximum number can be found

-- Looking at Continents with Highest Death Count Per Population
SELECT continent, MAX(cast(total_deaths AS INT)) AS "Highest Death Count"
FROM PortfolioProject.dbo.coviddeaths$
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY "Highest Death Count" DESC;

-- Global Numbers
SELECT date, SUM(new_cases) AS "Total Cases", SUM(cast(new_deaths AS INT)) AS "Total Deaths", SUM(cast(new_deaths AS INT))/SUM(new_cases)*100 AS "Death %"
FROM PortfolioProject.dbo.coviddeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

-- References
SELECT * FROM PortfolioProject.dbo.coviddeaths$;
SELECT * FROM PortfolioProject.dbo.covidvaccinations$;
