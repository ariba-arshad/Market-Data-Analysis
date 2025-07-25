SELECT date, ad_id, ad_group_id, campaign_id, impressions, clicks, cost_micros AS spend
FROM {{ source('google_ads', 'ad_stats') }}