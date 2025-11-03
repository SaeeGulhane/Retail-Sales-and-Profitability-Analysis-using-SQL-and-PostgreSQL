
select * from walmart;

--Q1. Which city generated the highest total sales revenue?--
SELECT city,
       SUM(unit_price * quantity) AS total_revenue
FROM walmart
GROUP BY city
ORDER BY total_revenue DESC;

--Q2. Which product categories have the highest average profit margins?--
SELECT category,
       AVG(profit_margin) AS avg_profit_margin
FROM walmart
GROUP BY category
ORDER BY avg_profit_margin DESC;

--Q3. What is the average customer rating for each payment method?--
SELECT 
    payment_method,
    ROUND(AVG(rating)::numeric, 2) AS avg_rating
FROM walmart
GROUP BY payment_method
ORDER BY avg_rating DESC;

--Q4. What is the total quantity sold per category in each branch?--
SELECT branch,
       category,
       SUM(quantity) AS total_quantity
FROM walmart
GROUP BY branch, category
ORDER BY branch, total_quantity DESC;

--Q5. Which branch has the highest total profit?--
SELECT branch,
       SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY branch
ORDER BY total_profit DESC;

--Q6. Which three categories generated the highest revenue overall?--
SELECT category,
       SUM(unit_price * quantity) AS total_revenue
FROM walmart
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 3;

--Q7. How many transactions were recorded in each city?--
SELECT 
    city,
    COUNT(invoice_id) AS total_transactions
FROM walmart
GROUP BY city
ORDER BY total_transactions DESC;

--Q8.During which hour of the day do most sales occur across all branches?--
SELECT 
    EXTRACT(HOUR FROM time::time) AS sale_hour,
    COUNT(invoice_id) AS total_transactions
FROM walmart
GROUP BY sale_hour
ORDER BY total_transactions DESC
LIMIT 1;

--Q9. Which product category generates the highest total profit in each city?--
SELECT city, category, total_profit
FROM (
    SELECT 
        city,
        category,
        ROUND(SUM(unit_price * quantity * profit_margin)::numeric, 2) AS total_profit,
        RANK() OVER (PARTITION BY city ORDER BY SUM(unit_price * quantity * profit_margin) DESC) AS rnk
    FROM walmart
    GROUP BY city, category
) ranked
WHERE rnk = 1;

--Q10. Which payment method contributes the most to total sales revenue?--
SELECT 
    payment_method,
    ROUND(SUM(unit_price * quantity)::numeric, 2) AS total_revenue
FROM walmart
GROUP BY payment_method
ORDER BY total_revenue DESC;








