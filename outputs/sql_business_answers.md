# SQL Business Analysis — Solved Results

Executed against the final cleaned + segmented dataset.

## QQ01 — Total customers

```sql
SELECT COUNT(*) AS total_customers FROM customers_clean;
```

|   total_customers |
|------------------:|
|            100000 |

## QQ02 — Customer mix by city tier

```sql
SELECT city_tier, COUNT(*) AS customers,
 ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM customers_clean),2) AS share_pct
 FROM customers_clean GROUP BY city_tier ORDER BY customers DESC;
```

| city_tier   |   customers |   share_pct |
|:------------|------------:|------------:|
| Tier 2      |       44839 |       44.84 |
| Tier 1      |       30153 |       30.15 |
| Tier 3      |       25008 |       25.01 |

## QQ03 — Average income, balance and transactions by occupation

```sql
SELECT occupation, COUNT(*) AS customers,
 ROUND(AVG(annual_income),2) AS avg_income,
 ROUND(AVG(account_balance),2) AS avg_balance,
 ROUND(AVG(monthly_transaction_count),2) AS avg_monthly_txn
 FROM customers_clean GROUP BY occupation ORDER BY avg_income DESC;
```

| occupation          |   customers |   avg_income |   avg_balance |   avg_monthly_txn |
|:--------------------|------------:|-------------:|--------------:|------------------:|
| Student/Entry-Level |        7991 |       657769 |       86331.7 |             82.96 |
| Self-Employed       |       16030 |       655169 |       85892   |             82.77 |
| Professional        |       11757 |       653484 |       85732.6 |             83.08 |
| Salaried            |       49209 |       649501 |       84809.1 |             83.07 |
| Retired             |        4983 |       647818 |       85117.9 |             83.42 |
| Business Owner      |       10030 |       646678 |       84488.3 |             82.81 |

## QQ04 — Average credit limit by card category

```sql
SELECT card_category, COUNT(*) AS customers,
 ROUND(AVG(credit_limit),2) AS avg_credit_limit
 FROM customers_clean GROUP BY card_category ORDER BY avg_credit_limit DESC;
```

| card_category   |   customers |   avg_credit_limit |
|:----------------|------------:|-------------------:|
| Platinum        |        6984 |             393456 |
| Gold            |       17491 |             389399 |
| Classic         |       75525 |             324026 |

## QQ05 — Average card spend and utilization by card category

```sql
SELECT card_category,
 ROUND(AVG(credit_card_spend),2) AS avg_card_spend,
 ROUND(AVG(credit_utilization_ratio),3) AS avg_utilization
 FROM customers_clean GROUP BY card_category ORDER BY avg_card_spend DESC;
```

| card_category   |   avg_card_spend |   avg_utilization |
|:----------------|-----------------:|------------------:|
| Platinum        |          29605.7 |             0.247 |
| Gold            |          29246.9 |             0.247 |
| Classic         |          26608.5 |             0.255 |

## QQ06 — Digital behavior by city tier

```sql
SELECT city_tier, COUNT(*) AS customers,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio,
 ROUND(AVG(upi_transaction_share),3) AS avg_upi_share,
 ROUND(AVG(monthly_branch_visits),2) AS avg_branch_visits
 FROM customers_clean GROUP BY city_tier ORDER BY avg_digital_ratio DESC;
```

| city_tier   |   customers |   avg_digital_ratio |   avg_upi_share |   avg_branch_visits |
|:------------|------------:|--------------------:|----------------:|--------------------:|
| Tier 2      |       44839 |               0.598 |           0.603 |                3.04 |
| Tier 3      |       25008 |               0.597 |           0.603 |                3.04 |
| Tier 1      |       30153 |               0.597 |           0.603 |                3.05 |

## QQ07 — Customers with very high digital usage

```sql
SELECT customer_id, digital_transaction_ratio, upi_transaction_share,
 monthly_transaction_count
 FROM customers_clean WHERE digital_transaction_ratio >= 0.80
 ORDER BY digital_transaction_ratio DESC LIMIT 20;
```

