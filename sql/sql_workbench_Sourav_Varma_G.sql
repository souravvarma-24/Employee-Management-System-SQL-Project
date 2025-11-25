CREATE DATABASE EmployeeDB;
USE EmployeeDB;

-- 1. JobDepartment
CREATE TABLE JobDepartment (
    JobID INT PRIMARY KEY,
    JobDept VARCHAR(50),
    Name VARCHAR(100),
    Description TEXT,
    SalaryRange VARCHAR(50)
);

-- 2. Salary_Bonus
CREATE TABLE Salary_Bonus (
    SalaryID INT PRIMARY KEY,
    JobID INT,
    Amount DECIMAL(10,2),
    Annual DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    FOREIGN KEY (JobID) REFERENCES JobDepartment(JobID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3. Employee
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    ContactAddress VARCHAR(100),
    EmpEmail VARCHAR(100) UNIQUE,
    EmpPass VARCHAR(50),
    JobID INT,
    FOREIGN KEY (JobID) REFERENCES JobDepartment(JobID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- 4. Qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    EmpID INT,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 5. Leaves
CREATE TABLE Leaves (
    LeaveID INT PRIMARY KEY,
    EmpID INT,
    Date DATE,
    Reason TEXT,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. Payroll
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmpID INT,
    JobID INT,
    SalaryID INT,
    LeaveID INT,
    Date DATE,
    Report TEXT,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (JobID) REFERENCES JobDepartment(JobID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SalaryID) REFERENCES Salary_Bonus(SalaryID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (LeaveID) REFERENCES Leaves(LeaveID)
        ON DELETE SET NULL ON UPDATE CASCADE
);

SELECT * FROM JobDepartment;
SELECT * FROM SalaryBonus;
SELECT * FROM Employee;
SELECT * FROM Qualification;
SELECT * FROM leaves;
SELECT * FROM Payroll;


-- 1.EMPLOYEE INSIGHTS : 

-- 1) How many unique employees are currently in the system?
SELECT COUNT(DISTINCT EmpID) AS unique_employees
FROM Employee;

-- 2) Which departments have the highest number of employees?
SELECT jd.JobDept as Department,
       COUNT(e.EmpID) AS highest_num_employees
FROM JobDepartment jd
LEFT JOIN Employee e ON jd.JobID = e.JobID
GROUP BY Department
ORDER BY highest_num_employees DESC;

-- 3) What is the average salary per department?
SELECT jd.JobDept AS department,
       ROUND(AVG(sb.Amount), 2) AS avg_salary
FROM JobDepartment jd
LEFT JOIN Salary_Bonus sb ON jd.JobID = sb.JobID
GROUP BY jd.JobDept
ORDER BY avg_salary DESC;

-- 4) Who are the top 5 highest-paid employees?
SELECT e.EmpID,
       e.FirstName,
       e.LastName,
       sb.Amount AS highest_paid_salary
FROM Employee e
JOIN Salary_Bonus sb ON e.JobID = sb.JobID
ORDER BY sb.Amount DESC
LIMIT 5;

-- 5) What is the total salary expenditure across the company?
SELECT SUM(Amount) AS total_salary_expenditure
FROM Salary_Bonus;


-- 2. JOB ROLE AND DEPARTMENT ANALYSIS : 

-- 6) How many different job roles exist in each department? 
SELECT JobDept as Department,
       COUNT(JobID) AS job_roles_exist
FROM JobDepartment
GROUP BY Department
ORDER BY job_roles_exist DESC;

-- 7) What is the average salary range per department?
SELECT 
    jd.jobdept AS department,
     ROUND(AVG(
        (
            CAST(REPLACE(REPLACE(SUBSTRING_INDEX(jd.salaryrange, '-', 1), '$', ''), ',', '') AS UNSIGNED) +
            CAST(REPLACE(REPLACE(SUBSTRING_INDEX(jd.salaryrange, '-', -1), '$', ''), ',', '') AS UNSIGNED)
        ) / 2
  ), 2) AS avg_salary_range
FROM JobDepartment jd
GROUP BY jd.jobdept
ORDER BY avg_salary_range DESC;

-- 8) Which job roles offer the highest salary?
SELECT jd.Name AS job_role,
       jd.JobDept,
       sb.Amount
FROM JobDepartment jd
JOIN Salary_Bonus sb ON jd.JobID = sb.JobID
ORDER BY sb.Amount DESC
LIMIT 1;

