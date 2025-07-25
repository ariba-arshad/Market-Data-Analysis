-- we just need the latest campaign_name and adset_name from this table so dedup old rows
WITH numbered_basic_ad_set AS (
  SELECT *,
  ROW_NUMBER() OVER (PARTITION BY adset_id ORDER BY _fivetran_synced DESC) AS rn
  FROM {{ source('facebook_ads', 'basic_ad_set') }}
), latest_basic_ad_set AS(
SELECT adset_id, adset_name, campaign_name
FROM numbered_basic_ad_set
WHERE rn = 1
)

SELECT * FROM latest_basic_ad_set