-- Purchase via Cart
SELECT
  category_code,
  brand,
  COUNT(CASE WHEN view_count > 0 THEN 1 END) AS Views,
  COUNT(CASE 
           WHEN view_count > 0 AND cart_count > 0 THEN 1 
         END) AS Cart,
  COUNT(CASE 
           WHEN view_count > 0 AND cart_count > 0 AND purchase_count > 0 THEN 1 
         END) AS Purchase
FROM (
    SELECT 
      user_session,
      category_code,
      brand,
      SUM(event_type = 'View')     AS view_count,
      SUM(event_type = 'cart')     AS cart_count,
      SUM(event_type = 'purchase') AS purchase_count
    FROM ecomm_data
    GROUP BY user_session, category_code, brand
) AS session_stats
GROUP BY category_code, brand
ORDER BY Purchase DESC;