
with exchange_rates as (
  select *
    from {{ref('stg_openexchange_rates__openexchange_report_v1')}}
  )
SELECT 
SAFE_CAST(	date	AS	DATE	)	day	,
SAFE_CAST(	ad_id	AS	STRING	)	ad_id	,
SAFE_CAST(	ad_name	AS	STRING	)	ad_name	,
SAFE_CAST(	adgroup_name	AS	STRING	)	adgroup_name	,
SAFE_CAST(	advertiser_currency	AS	STRING	)	advertiser_currency	,
SAFE_CAST(	advertiser_id	AS	STRING	)	advertiser_id	,
SAFE_CAST(	advertiser_name	AS	STRING	)	advertiser_name	,
SAFE_CAST(	campaign_id	AS	STRING	)	campaign_id	,
SAFE_CAST(	campaign_name	AS	STRING	)	campaign_name	,
SAFE_CAST(	stat_time_day	AS	DATETIME	)	stat_time_day	,
SAFE_CAST(	button_click	AS	FLOAT64	)	button_click	,
SAFE_CAST(	clicks	AS	INT64	)	clicks	,
SAFE_CAST(	conversion	AS	FLOAT64	)	conversion	,
SAFE_CAST(	follows	AS	INT64	)	follows	,
SAFE_CAST(	frequency	AS	FLOAT64	)	frequency	,
SAFE_CAST(	impressions	AS	INT64	)	impressions	,
SAFE_CAST(	likes	AS	INT64	)	likes	,
SAFE_CAST(	reach	AS	INT64	)	reach	,
SAFE_CAST(	spend	AS	FLOAT64	)	cost	,
SAFE_CAST(	total_purchase	AS	FLOAT64	)	total_purchase	,
SAFE_CAST(	total_purchase_value	AS	FLOAT64	)	total_purchase_value	,
SAFE_CAST(	video_play_actions	AS	INT64	)	video_play_actions	,
SAFE_CAST(	video_views_p100	AS	INT64	)	video_views_p100	,
SAFE_CAST(	video_views_p25	AS	INT64	)	video_views_p25	,
SAFE_CAST(	video_views_p50	AS	INT64	)	video_views_p50	,
SAFE_CAST(	video_views_p75	AS	INT64	)	video_views_p75	,
SAFE_CAST(	video_watched_2s	AS	INT64	)	video_watched_2s	,
SAFE_CAST(	video_watched_6s	AS	INT64	)	video_watched_6s	,
'tiktok-ad_performance-v1' AS raw_origin,
(SAFE_CAST(spend AS FLOAT64) / exchange_rates.ex_rate) _gbp_cost,
(SAFE_CAST(total_purchase_value AS FLOAT64) / exchange_rates.ex_rate) _gbp_revenue,

/* Below macro creates additional fields based on form inputs for "Subaccounts, campaign delimitter, custom fields" */
{{add_fields("campaign_name")}} /* Replace with the report's campaign name field */

/* *****Please Do not remove the backticks from the query as it is essential for compiling queries with hyphen in DBT**** */

FROM {{ref('tiktok-ad_performance-v1')}} report
left join exchange_rates
on report.date = exchange_rates.day
and lower(ifnull(trim(report.advertiser_currency), '{{var('account_currency')}}')) = exchange_rates.currency_code
