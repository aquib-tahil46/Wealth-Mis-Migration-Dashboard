-- ============================================================
-- WEALTH MIS PROJECT — FULL PIPELINE (CLEAN VERSION)
-- Scope: Database setup → Raw load → Cleaning → Analytics
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE & TABLE SETUP
-- ============================================================

CREATE DATABASE wealth_mis_project;
USE wealth_mis_project;

CREATE TABLE wealth_mis_raw (
    record_id           VARCHAR(20),
    performance_month   VARCHAR(20),
    quarter             VARCHAR(5),
    fiscal_year         INT,
    zone                VARCHAR(50),
    cluster             VARCHAR(50),
    branch              VARCHAR(100),
    wealth_manager_id   VARCHAR(20),
    wealth_manager_name VARCHAR(100),
    employee_grade      VARCHAR(50),
    product_category    VARCHAR(50),
    product_name        VARCHAR(100),
    source_system       VARCHAR(50),
    target_amount       DECIMAL(18,2),
    achieved_amount     DECIMAL(18,2),
    revenue_amount      DECIMAL(18,2),
    customer_count      INT,
    active_clients      INT,
    data_quality_issue  VARCHAR(100),
    meeting_context     VARCHAR(255)
);

CREATE TABLE branch_cluster_mapping (
    zone    VARCHAR(20),
    cluster VARCHAR(50),
    branch  VARCHAR(100)
);

CREATE TABLE product_mapping (
    raw_product_name        VARCHAR(100),
    standard_product_name   VARCHAR(100),
    product_category        VARCHAR(50),
    standard_source_system  VARCHAR(50)
);


-- ============================================================
-- SECTION 2: DATA LOAD
-- ============================================================

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/AQUIB TAHIL/OneDrive/Desktop/MIS PROJECT/wealth_mis_kolkata_q2_q3_raw.csv'
INTO TABLE wealth_mis_raw
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/AQUIB TAHIL/OneDrive/Desktop/MIS PROJECT/wealth_mis_branch_cluster_mapping.csv'
INTO TABLE branch_cluster_mapping
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/AQUIB TAHIL/OneDrive/Desktop/MIS PROJECT/wealth_mis_product_mapping.csv'
INTO TABLE product_mapping
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- ============================================================
-- SECTION 3: RAW DATA CORRECTIONS (Pre-cleaning fixes)
-- ============================================================

SET SQL_SAFE_UPDATES = 0;

-- Standardise employee grade: 'Chief Manager' → 'Senior Manager'
UPDATE wealth_mis_raw
SET employee_grade = 'Senior Manager'
WHERE employee_grade = 'Chief Manager';

-- Validate: confirm no duplicate branch entries in mapping table
SELECT zone, cluster, branch, COUNT(*) AS duplicate_count
FROM branch_cluster_mapping
GROUP BY zone, cluster, branch
HAVING COUNT(*) > 1;


-- ============================================================
-- SECTION 4: STEP 1 — DATE CLEANING
-- Convert performance_month from string to proper DATE.
-- ============================================================

CREATE TABLE wealth_mis_step1_date_cleaned AS
SELECT
    record_id,
    STR_TO_DATE(performance_month, '%d-%m-%Y') AS performance_month,
    quarter, fiscal_year, zone, cluster, branch,
    wealth_manager_id, wealth_manager_name, employee_grade,
    product_category, product_name, source_system,
    target_amount, achieved_amount, revenue_amount,
    customer_count, active_clients, data_quality_issue, meeting_context
FROM wealth_mis_raw;

-- Validate: check month distribution
SELECT performance_month, COUNT(*)
FROM wealth_mis_step1_date_cleaned
GROUP BY performance_month;


-- ============================================================
-- SECTION 5: STEP 2 — PRODUCT CLEANING
-- Standardise product_name, product_category, and source_system
-- using CASE logic directly (covers all raw variants).
-- ============================================================

