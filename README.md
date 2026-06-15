# TeleCom-Customer-Churn-Analysis
 **Telecom Customer Churn Analysis** project.


## Project Overview

Customer retention is a critical challenge in the telecom industry, where customer acquisition costs are significantly higher than retention costs. This project analyzes telecom customer data to identify churn patterns, understand key factors influencing customer attrition, and provide insights that can support customer retention strategies.

The analysis was performed using Power BI, DAX, and Data Modeling techniques to build an interactive dashboard that enables business users to monitor churn trends across multiple customer segments.

---

## Business Problem

Telecom companies face revenue loss when customers discontinue their services. Understanding which customers are likely to churn and identifying the underlying reasons can help organizations take proactive retention measures.

This project aims to answer:

* What is the overall customer churn rate?
* Which customer segments are more likely to churn?
* What are the most common churn reasons?
* How does churn vary across contract types and payment methods?
* What is the revenue impact of customer churn?
* Which services are associated with higher customer attrition?

---

## Tools & Technologies

* Power BI
* DAX
* Power Query
* Data Modeling
* Microsoft Excel / CSV Dataset

---

## Dashboard Features

### Customer Overview

* Total Customers
* Active Customers
* Churned Customers
* Churn Rate %

### Revenue Analysis

* Monthly Revenue
* Revenue Lost Due to Churn
* Revenue Impact by Customer Segment

### Churn Analysis

* Churn by Contract Type
* Churn by Payment Method
* Churn by Internet Service
* Churn by State/Region
* Churn by Age Group
* Churn by Tenure Group

### Customer Segmentation

* Monthly Charge Bands
* Demographic Segmentation
* Service Subscription Analysis
* High-Risk Customer Groups

---

## Key KPIs

| KPI                     | Description                               |
| ----------------------- | ----------------------------------------- |
| Churn Rate              | Percentage of customers who left          |
| Retention Rate          | Percentage of retained customers          |
| Revenue Lost            | Revenue associated with churned customers |
| Average Monthly Charges | Customer spending patterns                |
| Customer Distribution   | Segment-wise customer analysis            |

---

## Data Modeling

The solution uses a star-schema-inspired data model consisting of:

* Customer Data Table
* Churn Category Mapping Table
* Churn Reason Mapping Table
* Geography Mapping Table

Relationships were created to enable efficient filtering and drill-down analysis.

---

## DAX Measures Implemented

Examples include:

* Total Customers
* Churned Customers
* Active Customers
* Churn Rate %
* Retention Rate %
* Revenue Lost
* Average Monthly Charges
* Customer Segmentation Metrics

---

## Key Insights

### Contract Type Analysis

Month-to-month customers exhibited significantly higher churn rates compared to long-term contract customers.

### Payment Method Analysis

Certain payment methods showed higher customer attrition, indicating possible customer experience or billing-related issues.

### Service-Level Analysis

Customers subscribed to specific internet services demonstrated higher churn tendencies than others.

### Tenure Analysis

Customers with shorter tenure were more likely to churn, highlighting the importance of early customer engagement.

### Revenue Impact

A relatively small group of churned customers contributed disproportionately to revenue loss.

---

## Business Recommendations

* Strengthen retention campaigns for high-risk customer segments.
* Improve onboarding experience for new customers.
* Offer incentives for customers on month-to-month contracts.
* Investigate service-related issues associated with high churn categories.
* Focus customer success initiatives on segments generating high revenue.

---

## Project Outcome

This dashboard provides a comprehensive view of customer churn behavior and enables data-driven customer retention analysis through interactive visualizations, segmentation techniques, and KPI monitoring.

---

## Skills Demonstrated

* Power BI Dashboard Development
* DAX Measures & Calculations
* Data Modeling
* Business Intelligence Reporting
* Customer Analytics
* Churn Analysis
* KPI Tracking
* Data Visualization
* Analytical Problem Solving

---

## Repository Structure

```text
Telecom-Customer-Churn-Analysis/
│
├── Dataset/
├── PowerBI Dashboard/
├── Images/
├── README.md
└── Telecom_Customer_Churn.pbix
```

This README is strong enough for recruiters, GitHub visitors, and interviewers, and aligns well with the type of Data Analyst projects companies like EXL, NielsenIQ, Genpact, Mu Sigma, LatentView, and Accenture expect to see in a portfolio.
