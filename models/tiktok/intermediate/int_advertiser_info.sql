with ad_history as (
  select *
    from {{ref('stg_ad_history')}}
),
advertiser_info as (
  select * from {{ref('stg_advertiser')}}
)

select 
  ad_id,
  advertiser_id,
  advertiser_name
from ad_history
left join advertiser_info
on ad_history.advertiser_id = SAFE_CAST(advertiser_info.id as STRING)