CREATE TABLE wealth_mis_step2_product_cleaned AS
SELECT
    record_id, performance_month, quarter, fiscal_year,
    zone, cluster, branch,
    wealth_manager_id, wealth_manager_name, employee_grade,

    CASE
        WHEN product_name IN ('CASA','Casa','C/A S/A','CA-SA')                              THEN 'Liability'
        WHEN product_name IN ('FD','Fixed Deposit','FDR','Term Deposit')                    THEN 'Liability'
        WHEN product_name IN ('Deposit Mobilization','Deposit Mob','Deposit Mobilisation','Total Deposit') THEN 'Liability'
        WHEN product_name IN ('Insurance','Life Insurance','LI','Insurence')                THEN 'Fee'
        WHEN product_name IN ('Forex','FX','ForEx','Foreign Exchange')                      THEN 'Fee'
        WHEN product_name IN ('Cards','Credit Card','Cards Issued','Card')                  THEN 'Fee'
        WHEN product_name IN ('Home Loan','HL','Housing Loan','HomeLoan')                   THEN 'Asset'
        WHEN product_name IN ('Personal Loan','PL','Pers Loan','PersonalLoan')              THEN 'Asset'
        WHEN product_name IN ('Business Loan','BL','SME Loan','BusinessLoan')               THEN 'Asset'
        WHEN product_name IN ('Mutual Fund','MF','Mutual Funds','MutualFund')               THEN 'Investment'
        WHEN product_name IN ('Demat','DEMAT','Demat Account','Demat A/c')                  THEN 'Investment'
        ELSE product_category
    END AS product_category,

    CASE
        WHEN product_name IN ('CASA','Casa','C/A S/A','CA-SA')                              THEN 'CASA'
        WHEN product_name IN ('FD','Fixed Deposit','FDR','Term Deposit')                    THEN 'FD'
        WHEN product_name IN ('Deposit Mobilization','Deposit Mob','Deposit Mobilisation','Total Deposit') THEN 'Deposit Mobilization'
        WHEN product_name IN ('Insurance','Life Insurance','LI','Insurence')                THEN 'Insurance'
        WHEN product_name IN ('Forex','FX','ForEx','Foreign Exchange')                      THEN 'Forex'
        WHEN product_name IN ('Cards','Credit Card','Cards Issued','Card')                  THEN 'Cards'
        WHEN product_name IN ('Home Loan','HL','Housing Loan','HomeLoan')                   THEN 'Home Loan'
        WHEN product_name IN ('Personal Loan','PL','Pers Loan','PersonalLoan')              THEN 'Personal Loan'
        WHEN product_name IN ('Business Loan','BL','SME Loan','BusinessLoan')               THEN 'Business Loan'
        WHEN product_name IN ('Mutual Fund','MF','Mutual Funds','MutualFund')               THEN 'Mutual Fund'
        WHEN product_name IN ('Demat','DEMAT','Demat Account','Demat A/c')                  THEN 'Demat'
        ELSE product_name
    END AS product_name,

    CASE
        WHEN product_name IN ('CASA','Casa','C/A S/A','CA-SA')                              THEN 'CASA RA'
        WHEN product_name IN ('FD','Fixed Deposit','FDR','Term Deposit')                    THEN 'Deposit RA'
        WHEN product_name IN ('Deposit Mobilization','Deposit Mob','Deposit Mobilisation','Total Deposit') THEN 'Deposit RA'
        WHEN product_name IN ('Insurance','Life Insurance','LI','Insurence')                THEN 'LI RA'
        WHEN product_name IN ('Forex','FX','ForEx','Foreign Exchange')                      THEN 'Forex RA'
        WHEN product_name IN ('Cards','Credit Card','Cards Issued','Card')                  THEN 'Cards RA'
        WHEN product_name IN ('Home Loan','HL','Housing Loan','HomeLoan')                   THEN 'Loan RA'
        WHEN product_name IN ('Personal Loan','PL','Pers Loan','PersonalLoan')              THEN 'Loan RA'
        WHEN product_name IN ('Business Loan','BL','SME Loan','BusinessLoan')               THEN 'Loan RA'
        WHEN product_name IN ('Mutual Fund','MF','Mutual Funds','MutualFund')               THEN 'Investment RA'
        WHEN product_name IN ('Demat','DEMAT','Demat Account','Demat A/c')                  THEN 'Demat RA'
        ELSE source_system
    END AS source_system,

    target_amount, achieved_amount, revenue_amount,
    customer_count, active_clients, data_quality_issue, meeting_context

FROM wealth_mis_step1_date_cleaned;

-- Validate: confirm all product names are standardised
SELECT DISTINCT product_name
FROM wealth_mis_step2_product_cleaned
ORDER BY product_name;


-- ============================================================
-- SECTION 6: STEP 3 — LOCATION CLEANING
-- Override incorrect zone/cluster values using branch master.
-- ============================================================

