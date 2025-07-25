WITH facebook AS (
  SELECT 
    CAST(date AS DATE) AS date,
    'facebook' AS platform,
    campaign_name,
    adset_name AS ad_group_name,
    ad_name,
    COALESCE(impressions,0) AS impressions,
    COALESCE(clicks,0) AS clicks,
    COALESCE(spend,0) AS spent,
    COALESCE(ctr,0) AS ctr,
    COALESCE(cpc,0) AS cpc
  FROM {{ ref('int_facebook_ads__performance') }}
),

google AS (
  SELECT 
    CAST(date AS DATE) AS date,
    'google' AS platform,
    campaign_name,
    ad_group_name,
    CAST(ad_id AS VARCHAR) AS ad_name,
    COALESCE(impressions,0) AS impressions,
    COALESCE(clicks,0) AS clicks,
    COALESCE(spend,0) AS spent,
    COALESCE(ctr,0) AS ctr,
    COALESCE(cpc,0) AS cpc
  FROM {{ ref('int_google_ads__performance') }}
),

linkedin AS (
  SELECT 
    CAST(date AS DATE) AS date,
    'linkedin' AS platform,
    campaign_name,
    campaign_group_name AS ad_group_name,
    creative_name AS ad_name,
    COALESCE(impressions,0) AS impressions,
    COALESCE(clicks,0) AS clicks,
    COALESCE(spend,0) AS spent,
    COALESCE(ctr,0) AS ctr,
    COALESCE(cpc,0) AS cpc
  FROM {{ ref('int_linkedin_ads__performance') }}
)
SELECT * FROM facebook
UNION ALL
SELECT * FROM google
UNION ALL
SELECT * FROM linkedin