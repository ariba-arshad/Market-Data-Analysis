SELECT ad_id,date,impressions,inline_link_clicks AS clicks,ctr,cpc,spend,
ad_name,adset_name 
FROM {{ source('facebook_ads', 'basic_ad') }}