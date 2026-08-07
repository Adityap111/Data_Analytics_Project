# 📊 Insurance Analytics — Data Analyst Portfolio Project

**End-to-end insurance analytics project using Excel, SQL, Tableau & Power BI**

![Excel](https://img.shields.io/badge/Excel-Analysis-green)
![MySQL](https://img.shields.io/badge/MySQL-SQL-blue)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-orange)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)

---

## 🔎 At a Glance

| | |
|---|---|
| **Domain** | Insurance Analytics |
| **Focus Areas** | Policies · Customers · Claims |
| **Tools** | Excel · MySQL · Tableau · Power BI |
| **Analysis Type** | Business Intelligence · Exploratory Analysis · KPI Analysis |
| **Deliverables** | SQL Analysis · Excel Dashboard · Tableau Dashboard · Power BI Dashboard |

---

## 💼 Business Objective

Analyze insurance data to identify opportunities for **revenue growth, customer retention, policy renewal, premium collection, and claims optimization**.

The project addresses key business questions:

- Which policy types attract the most customers and generate premium revenue?
- Which customer segments contribute the most value?
- What patterns exist in policy renewals and expirations?
- Where are opportunities to improve premium collection?
- What patterns exist across claim status, claim amount, and risk bands?
- How can customer targeting and retention be improved?

---

# 📈 Dashboard Preview

### Power BI

![Power BI Dashboard](Images/PowerBI%20Dashboard.png)

### Tableau

![Tableau Dashboard](Images/Tableau%20Dashboard.png)

### Excel

![Excel Dashboard](Images/Excel%20Dashboard.png)

---

# 📊 Key Business Insights

## 💰 Policy Performance

- **~$5.26M** total premium collected
- **~5,000** policies analyzed
- Health policies attract the highest number of customers
- Q4 contributes a significant share of premium collection
- Only **~27%** of premiums have been cleared
- Policy renewal rate is currently **~33%**
- **453 policies** are approaching expiry

## 👥 Customer Behavior

- **3,148 customers** analyzed
- **~44%** of customers are currently active
- **~41%** of customers have multiple policies
- Customers aged **>50** account for approximately **51% of policy counts**
- The >50 age group contributes approximately **$2.6M** in premiums
- Average customer tenure is approximately **6.62 years**

## 🏥 Claims Performance

- **~$251.38M** total claim amount
- **~5,000** claims analyzed
- **34.24%** of claims were approved
- **~$85.79M** paid to customers
- Average claim processing time: **~50.12 days**
- **~32%** of claims are pending
- Low-risk customers show relatively high claim amounts and require further investigation

---

# 🎯 Business Recommendations

### 1. Improve Policy Renewals
Target customers approaching expiry with personalized renewal campaigns.

### 2. Increase Premium Collection
Investigate outstanding premiums and develop targeted payment follow-up strategies.

### 3. Target High-Value Customers
Use customer segmentation to identify customers with high premium contribution and develop personalized offers.

### 4. Improve Customer Retention
Use multiple-policy behavior and customer segmentation to identify cross-selling and retention opportunities.

### 5. Optimize Claims Processing
Investigate operational bottlenecks contributing to the approximately 50-day average claim processing time.

### 6. Investigate High Claims in Low-Risk Segments
Further analyze low-risk customers with high claim amounts to identify possible pricing, underwriting, or other business issues.

---

# 🛠️ Technical Implementation

## Excel

Used for initial data analysis and dashboard development.

**Techniques:**

`Data Cleaning` · `Data Transformation` · `Pivot Tables` · `VLOOKUP/XLOOKUP` · `Charts` · `KPI Analysis`

📂 [View Excel Dashboard](Excel_Dashboard/Insurance%20Analytics%20Excel%20Dashboard.xlsx)

---

## MySQL

Used to extract, transform, aggregate, and analyze insurance data.

**Techniques:**

`Joins` · `GROUP BY` · `Aggregations` · `CASE` · `Filtering` · `Subqueries` · `KPI Calculations`

📂 [View SQL Queries](SQL_Analysis/Insurance%20Analytics%20SQL%20Queries.sql)

---

## Tableau

Used to build interactive dashboards for policy, customer, and claims analysis.

**Focus Areas:**

`Customer Segmentation` · `Trend Analysis` · `Policy Analysis` · `Claims Analysis` · `Data Storytelling`

📂 [[View Tableau Workbook](Tableau_Dashboard/Insurance%20analytics%20Tableau%20dashboard.twbx)

---

## Power BI

Used to develop an interactive business intelligence dashboard.

**Focus Areas:**

`Data Modeling` · `DAX Measures` · `KPI Dashboards` · `Interactive Visualizations` · `Trend Analysis` · `Customer Segmentation`

📂 [View Power BI Dashboard](PowerBI_Dashboard/Insurance%20analytics%20PowerBI%20Dashboard.pbix)

---

# 🔄 Analytics Workflow

```text
                  Insurance Data
                       │
                       ▼
              Data Cleaning
                       │
                       ▼
             Data Transformation
                       │
                       ▼
              Exploratory Analysis
                  ┌────┴────┐
                  ▼         ▼
                SQL      Excel
                  │         │
                  └────┬────┘
                       ▼
              Dashboard Development
                 ┌─────┴─────┐
                 ▼           ▼
              Tableau     Power BI
                 │           │
                 └─────┬─────┘
                       ▼
              Business Insights
                       │
                       ▼
                Recommendations
```

---

# 📁 Repository Structure

```text
Insurance-Analytics-Project/
│
├── README.md
│
├── Data/
│   └── README.md
│
├── Excel/
│   └── Insurance_Analytics_Excel_Dashboard.xlsx
│
├── SQL/
│   └── Insurance_Analytics_SQL_Queries.sql
│
├── PowerBI/
│   └── Insurance_Analytics_PowerBI_Dashboard.pbix
│
├── Tableau/
│   └── Insurance_Analytics_Tableau_Dashboard.twbx
│
├── Presentation/
│   └── Insurance_Analytics_Project_Presentation.pptx
│
├── Images/
│   ├── Excel_Dashboard.png
│   ├── Tableau_Dashboard.png
│   └── PowerBI_Dashboard.png
│
└── Documentation/
    └── Project_Insights.md
```

---

# 🧠 Skills Demonstrated

### Data Analytics
- Data Cleaning
- Data Transformation
- Exploratory Data Analysis
- KPI Analysis
- Business Analysis

### SQL
- Joins
- Aggregations
- Filtering
- CASE Statements
- Subqueries
- Analytical Queries

### Excel
- Pivot Tables
- VLOOKUP/XLOOKUP
- Data Transformation
- Charts
- Dashboard Development

### Power BI
- Data Modeling
- DAX
- KPI Development
- Interactive Dashboards
- Business Reporting

### Tableau
- Dashboard Design
- Data Visualization
- Trend Analysis
- Customer Segmentation
- Data Storytelling

---

# 📑 Project Presentation

For a detailed overview of the project, methodology, findings, and recommendations:

📂 [View Project Presentation](Presentation/Insurance_Analytics_Project_Presentation.pptx)

---

## ⚠️ Data Availability

The underlying dataset is not included in this repository where it contains restricted, confidential, or personally identifiable information.

The repository contains the analytical outputs, dashboards, SQL queries, documentation, and project presentation.

---

## ⭐ Project Summary

This project demonstrates an end-to-end **Data Analyst workflow**, from data preparation and SQL analysis to dashboard development and business storytelling.

The analysis combines **Excel, MySQL, Tableau, and Power BI** to transform insurance data into actionable insights across **policy performance, customer behavior, premium collection, renewals, and claims management**.
