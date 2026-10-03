# Customer Segmentation & Cross-Sell Analytics for Retail Banking

A data analytics and machine learning project that segments retail banking customers based on **financial capacity, engagement, credit dependence, and digital behavior**, then converts the resulting segments into actionable business insights through **SQL, Python, and Power BI**.

> **Important:** The dataset used in this project is synthetic and was created to represent realistic retail-banking customer behavior. It is **not ICICI Bank customer data** and does not represent actual ICICI customer behavior.

---

## Project Overview

Banks serve customers with very different financial profiles and engagement patterns. Treating every customer in the same way can make relationship-management and product-analysis less effective.

This project addresses the analytical question:

> **Can customers be grouped into meaningful behavioral segments using financial, transactional, credit, and digital-banking characteristics?**

The project builds a complete analytics pipeline:

```text
Synthetic Customer Dataset
          ↓
Data Cleaning & Validation
          ↓
Exploratory Data Analysis
          ↓
SQL Business Analysis
          ↓
Feature Engineering
          ↓
Weighted Behavioral Indices
          ↓
Standardization
          ↓
K-Means Clustering
          ↓
Cluster Evaluation
          ↓
Segment Profiling
          ↓
Power BI Dashboard
          ↓
Business Insights & Opportunities
```

---

## Objectives

The main objectives of the project are:

1. Analyze customer financial, transactional, credit, and digital behavior.
2. Identify meaningful customer groups using unsupervised machine learning.
3. Profile each segment using business-relevant metrics.
4. Build an interactive Power BI dashboard for customer and segment analysis.
5. Identify analytical opportunities for relationship management and cross-sell planning.

---

## Dataset

A synthetic dataset containing **100,000 customer records** was created because real bank customer-level data is confidential.

The dataset is intentionally **unequal and overlapping** rather than being artificially balanced. Financial variables also follow realistic skewed distributions, while behavioral variables contain variation and noise.

### Dataset Characteristics

- **100,000 customers**
- **28 columns**
- Financial attributes
- Transactional behavior
- Credit behavior
- Digital-banking behavior
- Relationship/product information
- Customer profiling attributes

### Key Variables

| Variable | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `annual_income` | Annual customer income |
| `account_balance` | Customer account balance |
| `investment_amount` | Investment amount |
| `monthly_transaction_count` | Monthly number of transactions |
| `monthly_transaction_amount` | Monthly transaction amount |
| `digital_transaction_ratio` | Share of transactions performed digitally |
| `upi_transaction_share` | Share of transactions through UPI |
| `credit_limit` | Assigned credit limit |
| `credit_utilization_ratio` | Credit utilization percentage |
| `loan_amount` | Outstanding loan amount |
| `emi_to_income_ratio` | EMI relative to income |
| `months_inactive_12_mon` | Months inactive during the observation period |
| `total_relationship_count` | Number of banking product relationships |
| `card_category` | Customer card category |
| `city_tier` | City classification |
| `occupation` | Occupation category |

Demographic/profile fields such as `gender`, `city_tier`, and `occupation` are used mainly for **post-clustering analysis and profiling**, rather than as primary clustering drivers.

---

## Feature Engineering

Instead of sending every raw variable directly into K-Means, the project creates four higher-level behavioral indices.

### 1. Financial Capacity

Measures the customer's overall financial strength using:

- Annual income — **55%**
- Account balance — **30%**
- Investment amount — **15%**

Overall contribution to clustering:

**35%**

---

### 2. Engagement

Measures transaction and relationship activity using:

- Monthly transaction count — **45%**
- Monthly transaction amount — **25%**
- Digital transaction ratio — **15%**
- Recency/activity score — **10%**
- Relationship count — **5%**

Overall contribution:

**30%**

---

### 3. Credit Dependence

Measures reliance on credit and borrowing using:

- Credit utilization — **40%**
- Loan amount — **35%**
- EMI-to-income ratio — **25%**

Overall contribution:

**20%**

---

### 4. Digital Behavior

Measures preference for digital banking using:

- Digital transaction ratio — **70%**
- UPI transaction share — **30%**

Overall contribution:

**15%**

---

## Why Weighted Indices?

The purpose of weighting is to prevent every behavioral dimension from contributing equally by default.

The project emphasizes:

```text
Financial Capacity     → 35%
Engagement             → 30%
Credit Dependence      → 20%
Digital Behavior       → 15%
```

The weighted indices are standardized before clustering.

The K-Means distance calculation is adjusted using the square root of these weights so that the intended relative importance is preserved in Euclidean distance.

---

## Clustering Method

### Algorithm

**K-Means Clustering**

The engineered behavioral indices are standardized using `StandardScaler`, followed by K-Means clustering.

The number of clusters is tested rather than assumed.

### K Evaluation

The project evaluates:

- K = 2
- K = 3
- K = 4
- K = 5
- K = 6

using **Silhouette Score**.

| K | Silhouette Score |
|---:|---:|
| 2 | 0.3031 |
| 3 | 0.3550 |
| **4** | **0.3655** |
| 5 | 0.3246 |
| 6 | 0.2952 |

### Selected K

**K = 4**

K = 4 produced the highest silhouette score among the evaluated values and also provided a useful level of business interpretability.

---

## Customer Segments

