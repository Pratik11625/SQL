use project;
ALTER TABLE `project`.`general data` 
 RENAME TO  `project`.`general_data` ;


--  Retrieve the total number of employees in the dataset. 
SELECT 
    EmployeeCount
FROM
    general_data;

-- . List all unique job roles in the dataset. 
SELECT 
    JobRole, COUNT(JobRole)
FROM
    general_data
GROUP BY 1
ORDER BY 2 DESC;

-- Find the average age of employees. 
SELECT 
    AVG(Age)
FROM
    general_data;

ALTER TABLE `project`.`general_data` 
CHANGE COLUMN `ï»¿Emp Name` `Emp_Name` TEXT NULL DEFAULT NULL ;
-- Retrieve the names and ages of employees who have worked at the company for more than 5 years. 
select Emp_name, Age, TotalWorkingYears from general_data 
where YearsAtCompany > 5 AND TotalWorkingYears >5 order by 3 desc;

-- Get a count of employees grouped by their department. 
select Department , count(*) as count_emp from general_data group by Department order by 2 desc;

--  List employees who have 'High' Job Satisfaction. 
select g.Emp_Name, e.JobSatisfaction from general_data as g join employee_survey_data as e
on g.EmployeeID = e.EmployeeID where e.JobSatisfaction = 4  group by 1 order by 2 desc;
 
--  Find the highest Monthly Income in the dataset
SELECT 
    MAX(MonthlyIncome) AS highes_mon_in
FROM
    general_data

-- List employees who have 'Travel_Rarely' as their BusinessTravel type.
select Emp_Name from general_data where BusinessTravel= "Travel_Rarely";

-- Retrieve the distinct MaritalStatus categories in the dataset. 
select distinct(MaritalStatus) from general_data;

--  Get a list of employees with more than 2 years of work experience but less than 4 years in their current role. 
select Emp_Name from general_data where TotalWorkingYears > 2 AND 4 > YearsWithCurrManager;

-- List employees who have changed their job roles within the company (JobLevel and JobRole differ from their previous job).
select Emp_Name from general_data where YearsAtCompany < 1 and YearsWithCurrManager < 1; 

-- Find the average distance from home for employees in each department.
SELECT 
    Department, AVG(DistanceFromHome) AS avg_distance
FROM
    general_data
GROUP BY 1
ORDER BY 2 DESC

-- Retrieve the top 5 employees with the highest MonthlyIncome. 
select Emp_Name, max(MonthlyIncome) from general_data group by 1 order by 2 desc limit 5;

-- . Calculate the percentage of employees who have had a promotion in the last year.
SELECT 
    (Sum(Emp_Name) / (SELECT 
            COUNT(Emp_Name)* 100
        FROM
            general_data
        WHERE
            YearsSinceLastPromotion > 1))
FROM
    general_data;

SELECT 
    Emp_Name, YearsSinceLastPromotion
FROM
    general_data
WHERE
    YearsSinceLastPromotion < 1
ORDER BY 2 DESC
LIMIT 10;

SELECT 
    Emp_Name,
    (SUM(YearsSinceLastPromotion) / (SELECT 
            COUNT(YearsSinceLastPromotion)
        FROM
            general_data))* 100  AS per_prom
FROM
    general_data
group by 1    
HAVING COUNT(YearsSinceLastPromotion) < 1
order BY 2 desc;

SELECT 
    Emp_Name,
    (COUNT(YearsSinceLastPromotion) / (SELECT 
            SUM(YearsSinceLastPromotion)
        FROM
            general_data
        WHERE
            YearsSinceLastPromotion < 1)) * 100 AS per_prom
FROM
    general_data
GROUP BY 1
ORDER BY 2 DESC
;

SELECT 
    Emp_Name, COUNT(YearsSinceLastPromotion)
FROM
    general_data
    group by 1
HAVING COUNT(YearsSinceLastPromotion) < (SELECT 
        SUM(YearsSinceLastPromotion) 
    FROM
        general_data)
order by 2;



--  List the employees with the highest and lowest EnvironmentSatisfaction. 
SELECT 
    g.Emp_Name,
    MIN(e.EnvironmentSatisfaction),
    MAX(e.EnvironmentSatisfaction)
FROM
    general_data AS g
        JOIN
    employee_survey_data AS e ON g.EmployeeID = e.EmployeeID
GROUP BY 1
HAVING MAX(e.EnvironmentSatisfaction) > 1
    AND MIN(e.EnvironmentSatisfaction) < 1
ORDER BY 2 , 3

-- Find the employees who have the same JobRole and MaritalStatus. 
SELECT 
    Emp_Name, JobRole, MaritalStatus
FROM
    general_data 
    where
    JobRole = 'Sales Executive' and MaritalStatus = "Single"
UNION SELECT 
    Emp_Name, JobRole, MaritalStatus
FROM
    general_data
WHERE
    JobRole = 'Sales Executive'
;

SELECT 
    g1.Emp_Name, g2.Emp_Name, g1.JobRole, g2.MaritalStatus
FROM
    general_data AS g1
        inner JOIN
    general_data AS g2 ON g1.JobRole=g2.JobRole and g1.MaritalStatus=g2.MaritalStatus
    order by 1;

-- List the employees with the highest TotalWorkingYears who also have aPerformanceRating of 4.
SELECT 
    g.Emp_Name, g.TotalWorkingYears, m.PerformanceRating
FROM
    general_data AS g
        JOIN
    manager_survey_data AS m ON g.EmployeeID = m.EmployeeID
WHERE
    m.PerformanceRating = 4
ORDER BY 2  DESC
limit 1;


--  Calculate the average Age and JobSatisfaction for each BusinessTravel type.
SELECT 
    AVG(g.Age), AVG(e.JobSatisfaction), g.BusinessTravel
FROM
    general_data AS g
        JOIN
    employee_survey_data AS e ON g.EmployeeID = e.EmployeeID
GROUP BY 3
HAVING AVG(Age) > 1
    AND AVG(JobSatisfaction) > 1
ORDER BY 3


select avg(Age), BusinessTravel from general_data group by 2;
select JobSatisfaction from employee_survey_data;


-- Retrieve the most common EducationField among employees. 
SELECT 
    Emp_Name, COUNT(MAX(EducationField))
FROM
    general_data
GROUP BY 1
HAVING COUNT(MAX(EducationField)) > 1
ORDER BY 2

SELECT 
    EducationField,
    (COUNT(EducationField) / (SELECT 
            EducationField
        FROM
            general_data
        )) as ct
FROM
    general_data
    group by 1;



--  List the employees who have worked for the company the longest but haven't had a promotion. 

SELECT 
    Emp_Name, MAX(YearsAtCompany), MAX(YearsSinceLastPromotion)
FROM
    general_data
GROUP BY 1
HAVING MAX(YearsAtCompany) > 0
    AND MAX(YearsSinceLastPromotion) > 10
ORDER BY 2 DESC



