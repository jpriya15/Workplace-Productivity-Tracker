-- Query 1: Productive Days
SELECT `Employee_Id`, `Allocated_Days`, `Completed_In_Days`, 
       (`Allocated_Days` - `Completed_In_Days`) AS Productive_Days 
FROM employees_fixed
WHERE `Allocated_Days` > `Completed_In_Days`;

-- Query 2: Employee Performance
SELECT `Employee_Id`, `Allocated_Days`, `Completed_In_Days`, `Appraisal_Cycles` AS Employee_Performance
FROM employees_fixed
WHERE `Appraisal_Cycles` >= 10;

-- Query 3: Productive Hours Per Employee
SELECT 
  `Employee_Id`,
  ROUND(TIMESTAMPDIFF(SECOND, `Login_Time`, `Logout_Time`) / 3600.0, 2) AS Productive_Hours_Per_Employee
FROM employees_fixed;

-- Query 4: Project Productive Hours
SELECT 
  `Project_Id`,
  ROUND(SUM(TIMESTAMPDIFF(SECOND, `Login_Time`, `Logout_Time`)) / 3600.0, 2) AS project_productive_hours
FROM employees_fixed
WHERE `Logout_Time` > `Login_Time`
GROUP BY `Project_Id`
ORDER BY `Project_Id`;

-- Query 5: Bench Days
SELECT `Employee_Id`, 
       DATEDIFF(`Start_Date`, `Joining_Date`) AS bench_days
FROM employees_fixed
WHERE `Joining_Date` < `Start_Date`;