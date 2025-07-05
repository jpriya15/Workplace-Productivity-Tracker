select "Employee_Id", "Allocated_Days", "Completed_In_Days", ("Allocated_Days" - "Completed_In_Days") as Productive_Days 
from public.employees
where "Allocated_Days" > "Completed_In_Days";

select "Employee_Id", "Allocated_Days", "Completed_In_Days", "Appraisal_Cycles" as Employee_Performance
from public.employees
where  "Appraisal_Cycles" >= 10;

SELECT 
  "Employee_Id",
  CASE 
    WHEN "Logout_Time" <= "Login_Time" THEN round(EXTRACT(EPOCH FROM ("Login_Time" - "Logout_Time")) / 3600.0,2)
    ELSE round(EXTRACT(EPOCH FROM ("Login_Time" - "Logout_Time")) / 3600.0,2)
  END AS productive_Hours_Per_Employee 
FROM 
  public.employees;

SELECT 
  "Project_Id",
  ROUND(SUM(EXTRACT(EPOCH FROM ("Logout_Time" - "Login_Time"))) / 3600.0, 2) AS project_productive_hours
FROM 
  public.employees
WHERE 
  "Logout_Time" > "Login_Time"
GROUP BY 
  "Project_Id"
 order by "Project_Id";

SELECT "Employee_Id", ("Start_Date" - "Joining_Date") as "bench_days"
from public.employees
where "Joining_Date" < "Start_Date"
