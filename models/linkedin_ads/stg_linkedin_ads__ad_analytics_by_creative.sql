SELECT creative_id, day AS date,impressions, clicks,cost_in_usd
FROM {{ source('linkedin_ads', 'ad_analytics_by_creative') }}