| customer_id   |   digital_transaction_ratio |   upi_transaction_share |   monthly_transaction_count |
|:--------------|----------------------------:|------------------------:|----------------------------:|
| CUST000569    |                        0.99 |                  0.99   |                         113 |
| CUST000637    |                        0.99 |                  0.9671 |                         111 |
| CUST001015    |                        0.99 |                  0.8358 |                         125 |
| CUST001565    |                        0.99 |                  0.8126 |                         100 |
| CUST002401    |                        0.99 |                  0.8802 |                         106 |
| CUST002830    |                        0.99 |                  0.8886 |                         127 |
| CUST002854    |                        0.99 |                  0.7657 |                         118 |
| CUST003341    |                        0.99 |                  0.8707 |                         137 |
| CUST003658    |                        0.99 |                  0.7915 |                         119 |
| CUST003805    |                        0.99 |                  0.9424 |                         138 |
| CUST004400    |                        0.99 |                  0.9442 |                         122 |
| CUST004565    |                        0.99 |                  0.9725 |                         154 |
| CUST004689    |                        0.99 |                  0.8415 |                         146 |
| CUST004701    |                        0.99 |                  0.891  |                          80 |
| CUST005145    |                        0.99 |                  0.835  |                         101 |
| CUST005388    |                        0.99 |                  0.7681 |                         147 |
| CUST005596    |                        0.99 |                  0.8096 |                         129 |
| CUST005734    |                        0.99 |                  0.9679 |                         116 |
| CUST005744    |                        0.99 |                  0.9231 |                         118 |
| CUST005751    |                        0.99 |                  0.8831 |                         118 |

## QQ08 — Average loan-to-income and EMI burden by occupation

```sql
SELECT occupation,
 ROUND(AVG(loan_to_income_ratio),3) AS avg_loan_to_income,
 ROUND(AVG(emi_to_monthly_income_ratio),3) AS avg_emi_to_income
 FROM customers_clean GROUP BY occupation ORDER BY avg_loan_to_income DESC;
```

| occupation          |   avg_loan_to_income |   avg_emi_to_income |
|:--------------------|---------------------:|--------------------:|
| Retired             |                0.668 |               0.266 |
| Business Owner      |                0.666 |               0.263 |
| Student/Entry-Level |                0.665 |               0.264 |
| Salaried            |                0.665 |               0.265 |
| Self-Employed       |                0.661 |               0.265 |
| Professional        |                0.658 |               0.262 |

## QQ09 — Investment penetration by income band

```sql
SELECT CASE
 WHEN annual_income < 300000 THEN 'Below 3L'
 WHEN annual_income < 600000 THEN '3L-6L'
 WHEN annual_income < 1000000 THEN '6L-10L'
 ELSE '10L+'
 END AS income_band,
 COUNT(*) AS customers,
 ROUND(100.0*AVG(CASE WHEN investment_amount>0 THEN 1.0 ELSE 0.0 END),2) AS investment_penetration_pct
 FROM customers_clean GROUP BY income_band ORDER BY MIN(annual_income);
```

| income_band   |   customers |   investment_penetration_pct |
|:--------------|------------:|-----------------------------:|
| Below 3L      |        9033 |                        27    |
| 3L-6L         |       50018 |                        33.04 |
| 6L-10L        |       24403 |                        43.13 |
| 10L+          |       16546 |                        67.1  |

## QQ10 — Transaction activity by inactivity level

```sql
SELECT months_inactive_12_mon, COUNT(*) AS customers,
 ROUND(AVG(monthly_transaction_count),2) AS avg_txn_count,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio
 FROM customers_clean GROUP BY months_inactive_12_mon ORDER BY months_inactive_12_mon;
```

|   months_inactive_12_mon |   customers |   avg_txn_count |   avg_digital_ratio |
|-------------------------:|------------:|----------------:|--------------------:|
|                        0 |       16395 |          113.91 |               0.727 |
|                        1 |       21496 |          101.2  |               0.671 |
|                        2 |       18548 |           86    |               0.604 |
|                        3 |       14544 |           72.98 |               0.551 |
|                        4 |       10708 |           62.87 |               0.512 |
|                        5 |        7315 |           56.04 |               0.49  |
|                        6 |        4813 |           51.16 |               0.475 |
|                        7 |        2918 |           46.97 |               0.464 |
|                        8 |        1555 |           43.52 |               0.463 |
|                        9 |         890 |           40.71 |               0.451 |
|                       10 |         457 |           38.57 |               0.436 |
|                       11 |         203 |           37.21 |               0.448 |
|                       12 |         158 |           34.35 |               0.439 |

## QQ11 — Average balance by relationship count

```sql
SELECT total_relationship_count, COUNT(*) AS customers,
 ROUND(AVG(account_balance),2) AS avg_balance
 FROM customers_clean GROUP BY total_relationship_count ORDER BY avg_balance DESC;
```

