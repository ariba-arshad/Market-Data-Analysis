-- This model is used to connect ad with ad_set on ad_set_id
WITH numbered_ad_history AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY _fivetran_synced DESC) AS rn
  FROM {{ source('facebook_ads', 'ad_history') }}
), latest_ad_history AS(
SELECT id, ad_set_id
FROM numbered_ad_history
WHERE rn = 1
)
SELECT * FROM latest_ad_history