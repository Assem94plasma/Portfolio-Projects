USE HR_Analysis
GO


--Creating Deparment Table.
CREATE TABLE Department(
Depart_ID INT PRIMARY KEY,
Department VARCHAR(100)
)


--Insert into Department Table.
BULK INSERT Department
FROM 'D:\DBs\HR Data Analysis\New folder\Department.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);







--Creating Education Table.
CREATE TABLE Education(
Edu_ID INT PRIMARY KEY,
Edu_Field VARCHAR(100)
);


--Insert into Education Table.
BULK INSERT Education
FROM'D:\DBs\HR Data Analysis\New folder\Education.csv'
WITH(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2
);


--Creating Employee Data Table.
CREATE TABLE Employee_Data(
Employee_ID INT PRIMARY KEY,
Environment_Satisfaction INT,
Job_Satisfaction INT,
Work_Life_Balance INT
)
--Insert into Employee Data.
BULK INSERT Employee_Data
FROM 'D:\DBs\HR Data Analysis\New folder\Employee_Data.csv'
WITH(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2
);


--Creating Gender Table.
CREATE TABLE Gender(
Gender_ID INT PRIMARY KEY,
Gender VARCHAR(100)
)
--Insert into Gender Table.
BULK INSERT Gender
FROM 'D:\DBs\HR Data Analysis\New folder\Gender.csv'
WITH(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2
)


--Creating Job Role.
CREATE TABLE JobRole(
Role_ID INT PRIMARY KEY,
JobRole VARCHAR(100)
);
--INSERT into Job Role Table.
BULK INSERT JobRole
FROM 'D:\DBs\HR Data Analysis\New folder\JobRole.csv'
WITH(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2
);


--Creating Manager Data.
CREATE TABLE Manager_Data(
Employee_ID INT PRIMARY KEY,
Job_Involvment INT,
Performance_Rating INT
)
--Insert into Manager Data.
BULK INSERT Manager_Data
FROM'D:\DBs\HR Data Analysis\New folder\Manager_Data.csv'
WITH(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2
);


--Creating Status Table.
CREATE TABLE Status(
Status_ID INT PRIMARY KEY,
Martal_Status VARCHAR(100)
)
--Insert into Status Table.
BULK INSERT Status
FROM'D:\DBs\HR Data Analysis\New folder\Status.csv'
WITH(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2
)


--Creating general Data.
CREATE TABLE General_Data(
	Employee_ID	INT PRIMARY KEY,
	EmP_Name VARCHAR(100),	
	Age INT,	
	Attrition VARCHAR(50),	
	Business_Travel VARCHAR(100),	
	Depart_ID INT,	
	Distance_From_Home INT,
	Education INT,
	Edu_ID INT,
	Employee_Count INT,
	Gender_ID INT,
	Job_Level INT,
	Role_ID INT,
	Status_ID INT,
	Monthly_Income INT,	
	Num_Companies_Worked INT,
	Over_18 VARCHAR(50),
	Percent_Salary_Hike INT,	
	Standard_Hours INT,
	Stock_Option_Level INT,
	Total_Working_Years INT,
	Training_Times_Last_Year INT,
	Years_At_Company INT,
	Years_Since_Last_Promotion INT,
	Years_With_Current_Manager INT,
	CONSTRAINT FK_Department
FOREIGN KEY (Depart_ID) REFERENCES Department(Depart_ID),
	CONSTRAINT FK_Education
FOREIGN KEY (Edu_ID) REFERENCES [dbo].[Education](Edu_ID),
	CONSTRAINT FK_Gender
FOREIGN KEY (Gender_ID) REFERENCES Gender(Gender_ID),
	CONSTRAINT FK_Job_Role
FOREIGN KEY (Role_ID) REFERENCES JObRole(Role_ID),
	CONSTRAINT FK_Status
FOREIGN KEY (Status_ID) REFERENCES Status(Status_ID)
)


--Insert into General Data.
BULK INSERT General_Data
FROM'D:\DBs\HR Data Analysis\New folder\General_Data.csv'
WITH(
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	FIRSTROW=2,
	KEEPNULLS
)
------------------------------------------------------------------------------------------------------------------







--------------------------------------------------------------------------------------------------------


--DATA CLEANSING
-----------------




-----------------------------------------------------
--All columns in the 'department' table

select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='Department'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='department'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'department';
-----------------------------------------------------------------------------------------------------------------
--All columns in the 'Education' table

select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='Education'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Education'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'Education';
-----------------------------------------------------------------------------------------------------------------------------



select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='Employee_Data'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Employee_Data'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'Employee_Data';
-------------------------------------------------------------------------------