|   total_relationship_count |   customers |   avg_balance |
|---------------------------:|------------:|--------------:|
|                          6 |        4329 |      186285   |
|                          5 |        6093 |      143718   |
|                          4 |       12732 |      114084   |
|                          3 |       22824 |       87409.6 |
|                          2 |       30730 |       68206.9 |
|                          1 |       23292 |       55554.1 |

## QQ12 — High utilization plus active loan count

```sql
SELECT COUNT(*) AS customers
 FROM customers_clean
 WHERE credit_utilization_ratio >= 0.50 AND loan_amount > 0;
```

|   customers |
|------------:|
|       10076 |

## QQ13 — High-investment / low-activity customers

```sql
SELECT customer_id, investment_amount, monthly_transaction_count, annual_income
 FROM customers_clean WHERE investment_amount > 0 AND monthly_transaction_count <= 35
 ORDER BY investment_amount DESC LIMIT 25;
```

| customer_id   |   investment_amount |   monthly_transaction_count |    annual_income |
|:--------------|--------------------:|----------------------------:|-----------------:|
| CUST095442    |              651049 |                          35 |      1.68496e+06 |
| CUST099576    |              603276 |                          35 |      2.02271e+06 |
| CUST060775    |              515763 |                          28 |      1.18955e+06 |
| CUST039058    |              336939 |                          29 | 806812           |
| CUST056716    |              333002 |                          35 |      1.84277e+06 |
| CUST088989    |              319814 |                          28 |      1.19545e+06 |
| CUST008329    |              318362 |                          14 | 752988           |
| CUST006609    |              315612 |                          33 | 595236           |
| CUST078995    |              282146 |                          27 | 928295           |
| CUST052629    |              263874 |                          32 | 956462           |
| CUST066505    |              249818 |                          25 |      1.16462e+06 |
| CUST085633    |              239952 |                          32 |      1.2402e+06  |
| CUST058098    |              226813 |                          35 |      1.25291e+06 |
| CUST038635    |              222630 |                          31 | 515184           |
| CUST099871    |              221746 |                          33 | 673119           |
| CUST099210    |              211694 |                          35 | 786410           |
| CUST035301    |              202539 |                          34 | 991731           |
| CUST050512    |              198922 |                          28 |      1.05744e+06 |
| CUST090713    |              196294 |                          29 |      1.2758e+06  |
| CUST001201    |              192917 |                          32 | 791310           |
| CUST069313    |              186204 |                          35 |      1.12908e+06 |
| CUST086673    |              179302 |                          32 | 721588           |
| CUST063195    |              178842 |                          33 | 718742           |
| CUST043995    |              178442 |                          30 |      1.30431e+06 |
| CUST043712    |              178306 |                          35 |      1.30407e+06 |

## QQ14 — EMI burden by card category

```sql
SELECT card_category,
 ROUND(AVG(emi_to_monthly_income_ratio),3) AS avg_emi_burden
 FROM customers_clean GROUP BY card_category ORDER BY avg_emi_burden DESC;
```

| card_category   |   avg_emi_burden |
|:----------------|-----------------:|
| Classic         |            0.27  |
| Gold            |            0.248 |
| Platinum        |            0.24  |

## QQ15 — Transaction quartiles and digital ratio using NTILE

```sql
WITH q AS (
 SELECT *, NTILE(4) OVER (ORDER BY monthly_transaction_count) AS txn_quartile
 FROM customers_clean)
 SELECT txn_quartile, COUNT(*) AS customers,
 MIN(monthly_transaction_count) AS min_txn,
 MAX(monthly_transaction_count) AS max_txn,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio
 FROM q GROUP BY txn_quartile ORDER BY txn_quartile;
```

|   txn_quartile |   customers |   min_txn |   max_txn |   avg_digital_ratio |
|---------------:|------------:|----------:|----------:|--------------------:|
|              1 |       25000 |         9 |        55 |               0.45  |
|              2 |       25000 |        55 |        80 |               0.515 |
|              3 |       25000 |        80 |       110 |               0.646 |
|              4 |       25000 |       110 |       198 |               0.779 |

## QQ16 — Branch usage by salary-credit frequency

```sql
SELECT CASE
 WHEN salary_credit_frequency < 0.40 THEN 'Low'
 WHEN salary_credit_frequency < 0.80 THEN 'Medium'
 ELSE 'High' END AS salary_credit_band,
 COUNT(*) AS customers,
 ROUND(AVG(monthly_branch_visits),2) AS avg_branch_visits
 FROM customers_clean GROUP BY salary_credit_band ORDER BY avg_branch_visits DESC;
```

