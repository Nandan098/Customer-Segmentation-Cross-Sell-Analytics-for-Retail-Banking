-- ICICI Customer Segmentation: 32 Business Questions
-- SQLite-compatible

-- Q01: Total customers
SELECT COUNT(*) AS total_customers FROM customers_clean;
-- Q02: Customer mix by city tier
SELECT city_tier, COUNT(*) AS customers,
 ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM customers_clean),2) AS share_pct
 FROM customers_clean GROUP BY city_tier ORDER BY customers DESC;
-- Q03: Average income, balance and transactions by occupation
SELECT occupation, COUNT(*) AS customers,
 ROUND(AVG(annual_income),2) AS avg_income,
 ROUND(AVG(account_balance),2) AS avg_balance,
 ROUND(AVG(monthly_transaction_count),2) AS avg_monthly_txn
 FROM customers_clean GROUP BY occupation ORDER BY avg_income DESC;
-- Q04: Average credit limit by card category
SELECT card_category, COUNT(*) AS customers,
 ROUND(AVG(credit_limit),2) AS avg_credit_limit
 FROM customers_clean GROUP BY card_category ORDER BY avg_credit_limit DESC;
-- Q05: Average card spend and utilization by card category
SELECT card_category,
 ROUND(AVG(credit_card_spend),2) AS avg_card_spend,
 ROUND(AVG(credit_utilization_ratio),3) AS avg_utilization
 FROM customers_clean GROUP BY card_category ORDER BY avg_card_spend DESC;
-- Q06: Digital behavior by city tier
SELECT city_tier, COUNT(*) AS customers,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio,
 ROUND(AVG(upi_transaction_share),3) AS avg_upi_share,
 ROUND(AVG(monthly_branch_visits),2) AS avg_branch_visits
 FROM customers_clean GROUP BY city_tier ORDER BY avg_digital_ratio DESC;
-- Q07: Customers with very high digital usage
SELECT customer_id, digital_transaction_ratio, upi_transaction_share,
 monthly_transaction_count
 FROM customers_clean WHERE digital_transaction_ratio >= 0.80
 ORDER BY digital_transaction_ratio DESC LIMIT 20;
-- Q08: Average loan-to-income and EMI burden by occupation
SELECT occupation,
 ROUND(AVG(loan_to_income_ratio),3) AS avg_loan_to_income,
 ROUND(AVG(emi_to_monthly_income_ratio),3) AS avg_emi_to_income
 FROM customers_clean GROUP BY occupation ORDER BY avg_loan_to_income DESC;
-- Q09: Investment penetration by income band
SELECT CASE
 WHEN annual_income < 300000 THEN 'Below 3L'
 WHEN annual_income < 600000 THEN '3L-6L'
 WHEN annual_income < 1000000 THEN '6L-10L'
 ELSE '10L+'
 END AS income_band,
 COUNT(*) AS customers,
 ROUND(100.0*AVG(CASE WHEN investment_amount>0 THEN 1.0 ELSE 0.0 END),2) AS investment_penetration_pct
 FROM customers_clean GROUP BY income_band ORDER BY MIN(annual_income);
-- Q10: Transaction activity by inactivity level
SELECT months_inactive_12_mon, COUNT(*) AS customers,
 ROUND(AVG(monthly_transaction_count),2) AS avg_txn_count,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio
 FROM customers_clean GROUP BY months_inactive_12_mon ORDER BY months_inactive_12_mon;
-- Q11: Average balance by relationship count
SELECT total_relationship_count, COUNT(*) AS customers,
 ROUND(AVG(account_balance),2) AS avg_balance
 FROM customers_clean GROUP BY total_relationship_count ORDER BY avg_balance DESC;
-- Q12: High utilization plus active loan count
SELECT COUNT(*) AS customers
 FROM customers_clean
 WHERE credit_utilization_ratio >= 0.50 AND loan_amount > 0;
-- Q13: High-investment / low-activity customers
SELECT customer_id, investment_amount, monthly_transaction_count, annual_income
 FROM customers_clean WHERE investment_amount > 0 AND monthly_transaction_count <= 35
 ORDER BY investment_amount DESC LIMIT 25;
-- Q14: EMI burden by card category
SELECT card_category,
 ROUND(AVG(emi_to_monthly_income_ratio),3) AS avg_emi_burden
 FROM customers_clean GROUP BY card_category ORDER BY avg_emi_burden DESC;
-- Q15: Transaction quartiles and digital ratio using NTILE
WITH q AS (
 SELECT *, NTILE(4) OVER (ORDER BY monthly_transaction_count) AS txn_quartile
 FROM customers_clean)
 SELECT txn_quartile, COUNT(*) AS customers,
 MIN(monthly_transaction_count) AS min_txn,
 MAX(monthly_transaction_count) AS max_txn,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio
 FROM q GROUP BY txn_quartile ORDER BY txn_quartile;
-- Q16: Branch usage by salary-credit frequency
SELECT CASE
 WHEN salary_credit_frequency < 0.40 THEN 'Low'
 WHEN salary_credit_frequency < 0.80 THEN 'Medium'
 ELSE 'High' END AS salary_credit_band,
 COUNT(*) AS customers,
 ROUND(AVG(monthly_branch_visits),2) AS avg_branch_visits
 FROM customers_clean GROUP BY salary_credit_band ORDER BY avg_branch_visits DESC;
-- Q17: Card-spend share by category
SELECT card_category, ROUND(AVG(card_spend_share),3) AS avg_card_spend_share
 FROM customers_clean GROUP BY card_category ORDER BY avg_card_spend_share DESC;
