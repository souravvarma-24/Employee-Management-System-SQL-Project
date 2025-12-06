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

A detailed Entity-Relationship Diagram representing table relationships.

📌 **Path:**  
`sql/assets/ERDiagram.png`

---

## 📁 Folder Structure

```
datasets/
 ├── Bonuses.csv
 ├── Departments.csv
 ├── Employees.csv
 ├── Leaves.csv
 ├── Qualifications.csv
 └── Salaries.csv

sql/
 ├── 1_create_tables.sql
 ├── 2_insert_data.sql
 ├── 3_analysis_queries.sql
 ├── sql_workbench_Sourav_Varma_G.sql
 └── assets/
       └── ERDiagram.png

reports/
 └── sql_ppt_Sourav_Varma_G.pptx

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

## 🛠 Technologies Used

- MySQL / SQL  
- MySQL Workbench  
- ER Diagram Design  
- Git & GitHub  

---

## ▶️ How to Run This Project

### **Step 1 — Clone or Download the Repository**
```
git clone https://github.com/yourusername/Employee-Management-System-SQL-Project.git
```

### **Step 2 — Open MySQL Workbench**

### **Step 3 — Run the SQL Scripts**



## 📘Create tables:
```
sql/1_create_tables.sql
```

Insert data:
```
sql/2_insert_data.sql
```

Run analysis:
```
sql/3_analysis_queries.sql
```

Or run the full script:
```
sql/sql_workbench_Sourav_Varma_G.sql
```

### **Step 4 — View the ER Diagram**
```
sql/assets/ERDiagram.png
```

### **Step 5 — Open the Presentation**
```
reports/sql_ppt_Sourav_Varma_G.pptx
```

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
