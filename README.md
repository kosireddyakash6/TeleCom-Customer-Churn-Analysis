
# **TELECOM CUSTOMER CHURN & COHORT ANALYSIS**

## **1. Business Problem Understanding**

Retaining subscribers and managing customer lifetime value (LTV) is a defining operational challenge for modern telecommunications providers. This enterprise analytics project dives into a customer ecosystem of **7,043 customer accounts** to address a critical leakage: an **overall churn rate of 26.5%**, which has resulted in **1,869 lost customers** and exposed an estimated **$1.67M in Annual Recurring Revenue (ARR) to immediate risk**.

The architecture targets the core investigative prompt:

> *"How can the company leverage customer subscription, billing, and demographic data to identify structural churn drivers, segment high-risk customers, and design data-backed retention strategies?"*

---

## **2. Project Architecture & Repository Structure**

The project is built as a modular end-to-end data pipeline, separating data engineering, relational database querying, and executive visualization layer tasks:

```
📁 telco-churn-cohort-analysis/
│
├── 📓 Data_Cleaning.ipynb               # Phase 1: Python cleaning, EDA & cohort engineering
├── 🗄️ Churn_Analysis_SQL.sql            # Phase 2: 10 advanced business SQL queries (MySQL)
├── 📊 Churn_Dashboard.pbix              # Phase 3: Interactive Power BI dashboard (3 pages)
├── 📄 Project_Report.pdf                # Full written business report & executive summary
├── 📂 images/
│   ├── 🖼️ img1.png                      # Dashboard — Executive Summary Canvas
│   ├── 🖼️ img2.png                      # Dashboard — Cohort & Segment Analysis Matrix
│   └── 🖼️ img3.png                      # Dashboard — Revenue at Risk Financial Ledger
└── 📂 WA_Fn-UseC_-Telco-Customer-Churn.csv   # Raw Source Dataset (7,043 rows | 21 features)

```

---

## **3. Technical Execution Pipeline**

### **Phase 1: Data Engineering & EDA (Python)**

Executed completely within `Data_Cleaning.ipynb` to establish a clean, standardized data asset:

* **Missing Data Imputation:** Identified 11 blank values in the `TotalCharges` field. Because these represented brand-new accounts with a tenure of 0 months, they were dynamically imputed using their corresponding `MonthlyCharges` values to preserve database integrity.
* **Schema Standardization:** Standardized the nomenclature by converting all raw columns to clean `snake_case`.
* **Feature Engineering:**
* Created an analytical binary indicator column (`churn_flag`: `Yes` $\rightarrow$ 1, `No` $\rightarrow$ 0) to allow for clean visual aggregations.
* Grouped historical customer lifetimes into 6 distinct behavioral tenure cohorts: `0-12 mo`, `13-24 mo`, `25-36 mo`, `37-48 mo`, `49-60 mo`, and `61-72 mo`.


* **Database Integration:** Formatted and exported the structured dataframe into a PostgreSQL/MySQL environment for advanced querying.

### **Phase 2: Database Business Analysis (SQL)**

Structured inside `Churn_Analysis_SQL.sql` using MySQL to isolate complex behavioral patterns:

* **Financial Variations:** Discovered that churned customers pay an average of **~$74/mo**, significantly outpricing the **~$61/mo** baseline of retained customers.
* **Compound Segment Risk:** Isolated a catastrophic bottleneck where customers on a *Month-to-month contract + using Fiber optic internet + carrying no Tech Support* exhibited a staggering **58% churn rate**.
* **Profile Ranking:** Employed advanced window functions (`ROW_NUMBER() OVER(...)`) to sort and identify the worst offender customer profiles based on raw attrition volume.

### **Phase 3: Visual Analytics & Semantic Modeling (Power BI)**

Developed an interactive, 3-page business intelligence application running optimized DAX semantic calculations:

#### **Core DAX Infrastructure:**

