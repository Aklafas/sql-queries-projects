-- 4_monthly_reach_growth.sql
WITH  monthly_reach AS (
    SELECT 
	DATE_TRUNC('month', t.ad_date) :: DATE AS month,
	t.campaign_key,
	SUM(t.reach) AS total_reach
    FROM (
	SELECT
	    ad_date,
	    campaign_id :: TEXT AS campaign_key,
	    reach
	FROM facebook_ads_basic_daily
		
	UNION ALL
		
	SELECT
	    ad_date,
	    campaign_name :: TEXT AS campaign_key,
	    reach
	FROM google_ads_basic_daily
	) AS t
	GROUP BY 1, 2
	HAVING DATE_TRUNC('month', t.ad_date) :: DATE IS NOT NULL
), 
reach_diff AS (
    SELECT
	m1.campaign_key,
	m1.month,
	m1.total_reach - COALESCE(m2.total_reach, 0) AS  diff
    FROM monthly_reach AS m1
    LEFT JOIN monthly_reach AS m2
	ON m1.campaign_key = m2.campaign_key
	AND m1.month = m2.month + INTERVAL '1 month'
)
SELECT
    campaign_key,
    month,
    diff
FROM reach_diff 
ORDER BY 3 DESC
LIMIT 1;
