{{
  custom_config(
    alias=var('tiktok_ad_performance_v1_alias','tiktok-ad_performance-v1'),
    field="date")
}}

WITH
  advertiser_info AS (
  SELECT
    DISTINCT ad_id,
    advertiser_id,
    name advertiser_name
  FROM
    {{ source('tiktok', 'ad_history') }} A
  LEFT JOIN (
    SELECT
      DISTINCT id,
      name
    FROM
      {{ source('tiktok', 'advertiser') }} ) B
  ON
    A.advertiser_id=B.id )

SELECT
  SAFE_CAST( stat_time_day AS DATE ) date,
  SAFE_CAST( ad_id AS STRING ) ad_id,
  SAFE_CAST( ad_name AS STRING ) ad_name,
  SAFE_CAST( adgroup_name AS STRING ) adgroup_name,
  SAFE_CAST( currency AS STRING ) advertiser_currency,
  SAFE_CAST( advertiser_id AS STRING ) advertiser_id,
  SAFE_CAST( advertiser_name AS STRING ) advertiser_name,
  SAFE_CAST( campaign_id AS STRING ) campaign_id,
  SAFE_CAST( campaign_name AS STRING ) campaign_name,
  SAFE_CAST( stat_time_day AS STRING ) stat_time_day,
  SAFE_CAST( button_click AS STRING ) button_click,
  SAFE_CAST( clicks AS STRING ) clicks,
  SAFE_CAST( conversion AS STRING ) conversion,
  SAFE_CAST( follows AS STRING ) follows,
  SAFE_CAST( frequency AS STRING ) frequency,
  SAFE_CAST( impressions AS STRING ) impressions,
  SAFE_CAST( likes AS STRING ) likes,
  SAFE_CAST( reach AS STRING ) reach,
  SAFE_CAST( spend AS STRING ) spend,
  SAFE_CAST( total_purchase AS STRING ) total_purchase,
  SAFE_CAST( total_purchase_value AS STRING ) total_purchase_value,
  SAFE_CAST( video_play_actions AS STRING ) video_play_actions,
  SAFE_CAST( video_views_p_100 AS STRING ) video_views_p100,
  SAFE_CAST( video_views_p_25 AS STRING ) video_views_p25,
  SAFE_CAST( video_views_p_50 AS STRING ) video_views_p50,
  SAFE_CAST( video_views_p_75 AS STRING ) video_views_p75,
  SAFE_CAST( video_watched_2_s AS STRING ) video_watched_2s,
  SAFE_CAST( video_watched_6_s AS STRING ) video_watched_6s,
  {{ add_custom_fields() }},
  {{ null_non_existing_fields }}
FROM
  {{ source('tiktok', 'tiktok_ad_performance_v_1') }}
LEFT JOIN (
  SELECT * FROM advertiser_info
)
USING (ad_id)