| salary_credit_band   |   customers |   avg_branch_visits |
|:---------------------|------------:|--------------------:|
| Low                  |       16766 |                3.13 |
| Medium               |       26925 |                3.09 |
| High                 |       56309 |                3    |

## QQ17 — Card-spend share by category

```sql
SELECT card_category, ROUND(AVG(card_spend_share),3) AS avg_card_spend_share
 FROM customers_clean GROUP BY card_category ORDER BY avg_card_spend_share DESC;
```

| card_category   |   avg_card_spend_share |
|:----------------|-----------------------:|
| Classic         |                  0.259 |
| Platinum        |                  0.257 |
| Gold            |                  0.256 |

## QQ18 — Average credit limit by income band

```sql
SELECT CASE
 WHEN annual_income<300000 THEN 'Below 3L'
 WHEN annual_income<600000 THEN '3L-6L'
 WHEN annual_income<1000000 THEN '6L-10L'
 ELSE '10L+' END AS income_band,
 COUNT(*) AS customers,
 ROUND(AVG(credit_limit),2) AS avg_credit_limit
 FROM customers_clean GROUP BY income_band ORDER BY avg_credit_limit DESC;
```

| income_band   |   customers |   avg_credit_limit |
|:--------------|------------:|-------------------:|
| 10L+          |       16546 |             686137 |
| 6L-10L        |       24403 |             391680 |
| 3L-6L         |       50018 |             235865 |
| Below 3L      |        9033 |             146401 |

## QQ19 — Service calls by inactivity band

```sql
SELECT CASE
 WHEN months_inactive_12_mon<=2 THEN '0-2'
 WHEN months_inactive_12_mon<=5 THEN '3-5'
 ELSE '6+' END AS inactivity_band,
 COUNT(*) AS customers, ROUND(AVG(customer_service_calls),2) AS avg_service_calls
 FROM customers_clean GROUP BY inactivity_band ORDER BY avg_service_calls DESC;
```

| inactivity_band   |   customers |   avg_service_calls |
|:------------------|------------:|--------------------:|
| 6+                |       10994 |                2.75 |
| 3-5               |       32567 |                2.5  |
| 0-2               |       56439 |                2.02 |

## QQ20 — Digital ratio by branch usage

```sql
SELECT CASE
 WHEN monthly_branch_visits=0 THEN '0 visits'
 WHEN monthly_branch_visits<=3 THEN '1-3 visits'
 ELSE '4+ visits' END AS branch_usage_band,
 COUNT(*) AS customers,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio
 FROM customers_clean GROUP BY branch_usage_band ORDER BY avg_digital_ratio DESC;
```

| branch_usage_band   |   customers |   avg_digital_ratio |
|:--------------------|------------:|--------------------:|
| 0 visits            |       11494 |               0.788 |
| 1-3 visits          |       50880 |               0.64  |
| 4+ visits           |       37626 |               0.482 |

## QQ21 — Customers by K-Means segment

```sql
SELECT segment_name, COUNT(*) AS customers,
 ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM customer_segments),2) AS share_pct
 FROM customer_segments GROUP BY segment_name ORDER BY customers DESC;
```

| segment_name           |   customers |   share_pct |
|:-----------------------|------------:|------------:|
| Core Retail            |       37977 |       37.98 |
| Digital Active         |       25664 |       25.66 |
| Affluent Under-Engaged |       22208 |       22.21 |
| Credit Active          |       14151 |       14.15 |

## QQ22 — Financial profile by segment

```sql
SELECT segment_name,
 ROUND(AVG(annual_income),2) AS avg_income,
 ROUND(AVG(account_balance),2) AS avg_balance,
 ROUND(AVG(credit_limit),2) AS avg_credit_limit,
 ROUND(AVG(investment_amount),2) AS avg_investment
 FROM customer_segments GROUP BY segment_name ORDER BY avg_income DESC;
```

| segment_name           |      avg_income |   avg_balance |   avg_credit_limit |   avg_investment |
|:-----------------------|----------------:|--------------:|-------------------:|-----------------:|
| Affluent Under-Engaged |      1.1784e+06 |      202985   |             629140 |        138040    |
| Credit Active          | 717392          |       78097.1 |             372230 |         31691.7  |
| Core Retail            | 479379          |       49030.8 |             249817 |         12532.7  |
| Digital Active         | 412647          |       40700.1 |             206682 |          8661.63 |

