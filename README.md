# Workplace Productivity Analytics Dashboard
### Power BI | SQL | MySQL | Workforce Analytics

---

## Project Overview

This project analyzes employee-level productivity and project efficiency data to help managers make informed decisions around workforce utilization, bench management, and performance tracking.

The analysis was built end-to-end — starting from **raw SQL queries** to extract and transform data, followed by **Power BI visualizations** to communicate insights clearly.

**Tools Used:** MySQL, Power BI, DAX, Excel  
**Dataset:** 201 employee records 
**Domain:** Workforce Analytics 

---

## Dataset Description

The dataset contains employee-level information covering project assignments, work hours, joining details, and appraisal history.

| Column | Description |
| :--- | :--- |
| Employee_Name | Name of the employee |
| Employee_Id | Unique employee identifier |
| Project_Id | Project assigned to the employee |
| Start_Date | Project start date |
| End_Date | Project end date |
| Allocated_Days | Days allocated to complete the project |
| Completed_In_Days | Actual days taken to complete |
| Login_Time | Daily login time |
| Logout_Time | Daily logout time |
| Joining_Date | Date employee joined the organization |
| Appraisal_Cycles | Number of appraisal cycles completed |

---

## SQL Queries Written

### Query 1 — Productive Days Per Employee
Identifies employees who completed their projects ahead of schedule.
```sql
SELECT `Employee_Id`, `Allocated_Days`, `Completed_In_Days`, 
       (`Allocated_Days` - `Completed_In_Days`) AS Productive_Days 
FROM employees_fixed
WHERE `Allocated_Days` > `Completed_In_Days`;
```

### Query 2 — High Performing Employees
Filters employees with 10 or more appraisal cycles as high performers.
```sql
SELECT `Employee_Id`, `Allocated_Days`, `Completed_In_Days`, 
       `Appraisal_Cycles` AS Employee_Performance
FROM employees_fixed
WHERE `Appraisal_Cycles` >= 10;
```

### Query 3 — Productive Hours Per Employee
Calculates actual hours worked per employee using login/logout timestamps.
```sql
SELECT 
  `Employee_Id`,
  ROUND(TIMESTAMPDIFF(SECOND, `Login_Time`, `Logout_Time`) / 3600.0, 2) 
  AS Productive_Hours_Per_Employee
FROM employees_fixed;
```
> Used TIMESTAMPDIFF in SECOND for precision before converting to hours.

### Query 4 — Project Productive Hours
Aggregates total hours spent per project, filtering out data quality issues.
```sql
SELECT 
  `Project_Id`,
  ROUND(SUM(TIMESTAMPDIFF(SECOND, `Login_Time`, `Logout_Time`)) / 3600.0, 2) 
  AS project_productive_hours
FROM employees_fixed
WHERE `Logout_Time` > `Login_Time`
GROUP BY `Project_Id`
ORDER BY `Project_Id`;
```
> WHERE clause filters rows where logout is before login to handle bad data.

### Query 5 — Bench Period Per Employee
Calculates the number of idle days between joining date and project start date.
```sql
SELECT `Employee_Id`, 
       DATEDIFF(`Start_Date`, `Joining_Date`) AS bench_days
FROM employees_fixed
WHERE `Joining_Date` < `Start_Date`;
```

---

## Dashboard Page

### Page 1: Employee Productivity Overview
Single-page dashboard covering all key productivity metrics.

**Visuals Built:**
- **Clustered Column Chart** — Productive Days Per Employee
- **Line Chart** — Hours Spent Per Employee
- **Card** — Hours Spent per Project
- **Column Chart** — Bench Period per Employee
- **Table** — Employee Performance based on Appraisal Cycle
- **Pie Chart** — Average Employee Performance (DAX measure)
- **Donut Chart** — Average Hours Per Project (DAX measure)

---

## Business Insights

- **Nearly equal split** between employees who finished early and 
  those who were overdue — suggesting project timeline estimation 
  needs improvement

- **Data quality issue identified** — some records had logout before 
  login time, which was handled via a WHERE clause filter in SQL 
  before calculating project hours

- **Appraisal cycles vary widely** across employees — ranging from 0 
  to 19 cycles — indicating inconsistent performance review practices 
  across the organization
  
## Business Recommendations

- **Improve project timeline estimation** — a large portion of 
  employees ran overdue, suggesting allocated days need to be 
  recalibrated based on historical completion patterns

- **Reduce bench period** — employees are sitting idle for several 
  months before project assignment; faster allocation processes 
  would reduce unnecessary costs

  
## Repository Structure

```
├── employees_fixed.csv          # Raw dataset
├── Employee_Query.sql           # SQL queries for metric extraction
├── Employee_Project_Report.pbix # Power BI dashboard file
└── README.md                    # Project documentation
```

---

## Author

**Josyula Sai Krishna Priya**  
Data Analyst | Power BI | SQL | Python  
jskp2001@gmail.com  
https://jpriya15.github.io/jpriya15.github.io.portfolio-/

---

*This is a portfolio project built to demonstrate end-to-end data analytics capabilities using SQL and Power BI.*
