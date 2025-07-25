WITH numbered_campaign_group_history AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY _fivetran_synced DESC) AS rn
  FROM {{ source('linkedin_ads', 'campaign_group_history') }}
), latest_campaign_group_history AS(
SELECT id AS campaign_group_id, name AS campaign_group_name
FROM numbered_campaign_group_history
WHERE rn = 1
)
select * from latest_campaign_group_history