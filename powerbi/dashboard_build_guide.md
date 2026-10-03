# 3-Page Power BI Dashboard

## Import
Use ONLY: `powerbi/customer_segments_powerbi.csv`
Rename table: `CustomerSegments`

## Page 1 — Retail Banking Customer Overview
Goal: understand the customer base.

KPI cards: Total Customers; Average Annual Income; Average Account Balance; Average Monthly Transactions.

Visuals:
1. Column — customer count by City Tier
2. Donut — customer count by Card Category
3. Scatter — Annual Income vs Account Balance; size = Monthly Transaction Amount; legend = Card Category
4. Column — Transaction Count Band vs Customers
5. Scatter — Digital Transaction Ratio vs Monthly Branch Visits; size = Account Balance; legend = Card Category

Slicers: City Tier, Occupation, Card Category

## Page 2 — Customer Segmentation Deep Dive
Goal: explain the K-Means clusters.

KPI cards: Total Customers; Average Balance; Average Monthly Transactions; Average Digital Usage.

Visuals:
1. Donut — Customer Count by Segment
2. Clustered columns — Average Income and Average Balance by Segment
3. Bar — Average Monthly Transactions by Segment
4. Column — Average Digital Usage by Segment
5. Scatter — Credit Limit vs Credit Utilization; size = Loan Amount; legend = Segment
6. Matrix — segment + customers + average income + average balance + transactions + digital usage + utilization + inactivity

Slicers: Segment Name, Card Category, City Tier

## Page 3 — Business Opportunities & Insights
Goal: translate the analytical segments into management insights.

KPI cards: Affluent Under-Engaged Customers; Investment Penetration %; Active Customers %; Average Relationship Count.

Visuals:
1. Bar — Investment Penetration % by Segment
2. Column — Average Months Inactive by Segment
3. Bar — Average Relationship Count by Segment
4. Scatter — Digital Transaction Ratio vs Branch Visits; size = Account Balance; legend = Segment
5. Matrix — segment + customer count + avg income + avg balance + avg transactions + digital usage + investment penetration + inactivity

Narrative:
Prime Engaged — higher financial capacity and stronger activity.
Digital Active — strong digital and transaction engagement.
Credit Active — higher credit utilization / loan dependence with active behavior.
Affluent Under-Engaged — higher financial capacity with relatively weaker recent activity.

These are analytical segment descriptions, not automated product recommendations for individuals.
