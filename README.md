# Employee-Management-System-Using-SQL

This project demonstrates how SQL can be used to design, maintain, and analyze a complete Employee Management System (EMS).  
It provides a clean relational database structure used to manage employees, departments, salaries, bonuses, leaves, qualifications, and payroll effectively.

---

## 🚀 Project Objectives

The primary objective of this project is to build a well-structured SQL database that supports real-world HR operations.

### ✔ Key Goals

- **Organize Employee Information** – Centralized employee records  
- **Department & Job Role Management** – Roles, departments, reporting structure  
- **Salary & Bonus Tracking** – Salary, annual increments, bonus payouts  
- **Leave Management** – Leave approvals, tracking, usage patterns  
- **Qualification Mapping** – Skill and educational information  
- **Payroll Processing** – Salary + bonus − leave deductions  
- **Insight Generation** – HR & management analytics for decisions  

---

## 🗂 Database Schema Overview

The EMS is structured with the following relational tables:

| Table Name     | Description |
|----------------|-------------|
| employee       | Contains employee personal and professional details |
| department     | Stores department names and managers |
| salaries       | Tracks base salaries, increments, and pay grades |
| bonuses        | Stores performance bonuses and incentives |
| leaves         | Tracks employee leave history |
| qualifications | Contains educational qualifications and skill data |
| payroll        | Combines salary, bonus, and leave deductions |

---

## 🖼 ER Diagram  
The complete ER diagram of the system is included in the repository.

📌 **Path:**  
`EMS_Reports/ERDiagram.png`

---

## 📁 Folder Structure

```
EMS_Datasets/
 ├── Employee.csv
 ├── JobDepartment.csv
 ├── Salary_Bonus.csv
 ├── Qualification.csv
 ├── Leaves.csv
 └── Payroll.csv

EMS_WorkBench/
 ├── SQL_WORKBENCH_Sourav_Varma_Gottumukkala.sql

EMS_Reports/
 └── SQL_PPT_Sourav_Varma_Gottumukkala.pptx

README.md
```

---

## 📊 Analysis & Business Insights

This project includes HR-driven analytical SQL queries.

### 👥 Employee Insights
- Highest earners (salary + bonus)  
- Employees taking the highest number of leaves  
- Qualification-based employee filtering  
- Per-department employee distribution  

### 💰 Salary & Bonus Insights
- Highest bonus recipients  
- Annual salary increment trends  
- Salary comparison across departments  
- Role-based salary analysis  

### 📅 Leave Insights
- Frequent leave takers  
- Monthly/annual leave patterns  
- Department-wise leave breakdown  

### 🏢 Department Insights
- Most populated departments  
- High-cost departments (salary + bonus)  
- Department performance metrics  

### 📑 Payroll Insights
- Total payroll processed  
- Payroll after deductions  
- Bonus contribution to total payroll  

---

## ⭐ Key Recommendations

### 1️⃣ Optimize Bonus Distribution
Bonus amounts vary significantly across departments; standardization recommended.

### 2️⃣ Reduce Excessive Leave Usage
Some employees show high leave frequency — revise HR policies where needed.

### 3️⃣ Invest in Employee Upskilling
Highly qualified employees contribute more effectively.

### 4️⃣ Balance Department Workload
Uneven employee distribution affects productivity.

### 5️⃣ Improve Salary Structure
Salary variations across the same roles indicate restructuring opportunities.


---


## ▶️ How to Run the Project

### **Step 1 — Import CSV Datasets**
Import each CSV into its respective table:

| CSV File | Table Name |
|----------|------------|
| Employee.csv | Employee |
| JobDepartment.csv | JobDepartment |
| Salary_Bonus.csv | Salary_Bonus |
| Qualification.csv | Qualification |
| Leaves.csv | Leaves |
| Payroll.csv | Payroll |

### **Step 2 — Run the SQL Script**

Execute this file in MySQL Workbench:

```
EMS_WorkBench/SQL_WORKBENCH_Sourav_Varma_Gottumukkala.sql
```

### **Step 3 — View Reports & Presentation**

Open the final project PPT:

```
EMS_Reports/SQL_PPT_Sourav_Varma_Gottumukkala.pptx
```

---


## 🛠 Technologies Used

- MySQL / SQL  
- MySQL Workbench  
- ER Diagram Design  
- Git & GitHub  

---


## 🧠 Challenges Faced

- Designing a normalized multi-table schema  
- Ensuring foreign key consistency  
- Handling complex JOIN operations for payroll  
- Automating leave → payroll deductions  
- Maintaining clean & scalable database structure  

---

## 📘 SQL Concepts Covered

- Primary & Foreign Keys  
- Data Normalization (1NF, 2NF, 3NF)  
- Joins (INNER, LEFT, RIGHT, FULL)  
- GROUP BY, HAVING & Aggregations  
- Views, Constraints & Relationships  
- Subquery Optimization  
- ER Modeling  

---

## 📝 Conclusion

This Employee Management System (EMS) project enhances how a well-designed SQL database can transform HR operations by enabling structured data storage, seamless process automation, and rich analytical insights.  
By integrating employee information, salary structures, bonuses, leave data, and payroll calculations into a unified relational model, organizations can achieve:

- Better workforce planning  
- Transparent and fair compensation management  
- Accurate payroll processing  
- Clear visibility into employee behavior and performance  
- Data-driven HR decisions that improve efficiency and reduce operational overhead  

This project serves as a complete end-to-end SQL solution, showcasing real-world database design, optimization, and analytical capability — making it a valuable portfolio project for Data Analysts, Data Scientists, and SQL Developers.

---

⭐ **Thank you for exploring this project — your feedback and contributions are always welcome!**
