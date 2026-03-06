CREATE DATABASE Business_analysis;
USE Business_analysis;

# INSIGHTS QUESTIONS (QUALITATIVE)
-- 1. Which product categories generate the most revenue?
SELECT 
    Product_Category, SUM(Revenue) AS Total_Revenue
FROM
    business_analysis.business_analytics_dataset_10000_rows
GROUP BY Product_Category
ORDER BY Total_Revenue DESC;
#INSIGHT RESULT
-- Electronics generated the highest revenue among all product categories, closely followed by Beauty and Sports products.

-- 2. Which region contributes the highest sales?
SELECT 
    Region, SUM(Revenue) AS Total_Revenue
FROM
    business_analysis.business_analytics_dataset_10000_rows
GROUP BY Region
ORDER BY Total_Revenue DESC;
#INSIGHT RESULT 
-- The North region generates the highest total revenue among all regions, indicating strong market performance in that area.

-- 3. Which customer segment generates the most revenue?
SELECT 
    Customer_Segment, SUM(Revenue) AS Total_Revenue
FROM
    business_analysis.business_analytics_dataset_10000_rows
GROUP BY Customer_Segment
ORDER BY Total_Revenue DESC;
#INSIGHT RESULT
-- The Corporate segment generates the highest revenue among all customer segments, although the difference between segments is relatively small

-- 4. Which payment methods are most commonly used?
SELECT 
    payment_method, COUNT(*) AS total_transactions
FROM
    business_analysis.business_analytics_dataset_10000_rows
GROUP BY payment_method
ORDER BY total_transactions DESC;
#INSIGHT RESULT
-- Debit Card is the most frequently used payment method, followed closely by Cash on Delivery and UPI.

-- 5. How do discounts affect profit?
SELECT 
    Discount_Rate, AVG(profit) AS avg_profit
FROM
    business_analysis.business_analytics_dataset_10000_rows
GROUP BY Discount_Rate
ORDER BY avg_profit;
#INSIGHT RESULT
-- Higher discounts are associated with lower average profits, indicating that aggressive discounting may negatively impact profitability.

-- 6. How do customer segments rank based on total revenue contribution?
SELECT 
    customer_segment,
    SUM(revenue) AS total_revenue,
    RANK() OVER(ORDER BY SUM(revenue) DESC) AS segment_rank
FROM business_analysis.business_analytics_dataset_10000_rows
GROUP BY customer_segment;
#INSIGHT RESULT 
-- Although Corporate customers generate the highest revenue, the difference between the three segments is minimal, indicating a balanced revenue distribution across all customer groups.

-- 7. Which transactions generate above-average revenue?
WITH Avg_Rev AS (
    SELECT AVG(Revenue) AS avg_Revenue
    FROM business_analysis.business_analytics_dataset_10000_rows
)
SELECT *
FROM business_analysis.business_analytics_dataset_10000_rows
WHERE revenue > (SELECT avg_Revenue FROM Avg_Rev);
#INSIGHT RESULT 
-- Several transactions generate revenue above the dataset's average revenue, indicating the presence of high-value orders that significantly contribute to overall business performance.

#CREATE VIEW 
CREATE VIEW category_performance AS
SELECT 
    product_category,
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit
FROM business_analysis.business_analytics_dataset_10000_rows
GROUP BY product_category;

SELECT *
FROM category_performance
ORDER BY total_revenue DESC;

#INSIGHT RESULT 
-- Electronics generates the highest total revenue and profit among all product categories, closely followed by Beauty and Sports. This indicates strong customer demand and profitability within these categories.
