CREATE DATABASE CustomerChurnDB;
SELECT * FROM telco_churn_data;
USE CustomerChurnDB;

-- 1: Overall Churn KPIs — the executive summary numbers

SELECT
    COUNT(customerid)                                     AS total_customers,
    SUM(churn_flag)                                       AS total_churned,
    COUNT(customerid) - SUM(churn_flag)                   AS total_retained,
    ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2) AS churn_rate_pct,
    ROUND(AVG(monthlycharges), 2)                         AS avg_monthly_charges,
    ROUND(SUM(churn_flag * monthlycharges), 2)            AS monthly_revenue_at_risk,
    ROUND(SUM(churn_flag * monthlycharges) * 12, 2)       AS annual_revenue_at_risk
FROM telco_churn_data;

-- 2: Churn Rate by Contract Type
SELECT
    contract,
    COUNT(customerid)                                        AS total_customers,
    SUM(churn_flag)                                          AS churned,
    ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)    AS churn_rate_pct,
    ROUND(AVG(monthlycharges), 2)                            AS avg_monthly_charges,
    ROUND(SUM(churn_flag * monthlycharges) * 12, 2)          AS annual_rev_at_risk
FROM telco_churn_data
GROUP BY contract
ORDER BY churn_rate_pct DESC;

-- 3: Avg Monthly Charges — Churned vs Retained

SELECT
    churn                                                     AS churn_status,
    COUNT(customerid)                                         AS customers,
    ROUND(AVG(monthlycharges), 2)                             AS avg_monthly_charges,
    ROUND(MIN(monthlycharges), 2)                             AS min_monthly_charges,
    ROUND(MAX(monthlycharges), 2)                             AS max_monthly_charges,
    ROUND(AVG(totalcharges), 2)                               AS avg_total_charges,
    ROUND(AVG(tenure), 1)                                     AS avg_tenure_months
FROM telco_churn_data
GROUP BY churn
ORDER BY churn DESC;

-- 4: High-Risk Customer Segment

SELECT
    COUNT(customerid)                                         AS segment_size,
    SUM(churn_flag)                                           AS churned,
    ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)    AS segment_churn_rate_pct,
    ROUND(SUM(churn_flag * monthlycharges) * 12, 2)           AS annual_rev_at_risk,
    ROUND(AVG(monthlycharges), 2)                             AS avg_monthly_charges,

    -- Benchmark vs overall churn rate
    (SELECT ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)
     FROM telco_churn_data)                                        AS overall_churn_rate_pct

FROM telco_churn_data
WHERE contract        = 'Month-to-month'
  AND internetservice = 'Fiber optic'
  AND techsupport     = 'No'
  AND onlinesecurity  = 'No';

--  5: Revenue at Risk — Full Breakdown

SELECT
    contract,
    internetservice,
    COUNT(customerid)                                         AS total_customers,
    SUM(churn_flag)                                           AS churned_customers,
    ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)    AS churn_rate_pct,
    ROUND(SUM(churn_flag * monthlycharges), 2)                AS monthly_rev_lost,
    ROUND(SUM(churn_flag * monthlycharges) * 12, 2)           AS annual_rev_lost
FROM telco_churn_data
GROUP BY contract, internetservice
ORDER BY annual_rev_lost DESC;

-- 6. Customers with >24 Months Tenure Who Still Churn

SELECT
    contract,
    internetservice,
    paymentmethod,
    COUNT(customerid)                                         AS long_tenure_churners,
    ROUND(AVG(tenure), 1)                                     AS avg_tenure_months,
    ROUND(AVG(monthlycharges), 2)                             AS avg_monthly_charges,
    ROUND(AVG(totalcharges), 2)                               AS avg_total_charges,
    ROUND(SUM(monthlycharges) * 12, 2)                        AS annual_rev_lost
FROM telco_churn_data
WHERE tenure     > 24
  AND churn_flag = 1
GROUP BY contract, internetservice, paymentmethod
ORDER BY long_tenure_churners DESC;

-- 7. Churn Rate by Payment Method

SELECT
    paymentmethod,
    COUNT(customerid)                                         AS total_customers,
    SUM(churn_flag)                                           AS churned,
    ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)    AS churn_rate_pct,
    ROUND(AVG(monthlycharges), 2)                             AS avg_monthly_charges
FROM telco_churn_data
GROUP BY paymentmethod
ORDER BY churn_rate_pct DESC;

-- 8. Impact of Add-on Services on Churn

SELECT
    techsupport,
    onlinesecurity,
    COUNT(customerid)                                         AS customers,
    SUM(churn_flag)                                           AS churned,
    ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)    AS churn_rate_pct,
    ROUND(AVG(monthlycharges), 2)                             AS avg_monthly_charges
FROM telco_churn_data
WHERE internetservice != 'No'        -- only customers with internet
GROUP BY techsupport, onlinesecurity
ORDER BY churn_rate_pct DESC;

-- 9. Churn by Tenure Group with Revenue Impact

SELECT
    CASE
        WHEN tenure BETWEEN  0 AND 12 THEN '0–12 mo'
        WHEN tenure BETWEEN 13 AND 24 THEN '13–24 mo'
        WHEN tenure BETWEEN 25 AND 36 THEN '25–36 mo'
        WHEN tenure BETWEEN 37 AND 48 THEN '37–48 mo'
        WHEN tenure BETWEEN 49 AND 60 THEN '49–60 mo'
        ELSE '61–72 mo'
    END                                                       AS tenure_group,

    COUNT(customerid)                                         AS total_customers,
    SUM(churn_flag)                                           AS churned,
    ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)    AS churn_rate_pct,
    ROUND(AVG(monthlycharges), 2)                             AS avg_monthly_charges,
    ROUND(SUM(churn_flag * monthlycharges) * 12, 2)           AS annual_rev_at_risk

FROM telco_churn_data
GROUP BY
    CASE
        WHEN tenure BETWEEN  0 AND 12 THEN '0–12 mo'
        WHEN tenure BETWEEN 13 AND 24 THEN '13–24 mo'
        WHEN tenure BETWEEN 25 AND 36 THEN '25–36 mo'
        WHEN tenure BETWEEN 37 AND 48 THEN '37–48 mo'
        WHEN tenure BETWEEN 49 AND 60 THEN '49–60 mo'
        ELSE '61–72 mo'
    END
ORDER BY MIN(tenure);

-- 10. Top 3 Churning Profiles Using Window Function

WITH profile_churn AS (
    SELECT
        contract,
        internetservice,
        techsupport,
        paymentmethod,
        COUNT(customerid)                                     AS total_customers,
        SUM(churn_flag)                                       AS churned,
        ROUND(SUM(churn_flag) * 100.0 / COUNT(customerid), 2)
                                                              AS churn_rate_pct,
        ROUND(SUM(churn_flag * monthlycharges) * 12, 2)       AS annual_rev_at_risk
    FROM telco_churn_data
    GROUP BY contract, internetservice, techsupport, paymentmethod
    HAVING COUNT(customerid) >= 50     -- exclude tiny segments
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY churn_rate_pct DESC)      AS risk_rank
    FROM profile_churn
)
SELECT
    risk_rank,
    contract,
    internetservice,
    techsupport,
    paymentmethod,
    total_customers,
    churned,
    churn_rate_pct,
    annual_rev_at_risk
FROM ranked
WHERE risk_rank <= 10
ORDER BY risk_rank;
