# ICICI Deputy Manager-II — Project Viva Notes

## 30-second explanation
"I built a retail-banking customer segmentation project using 100,000 synthetic customer records. I cleaned the data, used SQL to answer business questions, engineered four business dimensions, applied weighted K-Means clustering, profiled the resulting segments, and built a Power BI dashboard."

## Why K-Means?
"It is unsupervised learning, so it fits a problem where customer segment labels are not known in advance."

## Why standardize?
"K-Means uses distance, so standardization prevents variables with larger numerical scales from dominating."

## Why unequal weights?
"Different variables represent different banking dimensions. I therefore used business-oriented weighted indices rather than treating every raw field equally."

## Why not demographics?
"Gender, City Tier and Occupation are kept for descriptive profiling, not as primary clustering inputs."

## Why synthetic data?
"Real customer-level bank data is confidential, so I created synthetic data with skew, correlations and noise for an educational case study."

## Segment interpretation
Prime Engaged — higher financial capacity and strong activity.
Digital Active — strong digital and transaction engagement.
Credit Active — higher credit dependence with active behavior.
Affluent Under-Engaged — higher financial capacity with weaker recent activity.
