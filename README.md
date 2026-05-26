# Wealth-Mis-Migration-Dashboard
Wealth Banking MIS Migration | Excel → MySQL + Tableau |  Executive BI Dashboard | ₹21.54B Portfolio Analysis | BFSI Analytics Visibility: Public

# 🏦 Wealth Banking MIS Migration Dashboard
## Excel → MySQL + Tableau | Digital Transformation Proof of Concept for Indian Banking

![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat&logo=tableau&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Domain](https://img.shields.io/badge/Domain-BFSI%20%7C%20Wealth%20Banking-darkblue)
![Experience](https://img.shields.io/badge/Built%20on-9%20Years%20BFSI%20Experience-green)

---

## 🔗 Live Dashboard
### ▶ [View Full Executive Story on Tableau Public](https://public.tableau.com/app/profile/aquib.tahil8642/viz/Wealth_MIS_Migration_Executive_Dashboard/Story1)

---

## 📸 Dashboard Preview

![Strategic Dashboard]<img width="934" height="404" alt="Screenshot 2026-05-26 105827" src="https://github.com/user-attachments/assets/5cc433ef-ea56-4036-83ce-d7cc98f0ac03" />

*Dashboard 1 — Wealth Banking Business Intelligence & Action Center*

![Command Center]<img width="934" height="394" alt="Screenshot 2026-05-26 105921" src="https://github.com/user-attachments/assets/14d7d559-90b7-4670-8634-59f7155a6a02" />

*Dashboard 2 — Wealth Banking Performance Command Center*

---

## 🎯 The Problem This Project Solves

> *"Across India's private banking sector, Wealth Management MIS is still predominantly managed through Excel — manual consolidation, static monthly reports, and end-of-quarter surprises."*

After **9 years in BFSI analytics** at ICICI Bank and Axis Bank, I witnessed firsthand how wealth teams managing **₹20B+ portfolios** relied on:

- ❌ Static Excel MIS sheets refreshed manually each month
- ❌ Zone performance gaps invisible until quarter-end
- ❌ At-risk Relationship Managers identified too late to intervene
- ❌ Product shortfalls discovered after targets were already missed
- ❌ Leadership decisions made on data that was weeks old

This project is a **working proof of concept** demonstrating what a complete **Excel → MySQL + Tableau migration** looks like for a Wealth Banking performance reporting setup.

---

## 💡 The Migration Case

| Before (Excel MIS) | After (MySQL + Tableau) |
|---|---|
| Static monthly reports | Live interactive 7-point executive story |
| Manual zone consolidation every month-end | Automated 5-zone drill-down in seconds |
| Performance gaps discovered at quarter-end | Real-time ₹3.87B gap tracked by product & zone |
| WM coaching decisions based on gut feel | Automated performance band segmentation |
| 10+ separate Excel files shared over email | 1 unified executive dashboard — shareable link |
| Decisions on data that is weeks old | Decisions on current, structured, clean data |
| No product × zone cross-analysis | Full Zone × Product heatmap across 11 products |

---

## 📐 Dataset & Scope

| Dimension | Detail |
|---|---|
| 💰 Portfolio Size | ₹21.54B |
| 🎯 Achievement % | 84.76% |
| ⚠️ Gap to Target | ₹3.87B |
| 🗺️ Zones | 5 (Kolkata South, East, North, Central, Greater Kolkata) |
| 📦 Products | 11 (HL, Deposits, BL, FD, CASA, MF, PL, Insurance, Forex, Cards, Demat) |
| 👥 Wealth Managers | 100 |
| 📅 Time Period | Q2–Q3 (6 months) |
| 🏗️ Source | Excel MIS → MySQL → Tableau |

---

## 🏗️ Technical Architecture

```
📊 Raw Excel MIS Files (Multi-sheet, inconsistent formats)
              ↓
    🧹 Data Cleaning Pipeline
    (4-step: Date → Product → Location → Null handling)
              ↓
    🗄️ MySQL Database
    (3-table structure: Raw → Cleaned → Analytics)
              ↓
    📈 Tableau Desktop
    (Connected via MySQL live connection)
              ↓
    🎨 Executive Dashboards + 7-Point Story
              ↓
    🌐 Tableau Public
    (Live, shareable, portfolio-ready)
```

---

## 🔍 Key Findings

### Zone Intelligence
| Zone | Achievement % | Status |
|---|---|---|
| Kolkata South | 91.2% | 🟢 Top Performer |
| Kolkata East | 87.1% | 🟢 Strong |
| Kolkata North | 82.9% | 🟡 On Track |
| Kolkata Central | 80.6% | 🟡 Needs Attention |
| Greater Kolkata | 75.8% | 🔴 Critical |

> **15.4% performance gap** between best and worst zone — completely invisible in Excel MIS

### Product Risk Matrix
| Product | Achieved | Target | Gap | Status |
|---|---|---|---|---|
| HL | ₹5.44B | ₹6.37B | ₹0.93B | 🔴 High Risk |
| Deposits | ₹4.97B | ₹5.90B | ₹0.93B | 🔴 High Risk |
| BL | ₹3.42B | ₹4.06B | ₹0.64B | 🟡 Medium Risk |
| Forex | ₹0.13B | ₹0.14B | ₹0.01B | 🟢 Best (96%) |

### People Analytics
| Band | Count | Action |
|---|---|---|
| 🏆 Top Performer | 14 | Recognize & replicate |
| 📈 Near Target | 47 | Light coaching |
| ⚠️ Needs Push | 34 | Targeted intervention |
| 🚨 Critical | 5 | Immediate action |

---

## 🛠️ SQL Pipeline — 13 Analytical Queries

The SQL file covers the complete data pipeline:

**Data Cleaning (4 steps):**
- `STEP 1` — Date standardisation using `STR_TO_DATE()`
- `STEP 2` — Product name standardisation using `CASE` logic (handles 40+ raw variants)
- `STEP 3` — Location/zone cleaning and branch mapping 
- `STEP 4` — NULL handling and duplicate removal

**Analytics Queries (13 queries):**

| Query | Purpose |
|---|---|
| Q1 | Executive KPI — Total Target, Achievement, Gap % |
| Q2 | Quarter-wise trend — Q2 vs Q3 |
| Q3 | Zone-wise performance ranking |
| Q4 | Cluster-wise drill-down |
| Q5 | Branch ranking using `RANK()` window function |
| Q6 | Wealth Manager ranking using `RANK()` window function |
| Q7 | Product category performance |
| Q8 | QoQ growth by zone using CTE |
| Q9 | Q4 required run-rate by cluster |
| Q10 | Product contribution % to total business |
| Q11 | WM performance banding using CTE + CASE |
| Q12 | Top 3 gap products by zone using CTE + `RANK()` |
| Q13 | Zone × Product heatmap for Tableau |

---

## 📊 Dashboard Components

### Dashboard 1 — Business Intelligence & Action Center
| Component | Insight Delivered |
|---|---|
| 6 Executive KPI Tiles | Top Product, Highest Gap, Best Performer, Critical WMs, Near Target WMs, Q4 Priority |
| Q4 Runrate Bar Chart | Monthly run-rate required per product to close gap |
| Product Risk Bullet Chart | Achieved vs Target with diverging color by achievement % |
| Product Shortfall Bubble Chart | Gap size visualized by bubble area |
| WM Performance Segmentation | 4-band horizontal bar (Top/Near/Push/Critical) |
| Product Contribution Treemap | Revenue share by product |

### Dashboard 2 — Performance Command Center
| Component | Insight Delivered |
|---|---|
| Executive KPI Strip | ₹21.54B Achieved, 84.76%, ₹3.87B Gap |
| Quarterly Trend (Dumbbell) | Q2 ₹10.74B → Q3 ₹10.80B (+0.55% QoQ) |
| Zone Performance Ranking | Diverging bar chart — South leads, Greater Kolkata trails |
| Zone × Product Heatmap | 5×11 matrix showing every zone-product combination |
| Top 10 Wealth Managers | Bar chart with Top 3 highlighted in green |

### Tableau Story — 7 Story Points
1. `₹21.54B Achieved | 84.76% | ₹3.87B Gap Remaining` — Executive Overview
2. `QoQ Growth +0.55% — Acceleration Needed` — Quarterly Trend
3. `Kolkata South 91.2% Leads — Replicate in Greater Kolkata` — Zone Rankings
4. `CASA & Insurance Weak Across All Zones` — Product × Zone Heatmap
5. `HL & Deposits: Highest Gap ₹0.93B Each` — Product Risk Matrix
6. `39 WMs Need Intervention` — People Analytics
7. `Executive Recommendations` — Leadership Action Plan

---

## 📋 Executive Recommendations Generated

1. **Prioritize HL & Deposits** — highest volume products with ₹0.93B gap each
2. **Deploy Kolkata South playbook to Greater Kolkata** — 15.4% gap to bridge
3. **Immediate coaching for 5 Critical WMs** — before Q4 begins
4. **Cross-sell CASA, MF & Insurance** — systemic underperformance across all zones
5. **Monthly Q4 run-rate review with zone heads** — track progress weekly
6. **Recognize Top 3 WMs** — Sohini Pal (99%), Sohini Ghosh (97.7%), Sneha Ghosh (96.2%)

---

## 💬 Why This Matters for Indian Banking

This project is not just a portfolio piece. It is a **working demonstration** that:

- ✅ Any bank's existing Excel MIS data can be migrated to SQL + Tableau
- ✅ The transformation cost is minimal compared to the insight value generated
- ✅ Real-time performance visibility fundamentally changes how leadership makes decisions
- ✅ Tools exist today — MySQL is free, Tableau Public is free, the data already exists

**The barrier to transformation is not technology. It is awareness.**

---

## 📁 Repository Structure

```
wealth-mis-migration-dashboard/
├── data/
│   └── wealth_mis_final_cleaned.csv      ← Final cleaned dataset
├── sql/
│   └── wealth_mis_project_clean.sql      ← Full pipeline: setup → cleaning → analytics
├── assets/
│   ├── dashboard1.png                    ← BI & Action Center preview
│   └── dashboard2.png                    ← Command Center preview
└── README.md
```

---

## 🚀 How to Reproduce

```sql
-- Step 1: Run SQL file in MySQL Workbench
-- Step 2: Connect Tableau Desktop to MySQL
--         (Server: localhost, Database: wealth_mis_project,
--          Table: wealth_mis_final_cleaned)
-- Step 3: Recreate dashboards using field mapping in SQL comments
-- Step 4: Publish to Tableau Public
```
---
## 👤 Author

**Aquib Tahil**
BI Analyst | Tableau Developer | 9 Years BFSI | Ex-ICICI Bank | Ex-Axis Bank
Tableau Desktop Certified | MySQL | Power BI (PL-300 in progress)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Aquib%20Tahil-blue?logo=linkedin)](https://www.linkedin.com/in/aquibtahil/)
[![Tableau Public](https://img.shields.io/badge/Tableau-Public%20Profile-orange?logo=tableau)](https://public.tableau.com/app/profile/aquib.tahil8642)
[![GitHub](https://img.shields.io/badge/GitHub-aquib--tahil46-black?logo=github)](https://github.com/aquib-tahil46)

---

## 📂 Other Portfolio Projects

| Project | Tools | Link |
|---|---|---|
| Banking Transactions Analysis | MySQL + Tableau | [GitHub](https://github.com/aquib-tahil46/banking-transactions-analysis) |
| Fraud Detection Dashboard | MySQL + Tableau | [GitHub](https://github.com/aquib-tahil46/fraud-detection-tableau-dashboard) |
| Lending Club Risk Monitor | MySQL + Tableau | [GitHub](https://github.com/aquib-tahil46/Loan-Portfolio-Risk-Analysis-Lending-Club-2007-2013-) |
| BFSI Power BI Dashboard | MySQL + Power BI | [GitHub](https://github.com/aquib-tahil46/BFSI-PowerBI-dashboard) |
| **Wealth MIS Migration** | **MySQL + Tableau** | **You are here** |