## QQ23 — Transaction activity by segment

```sql
SELECT segment_name,
 ROUND(AVG(monthly_transaction_count),2) AS avg_txn_count,
 ROUND(AVG(monthly_transaction_amount),2) AS avg_txn_amount
 FROM customer_segments GROUP BY segment_name ORDER BY avg_txn_count DESC;
```

| segment_name           |   avg_txn_count |   avg_txn_amount |
|:-----------------------|----------------:|-----------------:|
| Digital Active         |          120.37 |         110064   |
| Credit Active          |           97.45 |         126278   |
| Affluent Under-Engaged |           83.26 |         157591   |
| Core Retail            |           52.23 |          47532.8 |

## QQ24 — Digital activity by segment

```sql
SELECT segment_name,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio,
 ROUND(AVG(upi_transaction_share),3) AS avg_upi_share
 FROM customer_segments GROUP BY segment_name ORDER BY avg_digital_ratio DESC;
```

| segment_name           |   avg_digital_ratio |   avg_upi_share |
|:-----------------------|--------------------:|----------------:|
| Digital Active         |               0.82  |           0.824 |
| Affluent Under-Engaged |               0.615 |           0.622 |
| Credit Active          |               0.576 |           0.575 |
| Core Retail            |               0.444 |           0.453 |

## QQ25 — Credit dependence by segment

```sql
SELECT segment_name,
 ROUND(AVG(credit_utilization_ratio),3) AS avg_utilization,
 ROUND(AVG(loan_to_income_ratio),3) AS avg_loan_to_income,
 ROUND(AVG(emi_to_monthly_income_ratio),3) AS avg_emi_to_income
 FROM customer_segments GROUP BY segment_name ORDER BY avg_utilization DESC;
```

| segment_name           |   avg_utilization |   avg_loan_to_income |   avg_emi_to_income |
|:-----------------------|------------------:|---------------------:|--------------------:|
| Credit Active          |             0.611 |                1.246 |               0.522 |
| Digital Active         |             0.236 |                0.767 |               0.302 |
| Core Retail            |             0.207 |                0.637 |               0.248 |
| Affluent Under-Engaged |             0.123 |                0.22  |               0.083 |

## QQ26 — Investment penetration by segment

```sql
SELECT segment_name,
 ROUND(100.0*AVG(CASE WHEN investment_amount>0 THEN 1.0 ELSE 0.0 END),2) AS investment_penetration_pct
 FROM customer_segments GROUP BY segment_name ORDER BY investment_penetration_pct DESC;
```

| segment_name           |   investment_penetration_pct |
|:-----------------------|-----------------------------:|
| Affluent Under-Engaged |                        67.26 |
| Credit Active          |                        44.36 |
| Core Retail            |                        31.8  |
| Digital Active         |                        28.44 |

## QQ27 — High-balance inactive customers by segment

```sql
WITH t AS (SELECT AVG(account_balance) AS avg_balance FROM customer_segments)
 SELECT segment_name, COUNT(*) AS customers
 FROM customer_segments, t
 WHERE account_balance>t.avg_balance AND months_inactive_12_mon>=6
 GROUP BY segment_name ORDER BY customers DESC;
```

| segment_name           |   customers |
|:-----------------------|------------:|
| Affluent Under-Engaged |        1289 |
| Core Retail            |         396 |
| Credit Active          |         107 |
| Digital Active         |           1 |

## QQ28 — Relationship depth by segment

```sql
SELECT segment_name,
 ROUND(AVG(total_relationship_count),2) AS avg_relationship_count
 FROM customer_segments GROUP BY segment_name ORDER BY avg_relationship_count DESC;
```

| segment_name           |   avg_relationship_count |
|:-----------------------|-------------------------:|
| Affluent Under-Engaged |                     3.54 |
| Credit Active          |                     2.75 |
| Core Retail            |                     2.29 |
| Digital Active         |                     2.18 |

## QQ29 — Card mix within each segment using a window function

```sql
SELECT segment_name, card_category, COUNT(*) AS customers,
 ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER (PARTITION BY segment_name),2) AS within_segment_pct
 FROM customer_segments GROUP BY segment_name, card_category
 ORDER BY segment_name, customers DESC;
```