-- 9) Which departments have the highest total salary allocation?
SELECT jd.JobDept as Department,
       ROUND(SUM(sb.Amount), 2) AS highest_total_salary_allocation
FROM `JobDepartment` jd
JOIN `Salary_Bonus` sb ON jd.JobID = sb.JobID
GROUP BY Department
ORDER BY highest_total_salary_allocation DESC;


-- 3. QUALIFICATION AND SKILLS ANALYSIS : 

-- 10)How many employees have at least one qualification listed?
SELECT COUNT(DISTINCT EmpID) AS atleast_1_qualification
FROM `Qualification`;

-- 11) Which positions require the most qualifications?
SELECT Position,
       COUNT(*) AS most_qualifications
FROM `Qualification`
GROUP BY Position
ORDER BY most_qualifications DESC;

-- 12) Which employees have the highest number of qualifications?
SELECT e.EmpID,
       e.FirstName,
       e.LastName,
       COUNT(q.QualID) AS highest_no_of_qualifications
FROM Employee e
JOIN Qualification q ON e.EmpID = q.EmpID
GROUP BY e.EmpID, e.FirstName, e.LastName
ORDER BY highest_no_of_qualifications DESC;

-- 4. LEAVE AND ABSENCE PATTERNS : 

-- 13) Which year had the most employees taking leaves?
SELECT YEAR(date) AS year, COUNT(*) AS employees_taking_leaves
FROM Leaves
GROUP BY YEAR(date)
ORDER BY employees_taking_leaves DESC;

-- 14) What is the average number of leave days taken by its employees per department?
SELECT jd.JobDept as Department,
       COUNT(l.LeaveID) AS avg_leave_days
FROM Leaves l
JOIN Employee e ON l.EmpID = e.EmpID
JOIN JobDepartment jd ON e.JobID = jd.JobID
GROUP BY Department
ORDER BY avg_leave_days DESC;

-- 15) Which employees have taken the most leaves?
SELECT e.EmpID,
       CONCAT(e.FirstName, ' ', e.LastName) AS employee_name,
       COUNT(l.LeaveID) AS total_leaves
FROM Leaves l
JOIN Employee e ON l.EmpID = e.EmpID
GROUP BY e.EmpID, employee_name
ORDER BY total_leaves DESC;

-- 16) What is the total number of leave days taken company-wide?
SELECT jd.JobDept,
       COUNT(l.LeaveID) AS total_leave_days
FROM Leaves l
JOIN Employee e ON l.EmpID = e.EmpID
JOIN JobDepartment jd ON e.JobID = jd.JobID
GROUP BY jd.JobDept
ORDER BY total_leave_days DESC;

-- 17) How do leave days correlate with payroll amounts?
SELECT 
    e.EmpID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    COUNT(l.LeaveID) AS TotalLeaves,
    SUM(p.TotalAmount) AS TotalPayroll FROM Employee e
LEFT JOIN Leaves l 
    ON e.EmpID = l.EmpID
LEFT JOIN Payroll p 
    ON e.EmpID = p.EmpID
GROUP BY e.EmpID, EmployeeName
ORDER BY TotalLeaves DESC;
-- 5. PAYROLL AND COMPENSATION ANALYSIS : 

-- 18) What is the total monthly payroll processed?
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    SUM(TotalAmount) AS total_monthly_payroll
FROM Payroll
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year, month;

-- 19) What is the average bonus given per department?
SELECT 
    jd.JobDept AS department,
    ROUND(AVG(sb.Bonus), 2) AS avg_bonus
FROM JobDepartment jd
JOIN Salary_Bonus sb 
    ON jd.JobID = sb.JobID
GROUP BY jd.JobDept
ORDER BY avg_bonus DESC;

-- 20) Which department receives the highest total bonuses?
SELECT 
    jd.JobDept AS department,
    SUM(sb.Bonus) AS highest_bonus
FROM Salary_Bonus sb
JOIN JobDepartment jd 
    ON sb.JobID = jd.JobID
GROUP BY jd.JobDept
ORDER BY highest_bonus DESC
LIMIT 1;

-- 21) What is the average value of total_amount after considering leave deductions?
SELECT 
    jd.JobDept,
    ROUND(AVG(p.TotalAmount), 2) AS Avg_Net_Payroll
FROM Payroll p
JOIN JobDepartment jd ON p.JobID = jd.JobID
GROUP BY jd.JobDept
ORDER BY Avg_Net_Payroll DESC;














