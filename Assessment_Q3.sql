## Question 3: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE(), MAX(s.transaction_date)) AS inactivity_days
FROM 
    plans_plan p
JOIN 
    ##savings_savingsaccount s ON p.owner_id = s.owner_id
        -- Plan_id in the 'savings_savingsaccount' is a foreign key to ''id in the 'plans_plan' table
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    p.is_archived = 0 
    AND p.is_deleted = 0
    AND (p.is_regular_savings = 1 OR p.is_a_fund = 1)
    AND (
        -- 1. Transaction date is not NULL
        s.transaction_date IS NOT NULL
        AND 
        -- 2. Last transaction was less than or equal to 365 days ago
        DATEDIFF(CURRENT_DATE(), s.transaction_date) <= 365
    )
GROUP BY 
    ##p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
    p.id, s.plan_id, p.is_regular_savings, p.is_a_fund
ORDER BY 
    inactivity_days DESC; 