```dax
Total Customers = COUNTROWS(telco_churn)

Total Churned = SUM(telco_churn[churn_flag])

Churn Rate % = DIVIDE([Total Churned], [Total Customers], 0) * 100

Monthly Rev Risk = SUMX(FILTER(telco_churn, telco_churn[churn_flag] = 1), telco_churn[monthlycharges])

Annual Rev at Risk = [Monthly Rev Risk] * 12

Avg Monthly Charge = AVERAGE(telco_churn[monthlycharges])

Retained Customers = [Total Customers] - [Total Churned]

```

#### **Dashboard Page Breakdown:**

* **Page 1: Executive Summary Canvas:** Hosts top-level KPI cards, contract/internet slicers, and behavioral bar charts detailing churn rates across payment methods and plan styles.
<img width="1043" height="587" alt="telecom churn p1" src="https://github.com/user-attachments/assets/e7c23dc0-caaa-4f35-9c67-bf6917fbcb99" />

* **Page 2: Cohort & Segment Analysis:** Anchored by a matrix view with a conditional green-to-red gradient, displaying exact churn percentages across tenure groups $\times$ contract lengths alongside a tech support service delta chart.
<img width="1042" height="577" alt="telecom churn p2" src="https://github.com/user-attachments/assets/bb46a26b-f8de-47c2-93f3-3233ee19a697" />

* **Page 3: Revenue at Risk Ledger:** Maps financial vulnerabilities using an enterprise treemap and a donut chart splitting lost recurring revenues across specific internet product lines.
<img width="1041" height="576" alt="telecom churn p3" src="https://github.com/user-attachments/assets/cf558b11-5d5d-47a3-864d-fe4ca5e041c9" />

---

## **4. Data Model Blueprint**

The underlying semantic structure groups **21 independent feature dimensions** systematically to eliminate logical bias:

| Demographics | Subscription Info | Add-on Services | Billing & Payments | Behavior |
| --- | --- | --- | --- | --- |
| • Gender <br>

<br>• Senior Citizen <br>

<br>• Partner <br>

<br>• Dependents | • Contract Type <br>

<br>• Internet Service <br>

<br>• Phone Service <br>

<br>• Streaming Tiers | • Tech Support <br>

<br>• Online Security <br>

<br>• Online Backup <br>

<br>• Device Protection | • Monthly Charges <br>

<br>• Total Charges <br>

<br>• Payment Method <br>

<br>• Paperless Flag | • Tenure (Months) <br>

<br>• Churn Status (`Yes/No`) <br>

<br>• `churn_flag` (0/1) |

---

## **5. Strategic Business Recommendations**

1. **Incentivize Annual Contract Migration:** Month-to-month accounts show a dangerous **42.7% churn rate** compared to just **2.8%** for two-year plans. Offering targeted loyalty promotions or a 1-month-free discount to convert these users to annual cycles will secure cash flows. Converting just 10% of this volatile base saves **~$167K/year**.
2. **Build a 90-Day High-Touch Onboarding Framework:** Attrition peaks aggressively in the **first 12 months at 47.7%**. The operations team must assign dedicated onboarding checkpoints, automated satisfaction calls, and a free tech support trial to guide new subscribers through this high-risk drop-off zone.
3. **Deploy a Fiber-Optic "Protection Bundle":** Premium Fiber Optic infrastructure carries an alarming **41.9% churn rate**. Because data proves that bundling *Tech Support + Online Security* cuts churn risk by roughly half (~15% vs ~41%), these add-ons should be automatically bundled into fiber tiers to bridge the price-to-value satisfaction gap.
4. **Transition Manual Payers to Digital Auto-Pay:** Customers relying on manual Electronic Checks churn at an outsized **45.3% rate** due to monthly payment friction. Implementing a small (e.g., 5%) billing credit to incentivize automatic bank draft setups will instantly smooth out retention baselines.
5. **Re-engage High-Loyalty Transactional Leaks:** The analysis surfaced **2,518 highly active repeat buyers** who have completed over 5 independent purchases but **never converted into monthly subscribers**. Launching low-cost email and app-based re-engagement campaigns targeting this warm audience offers immediate revenue upside without steep client acquisition costs.

---

## 👤 Author

**Kosireddy Akash**

*Data Analyst | Python • SQL • Power BI Analytics*