After clustering, the clusters are profiled using their behavioral characteristics and assigned descriptive names.

### Prime Engaged

Customers showing relatively strong financial capacity and active engagement.

### Digital Active

Customers characterized by stronger digital usage and transaction engagement.

### Credit Active

Customers showing relatively higher credit utilization and loan dependence along with active behavior.

### Affluent Under-Engaged

Customers with relatively higher financial capacity but lower recent engagement.

> Segment names are assigned **after clustering and profiling**. They are not model inputs and are not used to create the clusters.

---

## SQL Business Analysis

SQL is used to answer business-oriented questions before and after segmentation.

Examples include:

- Customer count by city tier
- Average balance by card category
- High-income customer identification
- Transaction behavior analysis
- Credit utilization analysis
- Segment-level comparisons
- Product/relationship depth
- Investment adoption patterns

The SQL analysis helps connect the machine-learning output to practical business interpretation.

---

## Power BI Dashboard

A **3-page Power BI dashboard** was developed to communicate the analysis.

### Page 1 — Retail Banking Customer Overview

Focuses on the overall customer base.

Key elements:

- Total customers
- Average annual income
- Average account balance
- Average monthly transactions
- Customer distribution by city tier
- Card category mix
- Income vs account balance
- Transaction behavior
- Digital vs branch behavior

---

### Page 2 — Customer Segmentation Deep Dive

Focuses on understanding the four customer segments.

Key elements:

- Segment distribution
- Financial profile by segment
- Engagement by segment
- Digital banking behavior
- Credit behavior
- Segment profile matrix

---

### Page 3 — Business Opportunities & Customer Insights

Focuses on analytical interpretation of the segments.

Key elements:

- Investment penetration by segment
- Customer inactivity
- Relationship depth
- Digital vs branch behavior
- Segment opportunity matrix
- Customer engagement funnel

### Engagement Funnel

The funnel is an **analytical engagement funnel**, not a real sales-conversion funnel.

The stages are sequential:

```text
All Customers
      ↓
Active Customers
      ↓
Digitally Engaged
      ↓
Highly Transacting
      ↓
Deep Banking Relationship
```

The funnel uses behavioral thresholds to understand how the customer base narrows as engagement and relationship depth increase.

The dataset does not contain actual campaign-conversion outcomes.

---

## Technology Stack

### Programming & Analytics
- Python
- Pandas
- NumPy
- Scikit-Learn

### Machine Learning
- K-Means Clustering
- StandardScaler
- Silhouette Score

### Database & Querying
- SQL
- PostgreSQL / MySQL compatible queries

### Visualization
- Power BI
- Matplotlib

### Analytical Techniques
- Exploratory Data Analysis
- Feature Engineering
- Weighted Behavioral Indices
- Unsupervised Learning
- Customer Profiling
- Business Analysis

---

## Project Structure

```text
Customer-Segmentation-Project/
│
├── data/
│   ├── raw_source_copy.csv
│   ├── retail_banking_customer_segmentation_100k_raw.csv
│   └── customer_data_clean.csv
│
├── notebooks/
│   ├── 01_EDA_Line_By_Line.ipynb
│   └── 02_Feature_Engineering_KMeans.ipynb
│
├── python/
│   ├── 01_clean_data.py
│   ├── 02_feature_engineering_kmeans.py
│   └── 03_powerbi_export.py
│
├── sql/
│   ├── schema.sql
│   └── business_analysis.sql
│
├── outputs/
│   ├── customer_segments_powerbi.csv
│   ├── engineered_indices.csv
│   ├── kmeans_selection.csv
│   ├── segment_profile.csv
│   ├── segment_sizes.csv
│   ├── segment_diagnostics.csv
│   ├── sql_business_answers.md
│   ├── data_dictionary.csv
│   ├── data_quality_checks.csv
│   └── interview_talking_points.md
│
├── figures/
│   └── EDA and clustering visualizations
│
├── database/
│   └── customer_segmentation.db
│
├── powerbi/
│   ├── customer_segments_powerbi.csv
│   ├── dashboard_build_guide.md
│   ├── measures_DAX.txt
│   └── theme.json
│
└── README.md
```

---

## How to Run

### 1. Install dependencies

```bash
pip install pandas numpy scikit-learn matplotlib jupyter
```

### 2. Run data cleaning

```bash
python python/01_clean_data.py
```

### 3. Run feature engineering and clustering

```bash
python python/02_feature_engineering_kmeans.py
```

### 4. Export Power BI data

```bash
python python/03_powerbi_export.py
```

### 5. Open the notebooks

```bash
jupyter notebook
```

Then open the notebooks in the `notebooks/` directory.

---

## Key Analytical Takeaways

The project demonstrates how customer-level banking data can be transformed into a structured behavioral segmentation framework.

The main analytical dimensions are:

```text
Financial Strength
       +
Customer Engagement
       +
Credit Dependence
       +
Digital Behavior
       ↓
Customer Segmentation
       ↓
Segment Profiling
       ↓
Business Opportunities
```

The resulting segments can support analytical use cases such as:

- Relationship-manager prioritization
- Customer engagement analysis
- Product penetration analysis
- Digital adoption analysis
- Investment adoption analysis
- Credit-behavior analysis
- Cross-sell opportunity exploration
---
