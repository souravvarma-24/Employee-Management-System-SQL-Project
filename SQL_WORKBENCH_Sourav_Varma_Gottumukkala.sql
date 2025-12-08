/* -----------------------------------------------------------
   EMPLOYEE MANAGEMENT SYSTEM
   Developer: Sourav Varma G
------------------------------------------------------------ */
CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;


/* -----------------------------------------------------------
   1. JobDepartment Table
------------------------------------------------------------ */
CREATE TABLE IF NOT EXISTS JobDepartment (
    JobID INT PRIMARY KEY,
    JobDept VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    SalaryRange VARCHAR(100)
);


/* -----------------------------------------------------------
   2. Salary_Bonus Table
------------------------------------------------------------ */
CREATE TABLE IF NOT EXISTS Salary_Bonus (
    SalaryID INT PRIMARY KEY,
    JobID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Annual DECIMAL(10,2),
    Bonus DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (JobID) REFERENCES JobDepartment(JobID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


/* -----------------------------------------------------------
   3. Employee Table
------------------------------------------------------------ */
CREATE TABLE IF NOT EXISTS Employee (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Age INT NOT NULL,
    ContactAddress VARCHAR(150),
    EmpEmail VARCHAR(100) UNIQUE,
    EmpPass VARCHAR(255),
    JobID INT,
    FOREIGN KEY (JobID) REFERENCES JobDepartment(JobID)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);


/* -----------------------------------------------------------
   4. Qualification Table
------------------------------------------------------------ */
CREATE TABLE IF NOT EXISTS Qualification (
    QualID INT PRIMARY KEY,
    EmpID INT NOT NULL,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


/* -----------------------------------------------------------
   5. Leaves Table
------------------------------------------------------------ */
CREATE TABLE IF NOT EXISTS Leaves (
    LeaveID INT PRIMARY KEY,
    EmpID INT NOT NULL,
    LeaveDate DATE,
    Reason TEXT,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


/* -----------------------------------------------------------
   6. Payroll Table
------------------------------------------------------------ */
CREATE TABLE IF NOT EXISTS Payroll (
    PayrollID INT PRIMARY KEY,
    EmpID INT NOT NULL,
    JobID INT NOT NULL,
    SalaryID INT NOT NULL,
    LeaveID INT,
    PayrollDate DATE,
    Report TEXT,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (JobID) REFERENCES JobDepartment(JobID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (SalaryID) REFERENCES Salary_Bonus(SalaryID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (LeaveID) REFERENCES Leaves(LeaveID)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);


/* -----------------------------------------------------------
   DATA VALIDATION QUERIES
------------------------------------------------------------ */
SELECT * FROM JobDepartment;
SELECT * FROM Salary_Bonus;
SELECT * FROM Employee;
SELECT * FROM Qualification;
SELECT * FROM Leaves;
SELECT * FROM Payroll;


/* -----------------------------------------------------------
   ANALYTICAL QUERIES
------------------------------------------------------------ */

-------------------------------
-- 1. EMPLOYEE INSIGHTS
-------------------------------

-- 1) Unique employees
SELECT COUNT(DISTINCT EmpID) AS unique_employees
FROM Employee;

-- 2) Employees per department
SELECT jd.JobDept AS Department,
       COUNT(e.EmpID) AS highest_num_employees
FROM JobDepartment jd
LEFT JOIN Employee e ON jd.JobID = e.JobID
GROUP BY Department
ORDER BY highest_num_employees DESC;

-- 3) Average salary per department
SELECT jd.JobDept AS Department,
       ROUND(AVG(sb.Amount), 2) AS avg_salary
FROM JobDepartment jd
LEFT JOIN Salary_Bonus sb ON jd.JobID = sb.JobID
GROUP BY jd.JobDept
ORDER BY avg_salary DESC;

-- 4) Top 5 highest-paid employees
SELECT e.EmpID, e.FirstName, e.LastName, sb.Amount AS highest_paid_salary
FROM Employee e
JOIN Salary_Bonus sb ON e.JobID = sb.JobID
ORDER BY sb.Amount DESC
LIMIT 5;

-- 5) Total salary expenditure
SELECT SUM(Amount) AS total_salary_expenditure
FROM Salary_Bonus;


-------------------------------
-- 2. JOB ROLE & DEPARTMENT ANALYSIS
-------------------------------

-- 6) Job roles count per department
SELECT JobDept AS Department,
       COUNT(JobID) AS job_roles_exist
FROM JobDepartment
GROUP BY Department
ORDER BY job_roles_exist DESC;

-- 7) Avg salary range per department
SELECT 
    jd.JobDept AS Department,
    ROUND(AVG((
        CAST(REPLACE(REPLACE(SUBSTRING_INDEX(jd.SalaryRange, '-', 1), '$', ''), ',', '') AS UNSIGNED) +
        CAST(REPLACE(REPLACE(SUBSTRING_INDEX(jd.SalaryRange, '-', -1), '$', ''), ',', '') AS UNSIGNED)
    )/2), 2) AS avg_salary_range
