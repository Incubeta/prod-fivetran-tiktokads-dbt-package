with report as (
  select *
  from {{ref('stg_ad_performance-v1')}}
),
exchange_rates as (
  select *
    from {{ref('stg_openexchange_rates__openexchange_report_v1')}}
  )
select 
  report.*,
  report.cost / exchange_rates.ex_rate as _gbp_cost,
  report.total_purchase_value / exchange_rates.ex_rate as _gbp_revenue
from report
left join exchange_rates
on report.day = exchange_rates.day
and lower(ifnull(trim(report.advertiser_currency), '{{var('account_currency')}}')) = exchange_rates.currency_code
