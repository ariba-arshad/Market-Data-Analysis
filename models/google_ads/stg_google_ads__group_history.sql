WITH numbered_ad_group_history AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY _fivetran_synced DESC) AS rn
  FROM {{ source('google_ads', 'ad_group_history') }}
), latest_ad_group AS(
SELECT id AS ad_group_id, name AS ad_group_name, campaign_id, campaign_name
FROM numbered_ad_group_history
WHERE rn = 1
)
SELECT * FROM latest_ad_group