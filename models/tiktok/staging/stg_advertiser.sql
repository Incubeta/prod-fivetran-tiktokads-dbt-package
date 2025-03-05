with advertiser as (
  select id,
  name as advertiser_name
  from {{source('tiktok', 'advertiser')}}
)

select * from advertiser