-- Q18: Average credit limit by income band
SELECT CASE
 WHEN annual_income<300000 THEN 'Below 3L'
 WHEN annual_income<600000 THEN '3L-6L'
 WHEN annual_income<1000000 THEN '6L-10L'
 ELSE '10L+' END AS income_band,
 COUNT(*) AS customers,
 ROUND(AVG(credit_limit),2) AS avg_credit_limit
 FROM customers_clean GROUP BY income_band ORDER BY avg_credit_limit DESC;
-- Q19: Service calls by inactivity band
SELECT CASE
 WHEN months_inactive_12_mon<=2 THEN '0-2'
 WHEN months_inactive_12_mon<=5 THEN '3-5'
 ELSE '6+' END AS inactivity_band,
 COUNT(*) AS customers, ROUND(AVG(customer_service_calls),2) AS avg_service_calls
 FROM customers_clean GROUP BY inactivity_band ORDER BY avg_service_calls DESC;
-- Q20: Digital ratio by branch usage
SELECT CASE
 WHEN monthly_branch_visits=0 THEN '0 visits'
 WHEN monthly_branch_visits<=3 THEN '1-3 visits'
 ELSE '4+ visits' END AS branch_usage_band,
 COUNT(*) AS customers,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio
 FROM customers_clean GROUP BY branch_usage_band ORDER BY avg_digital_ratio DESC;
-- Q21: Customers by K-Means segment
SELECT segment_name, COUNT(*) AS customers,
 ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM customer_segments),2) AS share_pct
 FROM customer_segments GROUP BY segment_name ORDER BY customers DESC;
-- Q22: Financial profile by segment
SELECT segment_name,
 ROUND(AVG(annual_income),2) AS avg_income,
 ROUND(AVG(account_balance),2) AS avg_balance,
 ROUND(AVG(credit_limit),2) AS avg_credit_limit,
 ROUND(AVG(investment_amount),2) AS avg_investment
 FROM customer_segments GROUP BY segment_name ORDER BY avg_income DESC;
-- Q23: Transaction activity by segment
SELECT segment_name,
 ROUND(AVG(monthly_transaction_count),2) AS avg_txn_count,
 ROUND(AVG(monthly_transaction_amount),2) AS avg_txn_amount
 FROM customer_segments GROUP BY segment_name ORDER BY avg_txn_count DESC;
-- Q24: Digital activity by segment
SELECT segment_name,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio,
 ROUND(AVG(upi_transaction_share),3) AS avg_upi_share
 FROM customer_segments GROUP BY segment_name ORDER BY avg_digital_ratio DESC;
-- Q25: Credit dependence by segment
SELECT segment_name,
 ROUND(AVG(credit_utilization_ratio),3) AS avg_utilization,
 ROUND(AVG(loan_to_income_ratio),3) AS avg_loan_to_income,
 ROUND(AVG(emi_to_monthly_income_ratio),3) AS avg_emi_to_income
 FROM customer_segments GROUP BY segment_name ORDER BY avg_utilization DESC;
-- Q26: Investment penetration by segment
SELECT segment_name,
 ROUND(100.0*AVG(CASE WHEN investment_amount>0 THEN 1.0 ELSE 0.0 END),2) AS investment_penetration_pct
 FROM customer_segments GROUP BY segment_name ORDER BY investment_penetration_pct DESC;
-- Q27: High-balance inactive customers by segment
WITH t AS (SELECT AVG(account_balance) AS avg_balance FROM customer_segments)
 SELECT segment_name, COUNT(*) AS customers
 FROM customer_segments, t
 WHERE account_balance>t.avg_balance AND months_inactive_12_mon>=6
 GROUP BY segment_name ORDER BY customers DESC;
-- Q28: Relationship depth by segment
SELECT segment_name,
 ROUND(AVG(total_relationship_count),2) AS avg_relationship_count
 FROM customer_segments GROUP BY segment_name ORDER BY avg_relationship_count DESC;
-- Q29: Card mix within each segment using a window function
SELECT segment_name, card_category, COUNT(*) AS customers,
 ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER (PARTITION BY segment_name),2) AS within_segment_pct
 FROM customer_segments GROUP BY segment_name, card_category
 ORDER BY segment_name, customers DESC;
-- Q30: High-balance / low-digital customers
SELECT customer_id, account_balance, digital_transaction_ratio, monthly_branch_visits
 FROM customer_segments
 WHERE account_balance>(SELECT AVG(account_balance) FROM customer_segments)
 AND digital_transaction_ratio<0.30
 ORDER BY account_balance DESC LIMIT 25;
-- Q31: Segments above overall averages on income and activity
SELECT segment_name,
 ROUND(AVG(annual_income),2) AS avg_income,
 ROUND(AVG(monthly_transaction_count),2) AS avg_txn_count
 FROM customer_segments
 GROUP BY segment_name
 HAVING AVG(annual_income)>(SELECT AVG(annual_income) FROM customer_segments)
 AND AVG(monthly_transaction_count)>(SELECT AVG(monthly_transaction_count) FROM customer_segments)
 ORDER BY avg_income DESC;
-- Q32: Digital vs physical banking by segment
SELECT segment_name,
 ROUND(AVG(digital_transaction_ratio),3) AS avg_digital_ratio,
 ROUND(AVG(monthly_branch_visits),2) AS avg_branch_visits,
 ROUND(AVG(monthly_cash_withdrawals),2) AS avg_cash_withdrawals
 FROM customer_segments GROUP BY segment_name
 ORDER BY avg_digital_ratio DESC;