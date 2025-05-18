## Question Four: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
##Account tenure (months since signup)
##Total transactions
##Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
##Order by estimated CLV from highest to lowest

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_transactions_naira,  -- Kobo→Naira
    ROUND(
        (
            (SUM(s.confirmed_amount) / 100) /  -- Convert sum to Naira
            NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()), 0)
        ) * 12 * 
        (0.001 * (AVG(s.confirmed_amount) / 100)),  -- 0.1% of avg in Naira
        2
    ) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
WHERE 
    u.date_joined <= CURRENT_DATE()
    AND s.confirmed_amount > 0  -- Exclude 0-value transactions
GROUP BY 
    u.id, u.first_name, u.last_name, u.date_joined
HAVING 
    tenure_months > 0
ORDER BY 
    estimated_clv DESC;