select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='Gender'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Gender'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'Gender';


---------------------------------------------------------------------------------------------------------------

select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='General_Data'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='General_Data'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'General_Data';
---------------------------------------------------------------------------------------------------------------


select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='JobRole'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='JobRole'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'JobRole';
------------------------------------------------------------------------


select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='Manager_Data'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Manager_Data'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'Manager_Data';
-------------------------------------------------------------------------------------------------------------------------


select column_name
from INFORMATION_SCHEMA.COLUMNS
where table_name='Status'
-----------------------------------------------------------------------------------------------------------------
--Identifying data types.

select COLUMN_NAME,DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Status'
-----------------------------------------------------------------------------------------------------------------------------
--to determine the names of constraints.

SELECT 
    tc.CONSTRAINT_NAME, 
    tc.CONSTRAINT_TYPE, 
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE tc.TABLE_NAME = 'Status';


-------------------------------------------------------------------------------

------------------------------





-
---------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------

--ATTRITION 

-- Employees Who Left the Company by Age Group

SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END AS AgeGroup, 
    COUNT(*) AS EmployeeCount
FROM general_data
WHERE Attrition = 'Yes'
GROUP BY 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END;
---------------------------------------------------------------------
--Annual Salary Increase Rate by Department for Employees Who Left	

SELECT d.Department, AVG(g.Percent_Salary_Hike) AS AverageSalaryHike
FROM general_data g
JOIN department d ON g.Depart_ID = d.Depart_ID
WHERE g.Attrition = 'Yes'
GROUP BY d.Department;
--------------------------------------------------------------------------
--Employee Count by Education Level and Field for Employees Who Left

SELECT e.Edu_Field, g.Education, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
JOIN education e ON g.Edu_ID = e.Edu_ID
WHERE g.Attrition = 'Yes'
GROUP BY e.Edu_Field, g.Education;
--------------------------------------------------------------------------
--Work-Life Balance Satisfaction by Marital Status for Employees Who Left

SELECT s.Martal_Status, AVG(e.Work_Life_Balance) AS AverageWorkLifeBalance
FROM general_data g
JOIN employee_data e ON g.Employee_ID = e.Employee_ID
JOIN status s ON g.Status_ID = s.Status_ID
WHERE g.Attrition = 'Yes'
GROUP BY s.Martal_Status;
--------------------------------------------------------------------------------
--Distribution of Employees by Number of Companies Worked for Who Left

SELECT g.Num_Companies_Worked, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
WHERE g.Attrition = 'Yes'
GROUP BY g.Num_Companies_Worked
ORDER BY g.Num_Companies_Worked;
------------------------------------------------------------------------------------
--Distribution of Employees by Job Level for Employees Who Left

SELECT g.Job_Level, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
WHERE g.Attrition = 'Yes'
GROUP BY g.Job_Level
ORDER BY g.Job_Level;
--------------------------------------------------------------------------------------
--Distribution of Employees by Gender and Marital Status for Employees Who Left

SELECT ge.Gender, s.Martal_Status, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
JOIN gender ge ON g.Gender_ID = ge.Gender_ID
JOIN status s ON g.Status_ID = s.Status_ID
WHERE g.Attrition = 'Yes'
GROUP BY ge.Gender, s.Martal_Status
ORDER BY ge.Gender, s.Martal_Status;
-----------------------------------------------------------------------------------------
--Environment Satisfaction by Job Role for Employees Who Left

SELECT j.JobRole, AVG(e.Environment_Satisfaction) AS AverageEnvironmentSatisfaction
FROM general_data g
JOIN employee_data e ON g.Employee_ID = e.Employee_ID
JOIN jobrole j ON g.Role_ID = j.Role_ID
WHERE g.Attrition = 'Yes'
GROUP BY j.JobRole;
--------------------------------------------------------------------------------------------
--Annual Training Rate by Department for Employees Who Left

SELECT d.Department, AVG(g.Training_Times_Last_Year) AS AverageTrainingTimes
FROM general_data g
JOIN Department d ON g.Depart_ID = d.Depart_ID
WHERE g.Attrition = 'Yes'
GROUP BY d.Department;
----------------------------------------------------------------------------------------------
--Monthly Income by Marital Status for Employees Who Left

SELECT s.Martal_Status, AVG(g.Monthly_Income) AS AverageMonthlyIncome
FROM general_data g
JOIN status s ON g.Status_ID = s.Status_ID
WHERE g.Attrition = 'Yes'
GROUP BY s.Martal_Status;
----------------------------------------------------------------------------------------------
--Average Years with Current Manager by Job Role for Employees Who Left

