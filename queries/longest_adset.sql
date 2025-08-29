-- 5_longest_adset.sql
WITH all_data AS (
    SELECT 
    	f.ad_date, 
    	fa.adset_name AS adset_name, 
    	'Facebook' :: TEXT AS source
    FROM facebook_ads_basic_daily AS f
    LEFT JOIN facebook_adset AS fa
    	ON f.adset_id = fa.adset_id
    
    UNION ALL
    
    SELECT 
    	ad_date, 
    	adset_name, 
    	'Google' :: TEXT AS source
    FROM google_ads_basic_daily
),
row_table AS (
    SELECT
        adset_name,
        source,
        ad_date,
        ad_date - ROW_NUMBER() OVER (PARTITION BY adset_name, source ORDER BY ad_date) :: INTEGER * INTERVAL '1 day' AS grp
    FROM all_data
),
grouped_table AS (
    SELECT
        adset_name,
        source,
        MIN(ad_date) AS first_date,
        MAX(ad_date) AS last_date,
        COUNT(*) AS days_count
    FROM row_table
    GROUP BY 1, 2, grp
)
SELECT 
    adset_name,
    source, 
    first_date, 
    last_date, 
    days_count
FROM grouped_table
ORDER BY days_count DESC
LIMIT 1;
