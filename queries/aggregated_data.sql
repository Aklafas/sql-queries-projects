-- 1_aggregated_data.sql
SELECT
    ad_date,
    source,
    AVG(spend) AS avg_spend,
    MAX(spend) AS max_spend,
    MIN(spend) AS min_spend,
    AVG(impressions) AS avg_impressions,
    MAX(impressions) AS max_impressions,
    MIN(impressions) AS min_impressions,
    AVG(reach) AS avg_reach,
    MAX(reach) AS max_reach,
    MIN(reach) AS min_reach,
    AVG(clicks) AS avg_clicks,
    MAX(clicks) AS max_clicks,
    MIN(clicks) AS min_clicks,
    AVG(leads) AS avg_leads,
    MAX(leads) AS max_leads,
    MIN(leads) AS min_leads,
    AVG(value) AS avg_value,
    MAX(value) AS max_value,
    MIN(value) AS min_value
FROM (
    SELECT
	ad_date, 
	'Facebook' :: TEXT AS source,
	spend, 
	impressions, 
	reach, 
	clicks, 
	leads, 
	value
    FROM facebook_ads_basic_daily
	
    UNION ALL
	
    SELECT 
	ad_date,
	'Google' :: TEXT AS platform,
	spend, 
	impressions, 
	reach, 
	clicks, 
	leads, 
	value
    FROM google_ads_basic_daily
) AS agr_table
GROUP BY 1, 2
ORDER BY 1, 2;
