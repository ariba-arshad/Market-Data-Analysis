WITH numbered_creative_history AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY _fivetran_synced DESC) AS rn
  FROM {{ source('linkedin_ads', 'creative_history') }}
), latest_creative_history AS(
SELECT id AS creative_id, name AS creative_name,campaign_id
FROM numbered_creative_history
WHERE rn = 1
)
select * from latest_creative_history