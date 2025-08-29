-- 3_weekly_max_value_campaign.sql
SELECT 
    DATE_TRUNC('week', f.ad_date) :: DATE AS week_date,
    c.campaign_name,
    SUM(f.value) AS total_value
FROM facebook_ads_basic_daily AS f
JOIN facebook_campaign AS c
    ON f.campaign_id = c.campaign_id
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1;
