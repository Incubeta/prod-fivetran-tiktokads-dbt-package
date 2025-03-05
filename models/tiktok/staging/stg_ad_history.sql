with ad_history as (
  select 
    ad_id, 
    advertiser_id,
    from {{source('tiktok', 'ad_history')}}
    QUALIFY RANK() over(PARTITION BY ad_id order by updated_at DESC ) = 1
)

select ad_id,
SAFE_CAST(advertiser_id as STRING) as advertiser_id
 from ad_history
