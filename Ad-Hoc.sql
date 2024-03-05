SELECT DISTINCT promo_type, product_name, (base_price)
FROM sales 
WHERE base_price > 500 AND promo_type = "BOGOF";




SELECT city as City, 
       COUNT(store_id) AS Store_Count
FROM dim_stores
GROUP BY city 
ORDER BY COUNT(store_id) DESC;




SELECT campaign_name as "Campaign name",
	   ROUND(SUM(revenue_before_promo) / 1000000, 2) AS "Revenue before promo_(in Mn)",
       ROUND(SUM(revenue_after_promo) / 1000000, 2) AS "Revenue after promo_(in Mn)"
FROM sales
GROUP BY campaign_name; 


      
WITH cte AS
(
    SELECT category,
		   ROUND(((SUM(ISU) / SUM(quantity_sold_before_promo))*100), 2) AS `ISU%`
    FROM sales
    WHERE campaign_name='Diwali'
    GROUP BY category
)
SELECT *,
       RANK() OVER(ORDER BY `ISU%` DESC) AS Rank_order
FROM cte
ORDER BY `ISU%` DESC;



SELECT product_name, category,
	   ROUND(((SUM(IR) / SUM(revenue_before_promo))*100), 2) as 'IR%',
       RANK () OVER( ORDER BY((SUM(IR) / SUM(revenue_before_promo))*100) DESC ) AS Rank_order
FROM sales
GROUP BY product_name, category
ORDER BY 'IR%'
LIMIT 5;