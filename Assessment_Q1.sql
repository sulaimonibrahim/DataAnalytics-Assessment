## Question One: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
WITH customer_products AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
        COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
        ROUND(SUM(s.new_balance) / 100, 2) AS total_deposits_naira  -- Convert from kobo to Naira and round to 2 decimals
    FROM 
        users_customuser u
    JOIN 
        plans_plan p ON u.id = p.owner_id
    JOIN 
        savings_savingsaccount s ON p.id = s.plan_id
    WHERE 
        p.is_archived = 0 
        AND p.is_deleted = 0
    GROUP BY 
        u.id, u.first_name, u.last_name
    HAVING 
        COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) >= 1
        AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) >= 1
)

SELECT 
    customer_id,
    name,
    savings_count,
    investment_count,
    total_deposits_naira AS total_deposits
FROM 
    customer_products
ORDER BY 
    total_deposits_naira DESC;