SELECT S.date,G.campaign_id,G.campaign_name,G.ad_group_id,G.ad_group_name, S.ad_id,S.impressions, SUM(S.clicks) clicks,
COALESCE(SUM(S.clicks)/NULLIF((S.impressions),0),0) ctr,COALESCE(SUM(S.spend/1000000)/NULLIF(SUM(S.clicks),0),0) cpc, 
COALESCE(SUM(S.spend/1000000),0) spend
FROM {{ ref('stg_google_ads__ad_stats') }} S
LEFT JOIN {{ ref('stg_google_ads__group_history') }} G 
ON G.ad_group_id=S.ad_group_id
GROUP BY S.date,G.campaign_id,G.campaign_name,G.ad_group_id,G.ad_group_name, S.ad_id,S.impressions
