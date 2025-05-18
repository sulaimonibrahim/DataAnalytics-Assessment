# DataAnalytics-Assessment
This is a financial platform analytics

# Data Analyst Assessment

## Overview
This project provides key insights into customer behavior and account activity through four analytical queries. The analysis uses the `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables to identify valuable customer segments, transaction patterns, dormant accounts, and customer lifetime value.

---

## Question 1: High-value Customers and Multi-Products

### Objective
Identify customers who have both savings and investment products, sorted by total deposits.

### Solution Approach
- Joined user data with plan and savings account information.
- Used conditional counting to identify customers with:
  - At least one regular savings plan (`is_regular_savings = 1`)
  - At least one investment fund (`is_a_fund = 1`)
- Converted balances from kobo to Naira.
- Sorted by total deposits in descending order.
- Filtered out archived/deleted plans for accuracy.

### Key Insights
- Reveals high-value customers using multiple products.
- Helps in identifying cross-selling opportunities.

---

## Question 2: Transaction Frequency Analysis

### Objective
Categorize customers by their monthly transaction activity.

### Solution Approach
- Calculated transactions per customer per month.
- Grouped transactions by year-month using `DATE_FORMAT`.
- Categorized transaction frequency into:
  - **High Frequency**: ≥10 transactions/month
  - **Medium Frequency**: 3–9 transactions/month
  - **Low Frequency**: ≤2 transactions/month
- Used `created_on` as a proxy for transaction timestamp.

### Key Insights
- Helps distinguish active users from occasional ones.
- Useful for tailoring engagement and retention strategies.

---

## Question 3: Dormant but Active Accounts

### Objective
Find active accounts with no recent transaction for close to a year.

### Solution Approach
- Joined plan and savings account data.
- Filtered for active (non-deleted) accounts.
- Calculated days since last transaction using `transaction_date`.
- Identified accounts with ≥365 days of inactivity.

### Key Insights
- Highlights at-risk customer relationships.
- Enables proactive re-engagement strategies.
- Separated savings from investment accounts for clearer insights.

---

## Question 4: Customer Lifetime Value Estimation

### Objective
Estimate Customer Lifetime Value (CLV) based on transaction activity and tenure.

### Solution Approach
- Converted all monetary amounts from kobo to Naira.
- Used monthly averages and applied the CLV formula to derive `estimated_clv`.
- Excluded new customers where tenure = 0 for more accurate results.

### Key Insights
- Identifies the most valuable long-term customers.
- Useful for strategic customer retention and loyalty programs.

---

## Implementation Challenges

- **Data limitations and ambiguities**:
  - Confusing `id` columns across tables.
  - Uncertainty around which `amount` fields to use.
  - Lack of confirmed transaction counts in some areas.
- **Documentation**:
  - More detailed and clearer dataset documentation would have improved analysis.

---

## How To Run

Execute the SQL queries sequentially from Question 1 to Question 4. Each query provides insights that build upon the previous analysis for a comprehensive understanding of customer behavior and financial activity.

---