FROM JobDepartment jd
GROUP BY jd.JobDept
ORDER BY avg_salary_range DESC;

-- 8) Highest salary job role
SELECT jd.Name AS JobRole,
       jd.JobDept,
       sb.Amount
FROM JobDepartment jd
JOIN Salary_Bonus sb ON jd.JobID = sb.JobID
ORDER BY sb.Amount DESC
LIMIT 1;

-- 9) Highest salary allocation by department
SELECT jd.JobDept AS Department,
       ROUND(SUM(sb.Amount), 2) AS highest_total_salary_allocation
FROM JobDepartment jd
JOIN Salary_Bonus sb ON jd.JobID = sb.JobID
GROUP BY Department
ORDER BY highest_total_salary_allocation DESC;


-------------------------------
-- 3. QUALIFICATION ANALYSIS
-------------------------------

-- 10) Employees with at least one qualification
SELECT COUNT(DISTINCT EmpID) AS atleast_1_qualification
FROM Qualification;

-- 11) Positions requiring most qualifications
SELECT Position,
       COUNT(*) AS most_qualifications
FROM Qualification
GROUP BY Position
ORDER BY most_qualifications DESC;

-- 12) Employees with most qualifications
SELECT e.EmpID, e.FirstName, e.LastName,
       COUNT(q.QualID) AS highest_no_of_qualifications
FROM Employee e
JOIN Qualification q ON e.EmpID = q.EmpID
GROUP BY e.EmpID, e.FirstName, e.LastName
ORDER BY highest_no_of_qualifications DESC;


-------------------------------
-- 4. LEAVE ANALYSIS
-------------------------------

-- 13) Year with most leaves
SELECT YEAR(LeaveDate) AS Year,
       COUNT(*) AS employees_taking_leaves
FROM Leaves
GROUP BY YEAR(LeaveDate)
ORDER BY employees_taking_leaves DESC;

-- 14) Avg leave days per department
SELECT 
    jd.JobDept AS Department,
    ROUND(COUNT(l.LeaveID) / COUNT(DISTINCT e.EmpID), 2) AS avg_leave_days
FROM Leaves l
JOIN Employee e ON l.EmpID = e.EmpID
JOIN JobDepartment jd ON e.JobID = jd.JobID
GROUP BY jd.JobDept
ORDER BY avg_leave_days DESC;

-- 15) Employees with most leaves
SELECT e.EmpID,
       CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       COUNT(l.LeaveID) AS total_leaves
FROM Leaves l
JOIN Employee e ON l.EmpID = e.EmpID
GROUP BY e.EmpID, EmployeeName
ORDER BY total_leaves DESC;

-- 16) Total leave days per department
SELECT jd.JobDept,
       COUNT(l.LeaveID) AS total_leave_days
FROM Leaves l
JOIN Employee e ON l.EmpID = e.EmpID
JOIN JobDepartment jd ON e.JobID = jd.JobID
GROUP BY jd.JobDept
ORDER BY total_leave_days DESC;

-- 17) Leave vs Payroll correlation
SELECT 
    e.EmpID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    COUNT(l.LeaveID) AS TotalLeaves,
    SUM(p.TotalAmount) AS TotalPayroll
FROM Employee e
LEFT JOIN Leaves l ON e.EmpID = l.EmpID
LEFT JOIN Payroll p ON e.EmpID = p.EmpID
GROUP BY e.EmpID, EmployeeName
ORDER BY TotalLeaves DESC;


-------------------------------
-- 5. PAYROLL ANALYSIS
-------------------------------

-- 18) Monthly payroll processed
SELECT YEAR(PayrollDate) AS Year, MONTH(PayrollDate) AS Month,
       SUM(TotalAmount) AS total_monthly_payroll
FROM Payroll
GROUP BY Year, Month
ORDER BY Year, Month;

-- 19) Average bonus per department
SELECT jd.JobDept AS Department,
       ROUND(AVG(sb.Bonus), 2) AS avg_bonus
FROM JobDepartment jd
JOIN Salary_Bonus sb ON jd.JobID = sb.JobID
GROUP BY jd.JobDept
ORDER BY avg_bonus DESC;

-- 20) Department receiving highest total bonuses
SELECT jd.JobDept AS Department,
       SUM(sb.Bonus) AS highest_bonus
FROM Salary_Bonus sb
JOIN JobDepartment jd ON sb.JobID = jd.JobID
GROUP BY jd.JobDept
ORDER BY highest_bonus DESC
LIMIT 1;

-- 21) Average payroll after deductions
SELECT jd.JobDept,
       ROUND(AVG(p.TotalAmount), 2) AS Avg_Net_Payroll
FROM Payroll p
JOIN JobDepartment jd ON p.JobID = jd.JobID
GROUP BY jd.JobDept
ORDER BY Avg_Net_Payroll DESC;