CREATE TABLE wealth_mis_step3_location_cleaned AS
SELECT
    s.record_id, s.performance_month, s.quarter, s.fiscal_year,
    COALESCE(b.zone,    s.zone)    AS zone,
    COALESCE(b.cluster, s.cluster) AS cluster,
    s.branch, s.wealth_manager_id, s.wealth_manager_name,
    s.employee_grade, s.product_category, s.product_name,
    s.source_system, s.target_amount, s.achieved_amount,
    s.revenue_amount, s.customer_count, s.active_clients,
    s.data_quality_issue, s.meeting_context
FROM wealth_mis_step2_product_cleaned s
LEFT JOIN branch_cluster_mapping b
    ON TRIM(s.branch) = TRIM(b.branch);

-- Validate: confirm distinct zone-cluster combinations
SELECT DISTINCT zone, cluster
FROM wealth_mis_step3_location_cleaned
ORDER BY zone, cluster;


-- ============================================================
-- SECTION 7: STEP 4 — NULL CLEANING
-- Replace NULL amounts with 0.
-- ============================================================

CREATE TABLE wealth_mis_step4_null_cleaned AS
SELECT
    record_id, performance_month, quarter, fiscal_year,
    zone, cluster, branch,
    wealth_manager_id, wealth_manager_name, employee_grade,
    product_category, product_name, source_system,
    COALESCE(target_amount,   0) AS target_amount,
    COALESCE(achieved_amount, 0) AS achieved_amount,
    COALESCE(revenue_amount,  0) AS revenue_amount,
    customer_count, active_clients, data_quality_issue, meeting_context
FROM wealth_mis_step3_location_cleaned;

-- Validate: confirm no NULLs remain in amount columns
SELECT
    SUM(CASE WHEN target_amount   IS NULL THEN 1 ELSE 0 END) AS null_target,
    SUM(CASE WHEN achieved_amount IS NULL THEN 1 ELSE 0 END) AS null_achieved,
    SUM(CASE WHEN revenue_amount  IS NULL THEN 1 ELSE 0 END) AS null_revenue
FROM wealth_mis_step4_null_cleaned;


-- ============================================================
-- SECTION 8: FINAL CLEANED TABLE
-- Remove rows flagged as duplicate business keys.
-- ============================================================

CREATE TABLE wealth_mis_final_cleaned AS
SELECT *
FROM wealth_mis_step4_null_cleaned
WHERE data_quality_issue <> 'DUPLICATE_BUSINESS_KEY';

-- Validate: confirm standardised product + source system values
SELECT DISTINCT product_category, product_name, source_system
FROM wealth_mis_final_cleaned
ORDER BY product_category, product_name;


-- ============================================================
-- SECTION 9: ANALYTICS QUERIES
-- ============================================================

-- Q1. Overall Business Performance (Executive KPI)
SELECT
    SUM(target_amount)                                              AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    SUM(target_amount - achieved_amount)                           AS total_gap,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct
FROM wealth_mis_final_cleaned;

-- Q2. Quarter-wise Performance (Q2 vs Q3 trend)
SELECT
    quarter,
    SUM(target_amount)                                             AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct
FROM wealth_mis_final_cleaned
GROUP BY quarter
ORDER BY quarter;

-- Q3. Zone-wise Performance
SELECT
    zone,
    SUM(target_amount)                                             AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    SUM(target_amount - achieved_amount)                           AS gap_amount,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct
FROM wealth_mis_final_cleaned
GROUP BY zone
ORDER BY achievement_pct DESC;

-- Q4. Cluster-wise Performance (Zone → Cluster drill-down)
SELECT
    zone, cluster,
    SUM(target_amount)                                             AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    SUM(target_amount - achieved_amount)                           AS gap_amount,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct
FROM wealth_mis_final_cleaned
GROUP BY zone, cluster
ORDER BY achievement_pct DESC;

-- Q5. Branch Ranking
SELECT
    zone, cluster, branch,
    SUM(target_amount)                                             AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct,
    RANK() OVER (ORDER BY SUM(achieved_amount) / SUM(target_amount) DESC) AS branch_rank
FROM wealth_mis_final_cleaned
GROUP BY zone, cluster, branch;

-- Q6. Wealth Manager Ranking
SELECT
    wealth_manager_id, wealth_manager_name, employee_grade,
    zone, cluster, branch,
    SUM(target_amount)                                             AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct,
    RANK() OVER (ORDER BY SUM(achieved_amount) / SUM(target_amount) DESC) AS wm_rank
