WITH numbered_campaign_history AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY _fivetran_synced DESC) AS rn
  FROM {{ source('linkedin_ads', 'campaign_history') }}
), latest_campaign_history AS(
SELECT id AS campaign_id, name AS campaign_name, campaign_group_id
FROM numbered_campaign_history
WHERE rn = 1
)
select * from latest_campaign_history