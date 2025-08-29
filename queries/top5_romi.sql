-- 2_top5_romi.sql
SELECT
    ad_date,
    ROUND((SUM(value) - SUM(spend)) / NULLIF(SUM(spend), 0), 4) AS romi
FROM (
    SELECT
	ad_date,
	CAST(NULLIF(spend, 0) AS NUMERIC) AS spend,
	CAST(NULLIF(value, 0) AS NUMERIC) AS value
    FROM facebook_ads_basic_daily
	
    UNION ALL
	
    SELECT
	ad_date,
	CAST(NULLIF(spend, 0) AS NUMERIC) AS spend,
	CAST(NULLIF(value, 0) AS NUMERIC) AS value
    FROM google_ads_basic_daily
) AS top_romi
GROUP BY 1
HAVING SUM(spend) > 0 AND SUM(value) > 0
ORDER BY romi DESC
LIMIT 5;
