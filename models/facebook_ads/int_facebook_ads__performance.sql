SELECT S.campaign_name, S.adset_id, S.adset_name, A.ad_id,A.ad_name, 
A.date, COALESCE(A.impressions,0) AS impressions, COALESCE(A.clicks,0) AS clicks, COALESCE(A.ctr,0) ctr, COALESCE(A.cpc,0) cpc, COALESCE(A.spend,0) spend
FROM {{ ref('stg_facebook_ads__ad') }} A
LEFT JOIN {{ ref('stg_facebook_ads__ad_history') }} H
ON H.id::VARCHAR=A.ad_id
LEFT JOIN {{ ref('stg_facebook_ads__ad_set') }} S
ON S.adset_id=H.ad_set_id::VARCHAR