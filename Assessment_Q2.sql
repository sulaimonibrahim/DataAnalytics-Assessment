## Question Two: Calculate the average number of transactions per customer per month and categorize them:
##"High Frequency" (≥10 transactions/month)
##"Medium Frequency" (3-9 transactions/month)
##"Low Frequency" (≤2 transactions/month)

WITH monthly_transactions AS (
  -- Count transactions per customer per month
  SELECT 
    owner_id,
    DATE_FORMAT(created_on, '%Y-%m-01') AS month,  -- Groups by year-month
    COUNT(*) AS transaction_count
  FROM savings_savingsaccount
  WHERE created_on IS NOT NULL  -- Ensure valid timestamps
  GROUP BY owner_id, DATE_FORMAT(created_on, '%Y-%m-01')
),

customer_frequency AS (
  -- Calculate avg transactions/month per customer
  SELECT 
    owner_id,
    AVG(transaction_count) AS avg_transactions_per_month,
    CASE
      WHEN AVG(transaction_count) >= 10 THEN 'High Frequency'
      WHEN AVG(transaction_count) BETWEEN 3 AND 9 THEN 'Medium Frequency'
      ELSE 'Low Frequency'
    END AS frequency_category
  FROM monthly_transactions
  GROUP BY owner_id
)

-- Final output
SELECT 
  frequency_category,
  COUNT(owner_id) AS customer_count,
  ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM customer_frequency
GROUP BY frequency_category
ORDER BY 
  CASE frequency_category
    WHEN 'High Frequency' THEN 1
    WHEN 'Medium Frequency' THEN 2
    ELSE 3
  END;