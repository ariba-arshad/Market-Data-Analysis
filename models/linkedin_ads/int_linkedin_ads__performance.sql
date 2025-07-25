SELECT H.campaign_id, C.campaign_name,C.campaign_group_id,G.campaign_group_name,
H.creative_id, H.creative_name, A.date,A.impressions, A.clicks,
COALESCE(clicks/NULLIF((A.impressions),0),0) ctr,COALESCE(cost_in_usd/NULLIF(A.clicks,0),0) cpc,
A.cost_in_usd spend
FROM {{ ref('stg_linkedin_ads__ad_analytics_by_creative') }} A
LEFT JOIN {{ ref('stg_linkedin_ads__creative_history') }} H
ON H.creative_id=A.creative_id
LEFT JOIN {{ ref('stg_linkedin_ads__campaign_history') }} C
ON C.campaign_id=H.campaign_id
LEFT JOIN {{ ref('stg_linkedin_ads__campaign_group_history') }} G
ON C.campaign_group_id=G.campaign_group_id