| segment_name           | card_category   |   customers |   within_segment_pct |
|:-----------------------|:----------------|------------:|---------------------:|
| Affluent Under-Engaged | Classic         |       14659 |                66.01 |
| Affluent Under-Engaged | Gold            |        5393 |                24.28 |
| Affluent Under-Engaged | Platinum        |        2156 |                 9.71 |
| Core Retail            | Classic         |       29825 |                78.53 |
| Core Retail            | Gold            |        5840 |                15.38 |
| Core Retail            | Platinum        |        2312 |                 6.09 |
| Credit Active          | Classic         |       10467 |                73.97 |
| Credit Active          | Gold            |        2636 |                18.63 |
| Credit Active          | Platinum        |        1048 |                 7.41 |
| Digital Active         | Classic         |       20574 |                80.17 |
| Digital Active         | Gold            |        3622 |                14.11 |
| Digital Active         | Platinum        |        1468 |                 5.72 |

## QQ30 — High-balance / low-digital customers

```sql
SELECT customer_id, account_balance, digital_transaction_ratio, monthly_branch_visits
 FROM customer_segments
 WHERE account_balance>(SELECT AVG(account_balance) FROM customer_segments)
 AND digital_transaction_ratio<0.30
 ORDER BY account_balance DESC LIMIT 25;
```

| customer_id   |   account_balance |   digital_transaction_ratio |   monthly_branch_visits |
|:--------------|------------------:|----------------------------:|------------------------:|
| CUST066982    |            278521 |                      0.2873 |                       3 |
| CUST027882    |            260531 |                      0.2975 |                       7 |
| CUST046296    |            253992 |                      0.2959 |                       7 |
| CUST004172    |            226081 |                      0.2509 |                       5 |
| CUST048240    |            224725 |                      0.2673 |                       3 |
| CUST069702    |            220440 |                      0.2697 |                       3 |
| CUST059586    |            218208 |                      0.2494 |                       2 |
| CUST046496    |            214131 |                      0.2947 |                       4 |
| CUST022757    |            209503 |                      0.144  |                       6 |
| CUST013032    |            196994 |                      0.2792 |                       7 |
| CUST001067    |            188664 |                      0.2742 |                       8 |
| CUST082302    |            187791 |                      0.2305 |                       7 |
| CUST011627    |            185111 |                      0.2398 |                       5 |
| CUST021912    |            176312 |                      0.2979 |                       1 |
| CUST025433    |            170022 |                      0.2989 |                       4 |
| CUST050231    |            160242 |                      0.2884 |                       3 |
| CUST092736    |            152566 |                      0.2821 |                       4 |
| CUST042546    |            147186 |                      0.2639 |                       2 |
| CUST076861    |            143380 |                      0.2742 |                       2 |
| CUST037361    |            140083 |                      0.286  |                      11 |
| CUST025994    |            134304 |                      0.1972 |                       7 |
| CUST022605    |            132785 |                      0.2881 |                       8 |
| CUST098453    |            131801 |                      0.2738 |                       4 |
| CUST025610    |            130577 |                      0.2405 |                       8 |
| CUST078396    |            127794 |                      0.2894 |                       5 |

## QQ31 — Segments above overall averages on income and activity

```sql
SELECT segment_name,
 ROUND(AVG(annual_income),2) AS avg_income,
 ROUND(AVG(monthly_transaction_count),2) AS avg_txn_count
 FROM customer_segments
 GROUP BY segment_name
 HAVING AVG(annual_income)>(SELECT AVG(annual_income) FROM customer_segments)
 AND AVG(monthly_transaction_count)>(SELECT AVG(monthly_transaction_count) FROM customer_segments)
 ORDER BY avg_income DESC;
```

| segment_name           |      avg_income |   avg_txn_count |
|:-----------------------|----------------:|----------------:|
| Affluent Under-Engaged |      1.1784e+06 |           83.26 |
| Credit Active          | 717392          |           97.45 |

## QQ32 — Digital vs physical banking by segment

```sql
SELECT segment_name,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio,
 ROUND(AVG(monthly_branch_visits),2) AS avg_branch_visits,
 ROUND(AVG(monthly_cash_withdrawals),2) AS avg_cash_withdrawals
 FROM customer_segments GROUP BY segment_name
 ORDER BY avg_digital_ratio DESC;
```

| segment_name           |   avg_digital_ratio |   avg_branch_visits |   avg_cash_withdrawals |
|:-----------------------|--------------------:|--------------------:|-----------------------:|
| Digital Active         |               0.82  |                1.23 |                   2.01 |
| Affluent Under-Engaged |               0.615 |                2.94 |                   4.87 |
| Credit Active          |               0.576 |                3.14 |                   5.38 |
| Core Retail            |               0.444 |                4.3  |                   7.3  |

