with advertiser_info as (
  select * from {{ref('int_advertiser_info')}}
),
report as (
  select *
    from {{ref('stg_ad_performance-v1')}}
  )
SELECT 
        {{dbt_utils.generate_surrogate_key(["day", "report.ad_id", "advertiser_id", "campaign_id"])}} as unique_id,
  report.*,
  advertiser_info.advertiser_id,
  advertiser_info.advertiser_name

-- exchange rates should be used in client project  (SAFE_CAST(spend AS FLOAT64) / source_b.ex_rate) _gbp_cost,
-- (SAFE_CAST(total_purchase_value AS FLOAT64) / source_b.ex_rate) _gbp_revenue,


FROM
  report
LEFT JOIN advertiser_info
on report.ad_id = SAFE_CAST(advertiser_info.ad_id as STRING)
