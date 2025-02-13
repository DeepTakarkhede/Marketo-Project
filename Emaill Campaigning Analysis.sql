use email_marketing_analysis;

# EMAIL DELIVERY RATE
SELECT 
    (COUNT(CASE WHEN Activity_Type = 'Delivered' THEN 1 END) * 100.0) / 
    (SELECT COUNT(Email_ID) FROM activity) AS Email_Delivery_Rate
FROM activity;

# OPEN RATE
SELECT 
    (COUNT(CASE WHEN Activity_Type = 'Open' THEN 1 END) * 100.0) / 
    NULLIF(COUNT(CASE WHEN Activity_Type = 'Delivered' THEN 1 END), 0) AS Open_Rate
FROM activity;

# CLICK THROUGH RATE (CTR)
SELECT 
    (COUNT(CASE WHEN Activity_Type = 'Click' THEN 1 END) * 100.0) / 
    NULLIF(COUNT(CASE WHEN Activity_Type = 'Open' THEN 1 END), 0) AS CTR
FROM activity;

# CAMPAIGN ENGAGEMENT RATE
SELECT 
    Campaign_ID, 
    (COUNT(Activity_ID) * 100.0) / (SELECT COUNT(*) FROM activity) AS Engagement_Rate
FROM activity
JOIN emails ON activity.Email_ID = emails.Email_ID
GROUP BY Campaign_ID;

# TOP PERFORMING CAMPAIGNS
SELECT 
    c.Campaign_Name, 
    COUNT(a.Activity_ID) AS Total_Engagements
FROM activity a
JOIN emails e ON a.Email_ID = e.Email_ID
JOIN campaign c ON e.Campaign_ID = c.Campaign_ID
GROUP BY c.Campaign_Name
ORDER BY Total_Engagements DESC
LIMIT 10;

# AVERAGE ACTIVITY PER EMAIL
SELECT 
    COUNT(Activity_ID) * 1.0 / (SELECT COUNT(DISTINCT Email_ID) FROM emails) AS Avg_Activity_Per_Email
FROM activity;

# ACTIVITY BREAKDOWN BY TYPE
SELECT 
    Activity_Type, 
    COUNT(Activity_ID) AS Activity_Count,
    (COUNT(Activity_ID) * 100.0) / (SELECT COUNT(*) FROM activity) AS Percentage
FROM activity
GROUP BY Activity_Type;

# EMAILS SENT VS ACTIVITY TIMELINE
SELECT 
    IFNULL(e.Email_Sent_Date, a.Activity_Date) AS Date, 
    COUNT(Distinct e.Email_ID) AS Emails_Sent, 
    COUNT(a.Activity_ID) AS Activities_Per_Day
FROM emails e
LEFT JOIN Activity a ON e.Email_ID = a.Email_ID
GROUP BY IFNULL  (e.Email_Sent_Date, a.Activity_Date)
ORDER BY Date;

