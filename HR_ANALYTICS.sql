CREATE DATABASE hr_analytics;
USE hr_analytics;

-- Total employees
SELECT COUNT(*) AS Total_Employees
FROM hr_analytics;

-- total employees left
SELECT COUNT(*) AS Attrition_Count
FROM hr_analytics
WHERE Attrition = 'Yes';

-- employees by department
SELECT Department, COUNT(*) AS Employees
FROM hr_analytics
GROUP BY Department;

-- employees by gender
SELECT Gender, COUNT(*) AS Employees
FROM hr_analytics
GROUP BY Gender;

-- employees by job role
SELECT JobRole, COUNT(*) AS Employees
FROM hr_analytics
GROUP BY JobRole
ORDER BY Employees DESC;

-- average salary
SELECT AVG(MonthlyIncome) AS Average_Salary
FROM hr_analytics;

-- average salary age
SELECT AVG(Age) AS Average_Age
FROM hr_analytics;
 
-- highest salary
SELECT MAX(MonthlyIncome) AS Highest_Salary
FROM hr_analytics;

-- lowest salary
SELECT MIN(MonthlyIncome) AS Lowest_Salary
FROM hr_analytics;

-- average salary by department
SELECT Department,
AVG(MonthlyIncome) AS Average_Salary
FROM hr_analytics
GROUP BY Department;

-- employees works overtime
SELECT OverTime,
COUNT(*) AS Employees
FROM hr_analytics
GROUP BY OverTime;

-- employees by education field
SELECT EducationField,
COUNT(*) AS Employees
FROM hr_analytics
GROUP BY EducationField;

-- Top 10 highest salary paid employees
SELECT EmployeeNumber,
JobRole,
MonthlyIncome
FROM hr_analytics
ORDER BY MonthlyIncome DESC
LIMIT 10;

-- employees age group
SELECT
CASE
WHEN Age<=25 THEN '18-25'
WHEN Age<=35 THEN '26-35'
WHEN Age<=45 THEN '36-45'
ELSE '46+'
END AS Age_Group,
COUNT(*) AS Employees
FROM hr_analytics
GROUP BY Age_Group;

-- performance rating 
SELECT
PerformanceRating,
COUNT(*) AS Employees
FROM hr_analytics
GROUP BY PerformanceRating;

-- job satisfaction
SELECT
JobSatisfaction,
COUNT(*) AS Employees
FROM hr_analytics
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- top 5 department salary expenses
SELECT
Department,
SUM(MonthlyIncome) AS Total_Salary
FROM hr_analytics
GROUP BY Department
ORDER BY Total_Salary DESC
LIMIT 5;

-- Top 3 highest paid employees in each department
SELECT *
FROM (
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,
        DENSE_RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome DESC
        ) AS Salary_Rank
    FROM hr_analytics
) t
WHERE Salary_Rank <= 3;