SELECT j.JobRole, AVG(g.Years_With_Current_Manager) AS AverageYearsWithCurrentManager
FROM general_data g
JOIN jobrole j ON g.Role_ID = j.Role_ID
WHERE g.Attrition = 'Yes'
GROUP BY j.JobRole;
-------------------------------------------------------------------------------------------------
--Performance Rating by Gender for Employees Who Left

SELECT ge.Gender, AVG(m.Performance_Rating) AS AveragePerformanceRating
FROM general_data g
JOIN manager_data m ON g.Employee_ID = m.Employee_ID
JOIN gender ge ON g.Gender_ID = ge.Gender_ID
WHERE g.Attrition = 'Yes'
GROUP BY ge.Gender;
----------------------------------------------------------------------------------
--Count of Employees Working More Than Standard Hours Who Left:

SELECT COUNT(g.Employee_ID) AS OverworkingEmployees
FROM general_data g
WHERE g.Attrition = 'Yes' AND g.Standard_Hours < (
    SELECT AVG(g2.Standard_Hours)
    FROM general_data g2
);
---------------------------------------------------------------------------------------
--Job Satisfaction by Distance from Home for Employees Who Left

SELECT 
    CASE 
        WHEN Distance_From_Home < 5 THEN '0-5 km'
        WHEN Distance_From_Home BETWEEN 5 AND 10 THEN '5-10 km'
        WHEN Distance_From_Home BETWEEN 10 AND 20 THEN '10-20 km'
        ELSE '20+ km'
    END AS DistanceGroup, 
    AVG(e.Job_Satisfaction) AS AverageJobSatisfaction
FROM general_data g
JOIN employee_data e ON g.Employee_ID = e.Employee_ID
WHERE g.Attrition = 'Yes'
GROUP BY 
    CASE 
        WHEN Distance_From_Home < 5 THEN '0-5 km'
        WHEN Distance_From_Home BETWEEN 5 AND 10 THEN '5-10 km'
        WHEN Distance_From_Home BETWEEN 10 AND 20 THEN '10-20 km'
        ELSE '20+ km'
    END;
------------------------------------------------------------------------
--The employee who have HIGH and LOW job satisfaction.

SELECT 
    [EmP_Name],
    CASE 
        WHEN [Job_Satisfaction] > 2 THEN 'High'
        ELSE 'Low'
    END AS Job_Satisfaction_Level
FROM
    Employee_Data E 
INNER JOIN 
    General_Data G ON E.Employee_ID = G.Employee_ID
WHERE Attrition='yes'
-----------------------------------------------------------------------------------------










---------------------------------------------------------------------------------------------
--ACTIVATION

--Employees Who Stayed by Age Group

SELECT 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END AS AgeGroup, 
    COUNT(*) AS EmployeeCount
FROM general_data
WHERE Attrition = 'No'
GROUP BY 
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END;
----------------------------------------------------------------------------------
--Annual Salary Increase Rate by Department for Employees Who Stayed

SELECT d.Department, AVG(g.Percent_Salary_Hike) AS AverageSalaryHike
FROM general_data g
JOIN Department d ON g.Depart_ID = d.Depart_ID
WHERE g.Attrition = 'No'
GROUP BY d.Department;
-----------------------------------------------------------------------------------------
--Employee Count by Education Level and Field for Employees Who Stayed

SELECT e.Edu_Field, g.Education, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
JOIN education e ON g.Edu_ID = e.Edu_ID
WHERE g.Attrition = 'No'
GROUP BY e.Edu_Field, g.Education;
---------------------------------------------------------------------------------------
--Work-Life Balance Satisfaction by Marital Status for Employees Who Stayed

SELECT s.Martal_Status, AVG(e.Work_Life_Balance) AS AverageWorkLifeBalance
FROM general_data g
JOIN employee_data e ON g.Employee_ID = e.Employee_ID
JOIN status s ON g.Status_ID = s.Status_ID
WHERE g.Attrition = 'No'
GROUP BY s.Martal_Status;
----------------------------------------------------------------------------------------------
--Distribution of Employees by Number of Companies Worked for Who Stayed

SELECT g.Num_Companies_Worked, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
WHERE g.Attrition = 'No'
GROUP BY g.Num_Companies_Worked
ORDER BY g.Num_Companies_Worked;
------------------------------------------------------------------------------------------------
--Distribution of Employees by Job Level for Employees Who Stayed

SELECT g.Job_Level, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
WHERE g.Attrition = 'No'
GROUP BY g.Job_Level
ORDER BY g.Job_Level;
--------------------------------------------------------------------------------------------------
--Distribution of Employees by Gender and Marital Status for Employees Who Stayed

