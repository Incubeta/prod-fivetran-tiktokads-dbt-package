with advertiser_info as (
  select * from {{ref('int_advertiser_info')}}
),
report as (
  select *
    from {{ref('int_ad_performance-v1')}}
  )
SELECT 
        {{dbt_utils.generate_surrogate_key(["day", "report.ad_id", "advertiser_id", "campaign_id"])}} as unique_id,
  report.*,
  advertiser_info.advertiser_id,
  advertiser_info.advertiser_name



FROM
  report
LEFT JOIN advertiser_info
on report.ad_id = SAFE_CAST(advertiser_info.ad_id as STRING)
