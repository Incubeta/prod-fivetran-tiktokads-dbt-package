with ad_performance as (
  select * from
    {{source('tiktok', 'tiktok_ad_performance_v_1')}}
)

select 
  SAFE_CAST(stat_time_day as DATE) as day,
  SAFE_CAST(ad_id as STRING) as ad_id,
  ad_name,
  adgroup_name,
  currency as advertiser_currency,
  SAFE_CAST(campaign_id as STRING) as campaign_id,
  campaign_name,
  stat_time_day,
  SAFE_CAST(button_click as FLOAT64) as button_click,
  clicks,
  follows,
  frequency,
  impressions,
  conversion,
  likes,
  reach,
  spend as cost,
  SAFE_CAST(total_purchase as FLOAT64) as total_purchase,
  total_purchase_value,
  video_play_actions,
  video_views_p_100 as video_views_p100,
  video_views_p_25 as video_views_p25,
  video_views_p_50 as video_views_p50,
  video_views_p_75 as video_views_p75,
  video_watched_2_s as video_watched_2s,
  video_watched_6_s as video_watched_6s,
  {{add_fields("campaign_name")}}
  from ad_performance