FROM wealth_mis_final_cleaned
GROUP BY wealth_manager_id, wealth_manager_name, employee_grade, zone, cluster, branch;

-- Q7. Product Category Performance (Liability / Fee / Asset / Investment)
SELECT
    product_category,
    SUM(target_amount)                                             AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    SUM(target_amount - achieved_amount)                           AS gap_amount,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct
FROM wealth_mis_final_cleaned
GROUP BY product_category
ORDER BY achievement_pct DESC;

-- Q8. Q3 vs Q2 Growth by Zone
WITH qtr_perf AS (
    SELECT zone, quarter, SUM(achieved_amount) AS achievement
    FROM wealth_mis_final_cleaned
    GROUP BY zone, quarter
)
SELECT
    zone,
    SUM(CASE WHEN quarter = 'Q2' THEN achievement ELSE 0 END)     AS q2_achievement,
    SUM(CASE WHEN quarter = 'Q3' THEN achievement ELSE 0 END)     AS q3_achievement,
    ROUND(
        (SUM(CASE WHEN quarter = 'Q3' THEN achievement ELSE 0 END) -
         SUM(CASE WHEN quarter = 'Q2' THEN achievement ELSE 0 END))
        / NULLIF(SUM(CASE WHEN quarter = 'Q2' THEN achievement ELSE 0 END), 0) * 100,
    2) AS qoq_growth_pct
FROM qtr_perf
GROUP BY zone
ORDER BY qoq_growth_pct DESC;

-- Q9. Q4 Required Run Rate by Cluster
SELECT
    zone, cluster,
    SUM(target_amount)                                             AS q2_q3_target,
    SUM(achieved_amount)                                           AS q2_q3_achievement,
    SUM(target_amount - achieved_amount)                           AS q2_q3_gap,
    ROUND(SUM(target_amount - achieved_amount) / 3, 2)            AS required_monthly_q4_run_rate
FROM wealth_mis_final_cleaned
GROUP BY zone, cluster
HAVING q2_q3_gap > 0
ORDER BY q2_q3_gap DESC;

-- Q10. Product Contribution to Total Achievement
SELECT
    product_category, product_name,
    SUM(achieved_amount)                                           AS product_achievement,
    ROUND(SUM(achieved_amount) /
        (SELECT SUM(achieved_amount) FROM wealth_mis_final_cleaned) * 100, 2) AS contribution_pct
FROM wealth_mis_final_cleaned
GROUP BY product_category, product_name
ORDER BY contribution_pct DESC;

-- Q11. Wealth Manager Performance Banding by Zone
WITH wm_perf AS (
    SELECT
        wealth_manager_id, wealth_manager_name, zone, cluster, branch,
        ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2) AS achievement_pct
    FROM wealth_mis_final_cleaned
    GROUP BY wealth_manager_id, wealth_manager_name, zone, cluster, branch
)
SELECT
    zone,
    CASE
        WHEN achievement_pct >= 100 THEN 'Target Achieved'
        WHEN achievement_pct >=  85 THEN 'Near Target'
        WHEN achievement_pct >=  70 THEN 'Needs Push'
        ELSE 'Critical'
    END AS performance_band,
    COUNT(*) AS wm_count
FROM wm_perf
GROUP BY zone, performance_band;

-- Q12. Top 3 Gap-Contributing Products by Zone
WITH zone_product_gap AS (
    SELECT zone, product_name,
        SUM(target_amount - achieved_amount) AS gap_amount
    FROM wealth_mis_final_cleaned
    GROUP BY zone, product_name
),
ranked_gap AS (
    SELECT zone, product_name, gap_amount,
        RANK() OVER (PARTITION BY zone ORDER BY gap_amount DESC) AS gap_rank
    FROM zone_product_gap
)
SELECT zone, product_name, gap_amount, gap_rank
FROM ranked_gap
WHERE gap_rank <= 3
ORDER BY zone, gap_rank;

-- Q13. Zone × Product Heatmap (for Tableau)
SELECT
    zone, product_name,
    SUM(target_amount)                                             AS total_target,
    SUM(achieved_amount)                                           AS total_achievement,
    ROUND(SUM(achieved_amount) / SUM(target_amount) * 100, 2)     AS achievement_pct
FROM wealth_mis_final_cleaned
GROUP BY zone, product_name
ORDER BY zone, product_name;
