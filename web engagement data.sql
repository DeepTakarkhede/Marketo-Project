use web_engagement_analysis;

# TOTAL UNIQUE VISITORS

SELECT SUM(`Unique Visitors`) AS Total_unique_visitors
FROM web_engagement_data;

# AVERAGE BOUNCE RATE
SELECT ROUND(AVG(`Bounce Rate (%)`), 2) AS avg_bounce_rate
FROM web_engagement_data;

# AVERAGE SESSION DURATION
SELECT ROUND(AVG(`Avg Session Duration (min)`), 2) AS avg_session_duration
FROM web_engagement_data;

# TRAFFIC SOURCE BREAKDOWN
SELECT `Traffic Source`, COUNT(*) AS visit_count
FROM web_engagement_data
GROUP BY `Traffic Source`
ORDER BY visit_count DESC;

# DEVICE USAGE SHARE
SELECT `Device Type`, COUNT(*) AS visit_count,
       ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(), 2) AS percentage_share
FROM web_engagement_data
GROUP BY `Device Type`
ORDER BY visit_count DESC;

# TOP 5 REGIONS BY UNIQUE VISITORS
SELECT region, SUM(DISTINCT `Unique Visitors`) AS unique_visitors
FROM web_engagement_data
GROUP BY Region
ORDER BY unique_visitors DESC
LIMIT 5;

# ENGAGEMENT BY DATE ( TIME SERIES)
SELECT date engagement_date, 
       SUM(`Page Views`) AS total_page_views, 
       SUM(Distinct `Unique Visitors`) AS total_unique_visitors
FROM web_engagement_data
GROUP BY Date
ORDER BY engagement_date ASC;

SELECT Date_Format(Date , '%Y-%m') AS engagement_month, 
       SUM(`Page Views`) AS total_page_views, 
       SUM(`Unique Visitors`) AS total_unique_visitors
FROM web_engagement_data
GROUP BY engagement_month
ORDER BY engagement_month ASC;