SELECT ge.Gender, s.Martal_Status, COUNT(g.Employee_ID) AS EmployeeCount
FROM general_data g
JOIN gender ge ON g.Gender_ID = ge.Gender_ID
JOIN status s ON g.Status_ID = s.Status_ID
WHERE g.Attrition = 'No'
GROUP BY ge.Gender, s.Martal_Status
ORDER BY ge.Gender, s.Martal_Status;
-------------------------------------------------------------------------------------------------------
--Environment Satisfaction by Job Role for Employees Who Stayed

SELECT j.JobRole, AVG(e.Environment_Satisfaction) AS AverageEnvironmentSatisfaction
FROM general_data g
JOIN employee_data e ON g.Employee_ID = e.Employee_ID
JOIN jobrole j ON g.Role_ID = j.Role_ID
WHERE g.Attrition = 'No'
GROUP BY j.JobRole;
---------------------------------------------------------------------------------------------------------
--Annual Training Rate by Department for Employees Who Stayed

SELECT d.Department, AVG(g.Training_Times_Last_Year) AS AverageTrainingTimes
FROM general_data g
JOIN Department d ON g.Depart_ID = d.Depart_ID
WHERE g.Attrition = 'No'
GROUP BY d.Department;
------------------------------------------------------------------------------------------------------------
--Monthly Income by Marital Status for Employees Who Stayed

SELECT s.Martal_Status, AVG(g.Monthly_Income) AS AverageMonthlyIncome
FROM general_data g
JOIN status s ON g.Status_ID = s.Status_ID
WHERE g.Attrition = 'No'
GROUP BY s.Martal_Status;
------------------------------------------------------------------------------------------------------------------
--Average Years with Current Manager by Job Role for Employees Who Stayed

SELECT j.JobRole, AVG(g.Years_With_Current_Manager) AS AverageYearsWithCurrentManager
FROM general_data g
JOIN jobrole j ON g.Role_ID = j.Role_ID
WHERE g.Attrition = 'No'
GROUP BY j.JobRole;
-------------------------------------------------------------------------------------------
--Performance Rating by Gender for Employees Who Stayed

SELECT ge.Gender, AVG(m.Performance_Rating) AS AveragePerformanceRating
FROM general_data g
JOIN manager_data m ON g.Employee_ID = m.Employee_ID
JOIN gender ge ON g.Gender_ID = ge.Gender_ID
WHERE g.Attrition = 'No'
GROUP BY ge.Gender;
-------------------------------------------------------------------------------------
--Count of Employees Working More Than Standard Hours Who Stayed

SELECT COUNT(g.Employee_ID) AS OverworkingEmployees
FROM general_data g
WHERE g.Attrition = 'No' AND g.Standard_Hours < (
    SELECT AVG(g2.Standard_Hours)
    FROM general_data g2
);
--------------------------------------------------------------------------------
--Job Satisfaction by Distance from Home for Employees Who Stayed

SELECT 
    CASE 
        WHEN Distance_From_Home < 5 THEN '0-5 km'
        WHEN Distance_From_Home BETWEEN 5 AND 10 THEN '5-10 km'
        WHEN Distance_From_Home BETWEEN 10 AND 20 THEN '10-20 km'
        ELSE '20+ km'
    END AS DistanceGroup, 
    AVG(e.Job_Satisfaction) AS AverageJobSatisfaction
FROM general_data g
JOIN employee_data e ON g.Employee_ID = e.Employee_ID
WHERE g.Attrition = 'No'
GROUP BY 
    CASE 
        WHEN Distance_From_Home < 5 THEN '0-5 km'
        WHEN Distance_From_Home BETWEEN 5 AND 10 THEN '5-10 km'
        WHEN Distance_From_Home BETWEEN 10 AND 20 THEN '10-20 km'
        ELSE '20+ km'
    END;
-------------------------------------------------------------------------------------------
--The employee who have HIGH and LOW job satisfaction.

SELECT 
    [EmP_Name],
    CASE 
        WHEN [Job_Satisfaction] > 2 THEN 'High'
        ELSE 'Low'
    END AS Job_Satisfaction_Level
FROM
    Employee_Data E 
INNER JOIN 
    General_Data G ON E.Employee_ID = G.Employee_ID
WHERE Attrition='yes'
---------------------------------------------------------------------------------
--The highest monthly income.

SELECT EmP_Name, Monthly_Income, Attrition
FROM general_data
WHERE Monthly_Income = (
    SELECT MAX(Monthly_Income)
    FROM general_data
);
